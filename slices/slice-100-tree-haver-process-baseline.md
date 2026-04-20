## Slice 100: Tree-Haver Process Baseline

Define a portable `tree-haver` process surface backed by the language-pack extraction APIs.

### Why

- source-language families need more than syntax-valid parse success
- the language-pack already exposes structure and import extraction
- a normalized bridge should exist before any code-language merge family depends on it

### Rules

1. a process request identifies `source` and `language`
2. the baseline portable process result includes:
   - `language`
   - `structure`
   - `imports`
   - `diagnostics`
3. a structure item includes:
   - `kind`
   - optional `name`
   - stable `span`
4. an import item includes:
   - `source`
   - imported item names when available
5. process diagnostics remain separate from merge diagnostics

### Notes

- this slice intentionally normalizes the shared subset only
- richer backend-specific fields remain out of scope for the portable baseline
