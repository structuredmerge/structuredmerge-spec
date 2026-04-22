## Slice 334: Template Entry Plan State

`ast-merge` MUST provide a shared helper that enriches a dry-run template entry
plan with destination-existence state.

Given an ordered template entry plan and a set of existing destination-relative
paths, the state helper MUST return one enriched entry per planned entry with:

1. `destination_exists`
2. `write_action`

The `write_action` rules MUST be:

- `omit` when the plan entry has no destination path
- `keep` when the selected strategy is `keep_destination`
- `create` when a destination path is present and does not exist
- `update` when a destination path is present and already exists

This slice preserves the selected strategy separately from the derived
write-action so the template runner can distinguish intent from destination
state.
