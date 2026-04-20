## Slice 121: Manifest Backend Report

Define end-to-end reporting for backend-limited manifest cases under backend mismatch.

### Why

- backend requirements now exist at selection time and survive manifest planning
- the next observable step is report output when a planned backend-limited case is skipped

### Rules

1. a manifest-planned case with a mismatched active backend reports a skipped result
2. the skipped result carries the backend-mismatch message from selection
3. the suite summary counts the skipped backend-limited case

### Notes

- this slice does not add new execution behavior
- the execution callback should remain irrelevant for backend-skipped cases
