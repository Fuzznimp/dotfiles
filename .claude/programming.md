# Programming Rules

## Never guess, always verify

Never guess: not APIs, signatures, types, file paths, config keys, command flags, nor whether something exists. Read the source, run the check, or consult the docs first. If you cannot verify, say so plainly instead of asserting.

State claims at the confidence you actually have. "X does Y" means you confirmed it. If not, say "likely" or verify before speaking.

## Always label code blocks with their path

Every code block showing code that lives in a file gets the path above it, relative to the repo root, with the line number when known. Diffs and excerpts included. Without it the reader has to guess which file changed.

Bare filenames (`computation.service.ts`) are not enough: the same name appears in many folders. Give the full path from the repo root.

````
`src/core/growing-degree-days-indicator/computation.service.ts:243`

```diff
-    // old line
+    // new line
```
````

Exception: snippets that belong to no file (throwaway examples, illustrations of a rule, shell commands).

## Moving files

When a file needs to move or be renamed, actually move it. Use `mv` (or `git mv` inside a repo, to keep history). Never recreate the file at the new path and delete the old one, and never write a copy and leave the original behind.

Move first, then edit contents in place at the new path if needed. Same rule for directories.

```sh
# yes
git mv src/old/thing.ts src/new/thing.ts

# no
# Write src/new/thing.ts with the same content, then rm src/old/thing.ts
```

After the move, update references (imports, config keys, docs) pointing at the old path.

## Generated files

Never hand-edit a generated file. Its content is an output: the next generator run overwrites the edit, so the change silently disappears and the file stops matching its source.

Check before editing any file that could be an output, and check the top of the file, not the region being edited. Signals: a banner (`@generated`, `auto-generated`, `DO NOT EDIT`, `Do not make direct changes to the file`), a `.gen.*` / `.d.ts` name, a `migrations/` folder, a lockfile.

When the content needs to change, change the source and run the generator (usually an npm script, e.g. `sdk:*`, `generate:*`, `drizzle-kit generate`).

When the generator cannot produce the change yet, **stop and ask**. Do not patch the output to move on. The usual case: types generated from a deployed service, where the API change is merged locally but not deployed yet, so the generator would still emit the old shape. That blocks a type check, and a failing type check is the correct state to report:

- say which generated file is stale and why
- say what unblocks it (deploy then regenerate, or regenerate against a local instance)
- let the person decide

A flagged hand-patch is still a hand-patch. Announcing it afterwards does not authorize it.

## TypeScript

### Function declarations over `const`

Use a `function` declaration for named module-level functions, helpers, hooks, and utilities. Do **not** assign an arrow function to a `const` for these.

Exceptions where `const` is fine:

- A React component in a `.tsx` file. `const` arrow visually flags "component", composes with `memo`/`forwardRef`.
- The variable is annotated with a full function type, so the signature comes from the type rather than the declaration:

  ```ts
  export const doSomething: DoSomething = async () => {
    return buildResult();
  };
  ```

Applies to named, top-level definitions only. Inline callbacks (`map`/`filter`, event handlers, `setTimeout`, etc.) stay as arrows. Non-component functions inside a `.tsx` file (helpers, custom hooks, utils) still use `function` declarations.

```ts
// yes
function doThing(input: string): Result { ... }
function useThing(id: string) { ... }

// no
const doThing = (input: string): Result => { ... };
```

```tsx
// yes
const Thing = ({ value }: Props) => { ... };
function formatValue(value: Value): string { ... }
function useThing(id: string) { ... }
```

### Object params past one argument

One positional param is fine. With two or more, take a single object param instead. Call sites stay readable, argument order stops mattering.

```ts
// yes
function doThing(input: string): Result { ... }
function doThing({ input, options }: { input: string; options: Options }): Result { ... }

// no
function doThing(input: string, options: Options): Result { ... }
```

### Inline small local types

A small type that is used once and not exported stays inline at the use site. Naming it (`type Props`, `type Params`, `type Options`) only moves the same shape a few lines away and adds an indirection the reader has to follow.

Extract and name it when it earns a name:

- it is exported, or referenced more than once
- it is recursive, or a union/discriminated union
- it is big enough that inlining buries the signature (roughly past 3-4 fields, or it no longer reads at a glance)

```tsx
// yes
const PageHeader = ({ getPageData }: { getPageData: GetPageDataApi }) => { ... };

// no
type Props = {
  getPageData: GetPageDataApi;
};
const PageHeader = ({ getPageData }: Props) => { ... };
```

```ts
// yes
function computeSubtitle({ ownerName, fieldName }: { ownerName: string; fieldName: string }): string { ... }

// yes, earns its name: exported and reused
export type PageContextValue = { ... };
```

## Comments

Only write comments that add non-obvious information: rationale, gotchas, edge cases. Do not restate what the name already says.

Reaching for a comment to state a unit or a measure means the name is wrong. Put it in the name: `ttlInSeconds`, `rowHeightInPx`, `sizeInBytes`. A name travels with the value through every call site and cannot drift out of date the way a trailing comment does.

Comments describe what the code is and why it exists, never how it changed. Do not narrate edit history: no "now that...", "changed from...", "previously...", "no longer needed", "moved here". That context means nothing to a future reader and belongs in git history, not the source. Keep comment density matching the surrounding code.

Don't reference task names, PR or issue numbers.

```ts
// yes
const ttlInSeconds = 900;

// no
const ttl = 900; // seconds
const ttl = 900; // refresh interval time to live
const ttl = 900; // hardcoded now that we removed the config option
```

### Don't justify a choice because you just made it

A comment that exists only because you edited that line is narration of the change, even when it reads as rationale. Tuning a value or flipping an option and then explaining the decision is the most common form.

Test it: on a fresh file, knowing nothing about what the line held before, would that comment still be worth writing? If no, drop it. Deliberate code needs no defence.

```ts
// no
const parser = new Parser({ strict: true }); // strict mode rejects malformed rows
return rows.filter(isVisible); // hidden rows stay out of the export

// yes
const parser = new Parser({ strict: true });
return rows.filter(isVisible);

// yes, the comment carries a fact the code cannot show
const parser = new Parser({ strict: true }); // the vendor feed omits required fields, lenient mode swallows them
```

State a constraint at the altitude it applies to. When it governs a whole group, it goes above the group, not on the one member you happened to touch.

```ts
// yes
// Keys are sent verbatim to the native bridge, which rejects unknown ones.
const bridgeConfig = {
  someKey: "value",
  otherKey: "value",
};
```
