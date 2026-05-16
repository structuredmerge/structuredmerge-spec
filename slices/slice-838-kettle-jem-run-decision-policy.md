# Slice 838: Kettle Jem Run Decision Policy

## Goal

Restore the old Kettle/Jem non-interactive happy path without restoring the old
prompt helper as the behavioral contract.

## Contract

Active `kettle-jem` exposes one shared run decision policy for plan/apply
surfaces:

- default mode is non-interactive accept mode;
- `force=true` and future `--force` / `--accept` wrappers select accept mode;
- `force=false` and future `--interactive` wrappers select interactive mode;
- valid-document merge questions always resolve through deterministic defaults;
- the selected default is reported with category, file, source, severity, and
  blocking status;
- fatal questions without a safe default raise a hard failure instead of being
  coerced into an unsafe answer.

This replaces the old behavior where force mode answered every prompt as yes.
The new contract means "choose the configured default and report it," which can
map to create, merge, replace, keep, delete, or skip depending on the recipe.
