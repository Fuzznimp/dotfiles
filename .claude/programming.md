# Programming Rules

## Never guess, always verify

Never guess: not APIs, signatures, types, file paths, config keys, command flags, nor whether something exists. Read the source, run the check, or consult the docs first. If you cannot verify, say so plainly instead of asserting.

State claims at the confidence you actually have. "X does Y" means you confirmed it. If not, say "likely" or verify before speaking.

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

## Comments

Only write comments that add non-obvious information: units, rationale, gotchas, edge cases. Do not restate what the name already says.

Comments describe what the code is and why it exists, never how it changed. Do not narrate edit history: no "now that...", "changed from...", "previously...", "no longer needed", "moved here". That context means nothing to a future reader and belongs in git history, not the source. Keep comment density matching the surrounding code.

Don't reference task names, PR or issue numbers.

```ts
// yes
const ttl = 900; // seconds

// no
const ttl = 900; // refresh interval time to live
const ttl = 900; // hardcoded now that we removed the config option
```
