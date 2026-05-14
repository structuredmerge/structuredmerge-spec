# Slice 738: README Family Section Template Contract

## Goal

Define a provider-neutral contract for rendering and applying a shared README
family-section partial across the StructuredMerge package families.

This is the structured-merge successor to the old
`reference/ast-merge/GEM_FAMILY_SECTION.md` partial and
`reference/ast-merge/bin/update_gem_family_section` command.

## Shared Behavior

Implementations MUST model README family-section synchronization as a template
contract, not as hard-coded README string surgery.

The shared contract has four layers:

1. family metadata identifies the current implementation language and all
   alternative implementation languages,
2. token resolution derives stable scalar tokens from that structured metadata,
3. a Markdown partial renders from the resolved values,
4. a Markdown heading-section operation inserts or replaces the rendered section
   in `README.md`.

The canonical implementation language order is:

```text
go, ruby, rust, typescript
```

For a package whose `self.id` is one of those languages, `alternatives` MUST be
the canonical order with `self.id` removed. Scalar aliases MUST be assigned from
that ordered list:

- `IMP_LANG1`
- `IMP_LANG2`
- `IMP_LANG3`

Implementations SHOULD also expose structured language data so product
templates are not limited to numbered scalar aliases.

## Required Acceptance Cases

The fixture for this slice defines:

1. alias derivation for each self language,
2. token resolution for a Ruby package with Go/Rust/TypeScript alternatives,
3. a rendered Markdown family-section partial,
4. replacement of an existing README family section,
5. insertion when the section is missing,
6. creation behavior when the README is missing,
7. convergence on reapply.

## Boundaries

- `ast-template` is the product-level home for applying family README
  templates across package directories.
- `markdown-merge` or the Markdown structured-edit provider owns heading-section
  insertion/replacement semantics.
- `ast-merge` owns shared token, execution, report, and provider-neutral recipe
  contracts.
- Package discovery, ecosystem-specific badge URLs, and package-manager
  metadata extraction remain wrapper responsibilities unless separately
  specified.

## Notes

- Fixtures are the canonical shared contract and sample structure. Shipped
  templates may live in each language implementation, but they MUST conform to
  the fixture shape.
- The Markdown partial is presentation. The source of truth is structured
  family/package metadata.
- The old RubyGems-only compatibility matrix is prior art, not the new source
  schema.
