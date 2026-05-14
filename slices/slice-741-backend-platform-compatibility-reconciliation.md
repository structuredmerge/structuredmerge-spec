# Slice 741: Backend Platform Compatibility Reconciliation

## Goal

Reconcile the old Kettle README backend/platform compatibility claims with the
current StructuredMerge backend profile fixtures.

The old READMEs mostly described Ruby runtime support for `tree_haver` parser
backends. The new workspace has four implementation families and several
fixture-backed backend profiles, so generated docs MUST describe support from
those fixtures instead of copying the old MRI/JRuby/TruffleRuby badge tables.

## Shared Behavior

Generated README compatibility tables SHOULD distinguish:

- portable `tree-sitter-language-pack` support shared across Go, Ruby, Rust,
  and TypeScript,
- implementation-native parser backends that are provider/adaptor choices,
- parser-free families such as plain text, binary, and ZIP,
- unresolved old packages that must not be advertised as current support.

## Acceptance Data

The fixture for this slice defines:

1. old compatibility claims and their current disposition,
2. current backend-profile rows by backend category,
3. provider/adaptor rows that should be documented as implementation-specific,
4. unresolved old package claims that remain excluded from generated support
   tables until a scope decision is made.

## Boundaries

- Runtime-specific Ruby backend details from old READMEs are prior art, not the
  cross-language source of truth.
- This slice does not require implementing missing `rbs`, `bash`, or `dotenv`
  families.
- Generated README tables may summarize the fixture data, but must not
  reintroduce old RubyGems badge tables.
