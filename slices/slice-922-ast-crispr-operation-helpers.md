# Slice 922: ast-crispr Operation Helpers

## Status

Accepted for implementation.

## Context

After operation profiles are available as generic objects, ast-crispr exposes
named helpers for the canonical structural edit operations. These helpers
mirror the old ast-crispr operation classes while remaining lightweight wrappers
over the ast-merge structured-edit substrate.

## Contract

Each implementation exposes named helpers for:

- `replace`
- `delete`
- `insert`
- `move`

Each helper returns the canonical operation profile for that operation.

## Fixtures

The conformance fixture is
`fixtures/diagnostics/slice-922-ast-crispr-operation-helpers/ast-crispr-operation-helpers.json`.
