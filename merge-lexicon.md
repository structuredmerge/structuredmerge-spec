# Merge Lexicon

This file is a practical lexicon snapshot for implementation work. It is not a
replacement for `MERGE_RULESET_INFORMATIONAL_DRAFT_01.md`; it is a short,
implementation-oriented bridge document derived from it.

## Source Of Truth

Primary source:

- `MERGE_RULESET_INFORMATIONAL_DRAFT_01.md`

Secondary planning inputs:

- `AST_MERGE_SPEC_ALIGNMENT_TODOS.md`
- `REMOVAL_MODE.md`
- `LICENSE_TEMPLATE_PLAN.md`

## Core Terms

### Document

The parsed or unparsed source unit being analyzed or merged.

Examples:

- Ruby source file
- JSON or JSONC document
- Markdown document
- Plain text document

### Analysis

The implementation-specific representation produced from a document before
matching and merge resolution.

Examples:

- Tree-sitter parse tree plus comment metadata
- Text block segmentation plus normalized spans

### Node

A structural unit eligible for matching, conflict resolution, rendering, or
diagnostic reporting.

Examples:

- AST pair
- array element
- Markdown block
- text paragraph

### Match

An implementation decision that two nodes from template and destination are the
same logical unit for merge purposes.

### Refiner

A post-parse matching helper that improves baseline structural matching using
content similarity, signatures, or specialized heuristics.

### Freeze Region

A region whose destination content is preserved regardless of template content.

### Comment Capability

The representation and rules an implementation uses to preserve, attach,
replay, or synthesize comments.

### Diagnostic

Structured information about parse problems, merge ambiguity, fallback,
corruption detection, or skipped behavior.

### Removal Mode

The policy governing whether destination-only or template-only nodes are
retained, removed, or conditionally emitted.

### Render

The final emission step that turns resolved nodes back into document text.

## Implementation Contracts

Every language implementation should define equivalents for:

1. Document input contract
2. Analysis contract
3. Node wrapper contract
4. Matching/refinement contract
5. Freeze handling contract
6. Comment capability contract
7. Diagnostic contract
8. Render contract

## Deliberate Constraints

- MVP implementations should prefer tree-sitter-backed analysis where practical.
- Native parser alternatives may be used later, but tree-sitter is the baseline
  portability target for v1.
- Templating/scaffolding is a later layer, not part of the core lexicon MVP.

