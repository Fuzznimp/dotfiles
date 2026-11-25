#!/usr/bin/env node
// Two modes, both fed the hook payload on stdin:
// - `edit`   (PostToolUse Write|Edit): flags the comments that the edit just added.
// - `commit` (PreToolUse Bash): blocks a `git commit` whose diff adds comments,
//   until it is rerun with COMMENTS_REVIEWED=1.

import { execFileSync } from "node:child_process";
import { readFileSync } from "node:fs";
import { dirname, join, relative } from "node:path";

const CODE_EXTENSIONS = /\.(ts|tsx|js|jsx|mjs|cjs)$/;
const DIRECTIVE = /^(\/\/|\/\*)\s*(@ts-|eslint-|oxlint-|prettier-ignore|biome-ignore|istanbul|c8 )/;

const CHECKLIST = `Review each one against programming.md "Comments", then delete it or keep it on purpose:
- Keep only non-obvious information: rationale, gotchas, edge cases, a constraint the code cannot show.
- Delete if it restates the name or the code.
- Delete edit history: "now", "previously", "changed from", "no longer", past tense about the change.
- Delete a justification of a choice just made (test: on a fresh file, would it still be worth writing?).
- A unit or measure belongs in the name (ttlInSeconds), not in a comment.
- No task names, PR or issue numbers.
- A constraint over a group goes above the group, once, not on one member or repeated inline.
- Check it is still true: a wrong comment is worse than none.`;

function readStdin() {
  return new Promise((resolve) => {
    let data = "";
    process.stdin.on("data", (chunk) => (data += chunk));
    process.stdin.on("end", () => resolve(data));
  });
}

function isCommentLine(line) {
  const trimmed = line.trim();
  if (DIRECTIVE.test(trimmed)) return false;
  if (/^(\/\/|\/\*|\*|\{\/\*)/.test(trimmed)) return true;
  return /(^|[^:"'`])\/\/\s/.test(trimmed) || /\/\*.*\*\/\s*[,;)}\]]?$/.test(trimmed);
}

function isCodeFile(filePath) {
  return (
    CODE_EXTENSIONS.test(filePath) &&
    !filePath.endsWith(".d.ts") &&
    !filePath.includes("/node_modules/")
  );
}

function git({ cwd, args }) {
  try {
    return execFileSync("git", args, { cwd, encoding: "utf8", stdio: ["ignore", "pipe", "ignore"] });
  } catch {
    return null;
  }
}

function readCommittedLines(filePath) {
  const cwd = dirname(filePath);
  const root = git({ cwd, args: ["rev-parse", "--show-toplevel"] })?.trim();
  if (!root) return new Set();
  const content = git({ cwd: root, args: ["show", `HEAD:${relative(root, filePath)}`] });
  return new Set((content ?? "").split("\n").map((line) => line.trim()));
}

function findAddedCommentsInEdit(payload) {
  const input = payload.tool_input ?? {};
  const filePath = input.file_path ?? "";
  if (!isCodeFile(filePath)) return [];

  if (payload.tool_name === "Write") {
    const committed = readCommittedLines(filePath);
    return (input.content ?? "")
      .split("\n")
      .filter((line) => isCommentLine(line) && !committed.has(line.trim()));
  }

  const edits = input.edits ?? [{ old_string: input.old_string, new_string: input.new_string }];
  return edits.flatMap(({ old_string: oldString = "", new_string: newString = "" }) => {
    const before = new Set(oldString.split("\n").map((line) => line.trim()));
    return newString.split("\n").filter((line) => isCommentLine(line) && !before.has(line.trim()));
  });
}

function resolveCommitDir({ command, cwd }) {
  const gitDash = command.match(/\bgit\s+-C\s+("?)([^"\s]+)\1/);
  if (gitDash) return gitDash[2].replace(/^~/, process.env.HOME);
  const cdPrefix = command.match(/^\s*cd\s+("?)([^"&;]+?)\1\s*&&/);
  if (cdPrefix) return cdPrefix[2].trim().replace(/^~/, process.env.HOME);
  return cwd;
}

function findCommentsInUntrackedFiles(dir) {
  const files = git({ cwd: dir, args: ["ls-files", "--others", "--exclude-standard"] }) ?? "";
  return files
    .split("\n")
    .filter((file) => file && isCodeFile(`/${file}`))
    .flatMap((file) =>
      readFileSync(join(dir, file), "utf8")
        .split("\n")
        .flatMap((line, index) => (isCommentLine(line) ? [`${file}:${index + 1}  ${line.trim()}`] : []))
    );
}

function findAddedCommentsInCommit({ command, cwd }) {
  const dir = resolveCommitDir({ command, cwd });
  const stagesInSameCommand = /\bgit\s+(-C\s+\S+\s+)?add\b/.test(command);
  const base = stagesInSameCommand ? ["diff", "HEAD"] : ["diff", "--cached"];
  const diff = git({ cwd: dir, args: [...base, "--no-color", "--no-prefix", "-U0", "--diff-filter=AM"] });
  const found = stagesInSameCommand ? findCommentsInUntrackedFiles(dir) : [];
  if (!diff) return found;

  let file = null;
  let lineNumber = 0;
  for (const line of diff.split("\n")) {
    if (line.startsWith("+++ ")) {
      file = line.replace(/^\+\+\+ /, "");
      continue;
    }
    const hunk = line.match(/^@@ -\S+ \+(\d+)/);
    if (hunk) {
      lineNumber = Number(hunk[1]);
      continue;
    }
    if (!line.startsWith("+") || !file) continue;
    const added = line.slice(1);
    if (isCodeFile(`/${file}`) && isCommentLine(added)) found.push(`${file}:${lineNumber}  ${added.trim()}`);
    lineNumber += 1;
  }
  return found;
}

function isGitCommit(command) {
  return /(^|[;&|(=]\s*|\s)git\b[^;&|]*?\scommit\b/.test(command);
}

async function main() {
  const mode = process.argv[2];
  let payload;
  try {
    payload = JSON.parse((await readStdin()) || "{}");
  } catch {
    return;
  }

  if (mode === "edit") {
    const comments = findAddedCommentsInEdit(payload);
    if (comments.length === 0) return;
    process.stdout.write(
      JSON.stringify({
        decision: "block",
        reason: `This edit added ${comments.length} comment(s) to ${payload.tool_input.file_path}:\n${comments
          .map((comment) => `  ${comment.trim()}`)
          .join("\n")}\n\n${CHECKLIST}`,
      })
    );
    return;
  }

  if (mode === "commit") {
    const command = payload.tool_input?.command ?? "";
    if (!isGitCommit(command) || /\bCOMMENTS_REVIEWED=1\b/.test(command)) return;
    const comments = findAddedCommentsInCommit({ command, cwd: payload.cwd ?? process.cwd() });
    if (comments.length === 0) return;
    process.stdout.write(
      JSON.stringify({
        hookSpecificOutput: {
          hookEventName: "PreToolUse",
          permissionDecision: "deny",
          permissionDecisionReason: `This commit adds ${comments.length} comment(s):\n${comments
            .map((comment) => `  ${comment}`)
            .join("\n")}\n\n${CHECKLIST}\n\nFix or confirm them, then rerun the commit prefixed with COMMENTS_REVIEWED=1 (e.g. \`COMMENTS_REVIEWED=1 git commit ...\`).`,
        },
      })
    );
  }
}

await main();
