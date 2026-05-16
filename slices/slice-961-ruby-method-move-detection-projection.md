## Slice 961: Ruby Method Move Detection Projection

Project Ruby direct methods into the generic move-detection matching report so
Ruby can use the upgraded matcher path instead of Ruby-only owner heuristics.

### Why

- move detection already exists as generic matcher vocabulary
- Ruby should feed receiver-aware method signatures and method positions into
  that matcher rather than grow a separate moved-method implementation
- owner/path matching remains the fallback when move detection is disabled or
  projection metadata is unavailable

### Rules

1. direct methods in matched declarations are projected with owner path,
   receiver-aware method signature, and sibling index
2. methods with the same owner/signature but different sibling positions are
   reported as moved matches
3. move detection is opt-in and reports its capability metadata
4. unmatched methods remain explicit in the generic matching report
