# Slice 38: GitHub Actions Baseline

## Goal

Define the minimum GitHub Actions baseline for the structuredmerge public
repositories.

## Scope

- reuse the Ruby-family trigger and concurrency patterns where they fit
- keep each repository on its own native validation command surface
- make the public-repo automation baseline explicit and observable

## Contract

This slice defines one small GitHub Actions baseline contract:

1. each public repository exposes a baseline GitHub Actions workflow
2. the baseline workflow runs on `push`, `pull_request`, and
   `workflow_dispatch`
3. the baseline workflow uses read-only `contents` permissions
4. the baseline workflow uses cancel-in-progress concurrency scoped to workflow
   name and git ref
5. each repository executes its own native validation surface rather than
   routing through a cross-repository control repo
6. repositories with extra host constraints may add setup steps, but they still
   keep the same trigger and concurrency envelope

## Shared Fixture

- `github-actions-baseline.json`

## Notes

- This slice is intentionally operational rather than merge-semantic.
- The TypeScript, Rust, and Go repositories use their existing `mise`-backed
  `check` surfaces.
- The `spec` and `fixtures` repositories use lightweight native validation
  checks appropriate to their content.
