## Slice 106: Rust Module Analysis

Define the baseline owner analysis for Rust modules.

### Why

- source-language families need a portable ownership baseline
- Rust modules provide a second test for import and declaration ownership

### Rules

1. imports are exposed as `/imports/<index>` owners in source order
2. top-level named declarations are exposed as `/declarations/<name>` owners
3. the baseline declaration kinds are driven by process structure items
4. owner reporting order is:
   - imports in source order
   - declarations in stable path order

### Notes

- the baseline import match key is the normalized `use` path
- nested item ownership is out of scope
