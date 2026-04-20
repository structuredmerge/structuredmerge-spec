## Slice 102: TypeScript Module Analysis

Define the baseline module analysis contract for TypeScript.

### Why

- the first code-language family should start at the module boundary
- imports and top-level declarations are the narrowest useful merge owners

### Rules

1. module analysis uses the portable `tree-haver` process surface
2. import statements emit owner kind `import`
3. top-level declarations emit owner kind `declaration`
4. module owner paths use `/imports/<index>` and `/declarations/<name>`
5. owner ordering is:
   - imports in source order
   - declarations in stable path order

### Notes

- function bodies and statement-level merge are out of scope
- declaration ownership is limited to named top-level items in this slice
