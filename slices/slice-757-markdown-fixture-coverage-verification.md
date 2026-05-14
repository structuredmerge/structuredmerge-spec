# Slice 757: Markdown Fixture Coverage Verification

## Goal

Verify which old `markdown-merge` behaviors around links, tables, lists, code
blocks, output assembly, and document problems are already fixture-backed and
which require future portable fixtures.

## Current Fixture-Backed Claims

The current Markdown family can claim:

- Markdown analysis for headings and fenced code blocks.
- Path/equality owner matching.
- Section merge.
- Advanced nested section/list leaf merge.
- Fenced-code embedded family discovery.
- Fenced-code delegated child operations.
- Fenced-code delegated apply output.
- Nested merge and reviewed nested merge.
- Reviewed nested review artifact application, rejection, envelope
  application, and envelope rejection.
- Family and provider backend metadata.

## Missing Fixture Obligations

The following old values are not current generated README claims yet:

- Link parsing for reference definitions, titles, emoji labels, inline links,
  inline images, linked images, nested constructs, leaf-first flattening, and
  byte/character positions.
- Link reference rehydration from parser-normalized inline links back to
  reference-style Markdown.
- Link definition formatting and re-emission.
- Document problem reporting, including duplicate link definitions, excessive
  whitespace, link-title info, category/severity filtering, summaries, and
  hash conversion.
- OutputBuilder as a portable source-preserving assembly contract.
- Fuzzy table matching and table-match algorithm behavior.
- Fuzzy list matching for corrupted or duplicated list blocks.
- Code-block merger runtime behavior outside the already fixture-backed
  delegated child operation path, including disabled mode, unsupported
  language diagnostics, identical decision stats, and custom merger callbacks.
- Cleanse passes for block spacing, code fence spacing, condensed link refs,
  list marker duplication, and templating corruption.
- Whitespace normalization policy.
- Partial-template comment preservation and full-document comment gap handling.

## Decision

Keep generated Markdown README examples limited to fixture-backed family
behavior. Port the old advanced Markdown utilities through future portable
fixture slices before implementation or README claims.

The old Ruby utility classes are valuable prior art, but they are not public
cross-language contracts until fixtures define their behavior.
