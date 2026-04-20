# Slice 134: TOML Family Backend Plurality

## Goal

Make parser plurality an explicit TOML-family behavior rather than an
implementation-local experiment.

## Shared Behavior

This slice defines the TOML family expectation:

1. a TOML merge family MAY support multiple backends side by side,
2. those backends MAY be hosted in different layers according to the backend
   ownership rule,
3. the same family-facing parse, structure, owner-matching, and merge fixtures
   SHOULD pass under each supported backend unless a fixture declares a backend
   restriction explicitly,
4. backend choice MAY affect installation, acquisition, or syntax-validation
   strategy without changing the observable family contract.

## Shared Consequences

- Tree-sitter, PEG-framework, and native semantic parser paths can coexist in
  one TOML family.
- A reusable PEG framework belongs in `tree-haver`, while TOML grammar
  realization and node-kind alignment stay in `toml-merge`.
- Family packages MAY use one backend only as syntax validation while another
  backend continues to supply semantic normalization, so long as the family
  contract stays explicit.

## Notes

- Ruby TOML plurality across `tree-sitter`, `Citrus`, and `Parslet` is the
  motivating prior art.
- TypeScript, Rust, and Go now provide the same family-level pattern with PEG
  framework backends alongside their existing TOML family implementation.
