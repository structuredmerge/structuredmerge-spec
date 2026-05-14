# Slice 743: Reusable README Configuration Examples

## Goal

Define fixture-backed examples for reusable configuration and usage patterns
found in the old Kettle README files.

These examples are inputs for generated README Basic Usage and Configuration
sections. They preserve the documentation value without depending on old
Ruby-only class names or retired package examples.

## Shared Behavior

Reusable examples SHOULD be represented as structured data with:

- a stable example id,
- a category,
- the user-facing purpose,
- portable pseudocode or command text,
- implementation notes,
- source old README references,
- migration status.

Generated READMEs MAY choose a concise subset per package, but the source
examples MUST stay fixture-backed.

## Acceptance Data

The fixture for this slice defines examples for:

1. freeze tokens,
2. match preference,
3. template-only behavior,
4. debug logging and report inspection,
5. backend selection,
6. CLI or command entrypoints.

## Boundaries

- Examples are deliberately package-neutral unless a behavior only makes sense
  for one family.
- Retired `bash`, `dotenv`, and `rbs` examples remain excluded.
- Old RubyGems secure-installation snippets remain discarded.
