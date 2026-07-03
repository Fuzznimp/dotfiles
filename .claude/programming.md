# Programming Rules

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
