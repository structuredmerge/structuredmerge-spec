# Slice 739: README Family Intro And Backend Matrix

## Goal

Preserve the documentation value from the old Kettle README family sections
without copying the old RubyGems badge tables directly.

The old READMEs explained three distinct things:

1. what the merge-family packages are for,
2. which package owns each layer or document family,
3. which parser/backend/runtime combinations are expected to work.

The new documentation contract MUST keep those as structured data so READMEs can
be generated consistently for Go, Ruby, Rust, and TypeScript packages.

## Shared Behavior

Implementations SHOULD expose README documentation inputs as a structured
profile with:

- an intro paragraph,
- package-family matrix rows,
- backend compatibility rows,
- explicit source/prior-art references,
- explicit notes for retired, renamed, or superseded old packages.

Generated README sections MAY render different presentation Markdown per
ecosystem, but they MUST preserve the fixture data and avoid reintroducing
RubyGems-only badge tables as the source of truth.

## Acceptance Data

The fixture for this slice defines:

1. the normalized family intro,
2. a current package matrix for the new StructuredMerge packages,
3. a backend compatibility matrix that points at current feature-profile
   fixtures rather than hard-coded old platform assumptions,
4. old Kettle packages that need explicit migration decisions.

## Boundaries

- This slice defines README data shape and migration decisions.
- It does not require every package README to exist yet.
- Per-package README generation and command wiring belong to `ast-template`.
- Backend truth should continue to come from family feature-profile fixtures.

