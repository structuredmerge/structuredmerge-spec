# Slice 917: ast-crispr limit helpers

## Purpose

`ast-crispr` exposes ergonomic cardinality limit helpers over the structured
edit selection contract. These helpers are intentionally small and portable:
they normalize limit specifications, describe the accepted cardinality, and
evaluate match counts.

## Contract

- A nil/empty limit defaults to `exactly: 1`.
- Supported object fields are `exactly`, `at_most`, `at_least`, and
  `none_or_one`.
- Supported string expressions are `== n`, `!= n`, `<= n`, `>= n`, `< n`,
  and `> n`.
- Arrays combine multiple limit specifications with logical AND.
- Invalid or empty specifications fail closed with a structured error.

## Fixture

- `fixtures/diagnostics/slice-917-ast-crispr-limit-helpers/ast-crispr-limit-helpers.json`

