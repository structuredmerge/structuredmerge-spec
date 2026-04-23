## Slice 360: Template Directory Session Outcome Report

`ast-template` MUST provide one stable top-level outcome report for a directory
session.

Given the same inputs used by the directory session, status, and diagnostics
slices, the outcome helper MUST:

1. include the existing `session_report`,
2. include the existing `status`,
3. include the existing `diagnostics`,
4. preserve the same `mode` across all nested reports, and
5. be sufficient for a product caller to render plan/apply results without
   recomputing any lower-level helper.

The fixture covers:

1. a dry-run session with blocked and missing-adapter issues,
2. a successful apply session, and
3. a filtered-discovery apply session with a missing family adapter.
