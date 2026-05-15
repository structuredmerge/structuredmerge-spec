# Slice 776: Kettle Jem Run Stats

## Goal

Evaluate old `kettle-jem` phase stats and preserve the reporting value without
restoring phase classes.

## Old Behavior

The old `PhaseStats` object snapshotted template helper results before and
after each phase, then used git dirty state to classify template work as:

- templates processed
- created destinations
- pre-existing destinations
- identical pre-existing destinations
- changed pre-existing destinations

Those counters were rendered inline on phase summary lines.

## Decision

Do not port `PhaseStats` as an object tied to old phase execution. The active
recipe runner already emits per-recipe reports, so stats should be derived from
the recipe reports and exposed as `run_stats` on plan/apply reports.

The active counter names are:

- `recipes`
- `created`
- `pre_existing`
- `identical`
- `changed`
- `deleted`
- `plugin_file_changes`
- `summary`

`plugin_file_changes` is counted from plugin lifecycle diagnostics after apply.

## Boundary

This does not recreate old phase summary output, old template helper state, or
git-dirty based classification. Source-of-truth is the recipe execution report.

