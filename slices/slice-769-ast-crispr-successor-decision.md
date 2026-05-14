# Slice 769: AST CRISPR Successor Decision

## Goal

Determine whether old `ast-crispr*` behavior became `ast-template`, recipe
support, source edit plans, or should be archived.

## Evidence

The old `reference/ast-crispr` core contains a compact AST edit operation model:

- `Limit` cardinality constraints;
- `Match` and `MatchProfile`;
- `StructureProfile`;
- `SelectionProfile`;
- `DestinationProfile`;
- `OperationProfile`;
- document contexts and adapter structure profiles;
- owner-filter and comment-region-owned selectors;
- replace, delete, insert, and move operations;
- destination anchors and append fallback;
- Ruby/Prism and Markdown/Markly provider package shells.

The current workspace already has extensive structured-edit envelopes and
provider execution/replay/report fixtures. Current `ast-template` packages own
template/session/profile/runner behavior and README family partial application.

## Decision

The old `ast-crispr*` package identity is superseded for the current README
migration pass.

Preserve the conceptual value in two destinations:

- structured-edit envelopes own the portable source-edit vocabulary:
  selections, matches, operation profiles, destination profiles, execution
  reports, replay, review state, and provider handoff;
- `ast-template` owns template/recipe/session-oriented application of those
  edits when the operation is part of a templating workflow.

Do not resurrect `ast-crispr`, `ast-crispr-ruby-prism`, or
`ast-crispr-markdown-markly` as active generated README family entries now.
Their provider package shells had little project-local documentation and should
not become current support claims without active packages and fixtures.

## Migration Guidance

Map old concepts this way:

| Old `ast-crispr` concept | Current destination |
| --- | --- |
| `Limit` | structured-edit selection cardinality / review policy |
| `StructureProfile` | provider structure profile fixtures |
| `SelectionProfile` | structured-edit selection policy/profile fixtures |
| `MatchProfile` | structured-edit match profile fixtures |
| `OperationProfile` | structured-edit operation profile / operation kind |
| `DestinationProfile` | structured-edit destination policy/profile |
| replace/delete/insert/move actors | structured-edit operation requests and provider execution |
| append fallback | structured-edit destination fallback policy |
| Ruby/Prism provider shell | `ruby-merge` / `prism-merge` provider fixtures if revived |
| Markdown/Markly provider shell | `markdown-merge` / `markly-merge` provider fixtures if revived |
| recipe/template usage | `ast-template` or Kettle recipe fixtures |

Future work should only port missing behavior by adding fixture-backed gaps to
the structured-edit or `ast-template` lanes. The old Ruby actor API is not the
new public contract.
