## Slice 110: Go Module Analysis

Define the baseline owner analysis for Go source files.

### Why

- Go adds another real source-language pressure test
- the backend currently exposes duplicated import entries, so the family layer needs a portable dedupe rule

### Rules

1. imports are exposed as `/imports/<index>` owners in source order after family-level deduplication
2. top-level named declarations are exposed as `/declarations/<name>` owners
3. duplicate import extractions that normalize to the same import path collapse to one owner
4. owner reporting order is:
   - imports in source order after dedupe
   - declarations in stable path order

### Notes

- the baseline declaration set is limited to what the process backend exposes today
- richer Go ownership remains out of scope
