# Slice 37: Repository Publication Baseline

## Goal

Define the publication baseline for the structuredmerge public repositories.

## Scope

- make repository visibility an explicit governance fact
- anchor the active repositories under the `structuredmerge` GitHub org
- avoid treating publication status as hidden operator knowledge

## Contract

This slice defines one small repository-publication contract:

1. the active shared repositories for the current stack are `spec`,
   `fixtures`, `typescript`, `rust`, and `go`
2. each active repository is published under the `structuredmerge` GitHub org
3. each active repository is public
4. repository publication status is verified through observable GitHub metadata,
   not assumed from local workspace layout

## Shared Fixture

- `repository-visibility.json`

## Notes

- This slice records the current public baseline. It does not require a new API
  surface in the language implementations.
- Publication is intentionally separate from CI. The next slice defines the
  GitHub Actions baseline layered on top of these public repositories.
