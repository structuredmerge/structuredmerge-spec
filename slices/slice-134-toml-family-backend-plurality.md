# Slice 134: TOML Family Backend Plurality

## Goal

Make parser plurality an explicit TOML-family behavior rather than an
implementation-local experiment.

## Shared Behavior

This slice defines the TOML family expectation:

1. a TOML merge family MAY participate in multiple backends side by side,
2. those backends MAY be hosted in different layers according to the backend
   ownership rule,
3. the same family-facing parse, structure, owner-matching, and merge fixtures
   SHOULD pass under each supported backend unless a fixture declares a backend
   restriction explicitly,
4. backend choice MAY affect installation, acquisition, or syntax-validation
   strategy without changing the observable family contract.

## Shared Consequences

- A tree-sitter TOML substrate and TOML provider packages can coexist under one
  family contract.
- A reusable PEG framework belongs in `tree-haver`, while TOML grammar
  realization and node-kind alignment stay in TOML family or provider
  packages.
- Family packages SHOULD keep substrate behavior separate from provider-package
  backend selection.

## Notes

- Ruby TOML plurality across `tree-sitter`, `Citrus`, and `Parslet` is the
  motivating prior art.
- TypeScript, Rust, and Go follow the same plurality rule, but provider-package
  boundaries remain host-local.
