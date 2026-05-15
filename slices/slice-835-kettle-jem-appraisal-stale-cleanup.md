# Slice 835: Kettle Jem Appraisal Stale Cleanup

## Goal

Port deterministic stale appraisal gemfile cleanup planning from the old
`kettle-jem-appraisals` CLI.

## Contract

Given existing project-relative paths and the current matrix entries, active
`kettle-jem` can identify stale flat `gemfiles/kja-*.gemfile` files whose
basename is no longer present in the current matrix.

The helper only plans cleanup paths. Actual deletion belongs to apply/report
layers.
