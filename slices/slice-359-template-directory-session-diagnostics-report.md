## Slice 359: Template Directory Session Diagnostics Report

`ast-template` MUST provide a stable, product-layer diagnostics report for a
directory session.

Given the same directory session inputs used by the session-status slices, the
diagnostics helper MUST:

1. include the session `mode`,
2. report `ready` as `true` only when the diagnostic list is empty,
3. expose diagnostics in deterministic order,
4. normalize unresolved-token blockers into explicit product-layer diagnostics,
5. normalize missing-family-adapter blockers into explicit product-layer
   diagnostics per affected destination path, and
6. include, for each diagnostic:
   - `severity`
   - `category`
   - `reason`
   - `path`
   - `family` when applicable
   - `message`

The fixture covers:

1. a dry-run session with both unresolved-token and missing-adapter blockers,
2. a successful apply session with no product-layer diagnostics, and
3. a filtered-discovery apply session with a missing adapter that blocks one
   destination path.
