# Slice 758: Markdown Utility Port/Retire Decision

## Goal

Decide how to treat the old Markdown utility classes from
`reference/markdown-merge` during the README/example migration.

## Port Later Behind Fixtures

The following utilities represent real value and should be ported only after
portable fixture slices define their behavior:

- `OutputBuilder`: source-preserving output assembly.
- `LinkParser`: definitions, inline links, images, linked images, emoji labels,
  nested constructs, and positions.
- `LinkReferenceRehydrator`: inline-to-reference restoration.
- `LinkDefinitionFormatter` and `LinkDefinitionNode`: reference definition
  output.
- `DocumentProblems`: structured document issue reporting.
- `TableMatchRefiner` and `TableMatchAlgorithm`: fuzzy table matching.
- `ListMatchRefiner`: corrupted/duplicated list matching.
- `CodeBlockMerger`: utility-level code block merge decisions beyond the
  already fixture-backed delegated child path.
- `Cleanse::*`: block spacing, code fence spacing, condensed link refs, list
  marker duplication, and templating corruption cleanup.
- `WhitespaceNormalizer`: whitespace policy.

## Retire As Public Contract

Do not port old Ruby private helper APIs or class names as public
cross-language contracts. The portable contract must be the fixture behavior.
Provider packages can expose language-native helper classes if useful, but
generated family READMEs should not promise old Ruby class APIs.

## Recommendation

Create future Markdown fixture slices in this order:

1. Link parser and link definition formatting.
2. Link reference rehydration plus duplicate definition problem reporting.
3. OutputBuilder/source-preserving assembly.
4. Table/list fuzzy matching.
5. CodeBlockMerger utility outcomes that are not already covered by delegated
   child operation fixtures.
6. Cleanse and whitespace normalization policy.
7. Comment preservation.

Until those fixtures exist, generated Markdown READMEs should stick to the
current fixture-backed section merge and fenced-code nested merge behavior.
