# Slice 170: YAML Family Backend Plurality

## Goal

Make backend plurality an explicit YAML-family behavior rather than a
host-local parser choice.

## Shared Behavior

This slice defines the YAML family expectation:

1. a YAML merge family MAY support multiple backends side by side,
2. those backends MAY be hosted in different layers according to the backend
   ownership rule,
3. the same family-facing parse, structure, owner-matching, and merge fixtures
   SHOULD pass under each supported backend unless a fixture declares a backend
   restriction explicitly,
4. backend choice MAY affect syntax validation, acquisition, or intermediate
   representation without changing the observable YAML family contract.

## Shared Consequences

- YAML plurality does not require every backend to live in `tree-haver`.
- One-trick YAML parsers remain family-local backends.
- A `tree-haver` tree-sitter path MAY be used as a syntax-validation backend
  while a family-local semantic parser continues to supply normalized YAML
  values, so long as the observable family contract stays explicit.
