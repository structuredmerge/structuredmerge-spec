# Slice 742: Old README Example Inventory

## Goal

Inventory and classify reusable examples from the old Kettle README files before
porting them into fixtures or generated package READMEs.

The old READMEs contain useful examples, but they mix behavior contracts,
Ruby-only API snippets, retired package examples, and obsolete installation
security prose. The new workspace must keep the transferable value without
turning old prose into the source of truth.

## Shared Behavior

Example migration SHOULD classify each example as one of:

- `fixture_behavior`: behavior that belongs in conformance fixtures or
  diagnostics,
- `readme_prose`: user-facing API or configuration examples that generated
  READMEs may summarize,
- `retired`: examples for packages or workflows that are not current,
- `discarded`: obsolete prose that should not be ported.

## Acceptance Data

The fixture for this slice defines:

1. example categories found in old READMEs,
2. representative old sources,
3. destination lanes,
4. migration decisions,
5. explicit exclusions for security-installation prose and unresolved packages.

## Boundaries

- This slice is an inventory and classification step.
- It does not require rendering examples into READMEs yet.
- Retired package examples for `bash-merge`, `dotenv-merge`, and `rbs-merge`
  remain excluded until scope decisions exist.
