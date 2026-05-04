# Slice 694: Ruby Provider Batch Operation Triad Projections

## Goal

Move the concrete Ruby provider batch projection fixtures toward the canonical
structured-edit operation triad.

## Shared Behavior

This slice updates the Ruby-lane provider batch projections:

1. Prism batch request/report projections include `replace`, `insert`, and
   `delete`,
2. Markly batch request/report projections include `replace`, `insert`, and
   `delete`,
3. each report keeps request/result/application ordering coherent with the
   corresponding batch request projection,
4. `delete` remains the canonical removal operation kind,
5. no `remove` operation kind or alias is introduced.

## Notes

- This is provider-projection adoption work in the Ruby implementation lane.
- Go, Rust, and TypeScript continue to validate the shared substrate and
  provider-capability contracts; they do not currently have equivalent concrete
  provider projection functions for Prism or Markly.
