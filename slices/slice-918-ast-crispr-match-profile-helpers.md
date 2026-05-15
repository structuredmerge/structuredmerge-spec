# Slice 918: ast-crispr match profile helpers

## Purpose

`ast-crispr` exposes portable match profile helpers for the old CRISPR
start-boundary, end-boundary, and payload-kind concepts.

These helpers describe what a selected match span means without executing a
parser-specific selection.

## Contract

- Known start boundaries expose a boundary family and description.
- Known end boundaries expose a boundary family and description.
- Known payload kinds expose a payload family and description.
- A match profile reports whether each configured value is known.
- Unknown values are preserved but marked unknown.

## Fixture

- `fixtures/diagnostics/slice-918-ast-crispr-match-profile-helpers/ast-crispr-match-profile-helpers.json`

