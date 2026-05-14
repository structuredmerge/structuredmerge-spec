# Slice 751: YAML/Psych Fixture Coverage Verification

## Goal

Verify which old `psych-merge` behaviors are already fixture-backed by the
current `yaml-merge` family and which old values still require portable
fixtures before they can appear in generated README examples.

## Sources

The old Psych implementation provided behavior in these areas:

- `Psych::Merge::MappingMatchRefiner`
- `Psych::Merge::PartialTemplateMerger`
- `Psych::Merge::DiffMapper`
- `Psych::Merge::ConflictResolver`
- `Psych::Merge::CommentTracker`
- `Psych::Merge::Emitter`
- `Psych::Merge::FreezeNode`
- reproducible merge fixtures under
  `reference/psych-merge/spec/fixtures/reproducible/`

## Current Fixture-Backed Claims

The current YAML family can claim these behaviors:

- YAML parse success and parse failure.
- Mapping and sequence owner extraction.
- Path/equality owner matching.
- Recursive mapping merge.
- Destination-wins scalar conflict behavior.
- Destination-wins sequence policy.
- Nested mapping leaf merge.

These are covered by `fixtures/yaml/slice-96-parse/`,
`fixtures/yaml/slice-97-structure/`, `fixtures/yaml/slice-98-matching/`,
`fixtures/yaml/slice-99-merge/`, and
`fixtures/yaml/slice-720-advanced-leaf-merge/`.

## Missing Fixture Obligations

The following old values are not current README claims yet:

- Fuzzy mapping matching by similar key/value signals. Old examples include
  `database_url` matching `database_uri`, `cache_timeout` matching `cache_ttl`,
  hyphen/underscore normalization, camelCase normalization, weighted scoring,
  threshold control, and greedy one-to-one matches.
- Sequence mapping item identity. Old reproducible case 14 matched sequence
  mapping items by identifiers such as ORCID, email, and value.
- Partial-template merge by key path. Old examples merged template sequences or
  mappings into paths like `AllCops.Exclude`, supported `add_missing`,
  `remove_missing`, `when_missing: :add`, and template preference at a deep
  scalar path.
- Diff mapper output. Old docs/classes exposed a mapping between destination,
  template, and changed regions. No portable fixture currently defines that
  report shape.
- Comment tracking and comment-preserving output. Old reproducible cases 05-19
  covered leading comments, inline comments, blank-line gaps, comment-only
  sections, trailing comments, nested sequence comments, parent gap stability,
  and duplicate trailing-comment avoidance.
- Freeze blocks. Old behavior used `# psych-merge:freeze` and
  `# psych-merge:unfreeze` markers with custom token support.
- Emitter formatting. Old tests covered indentation, anchors, aliases, merge
  keys, literal/folded scalars, scalar quoting edge cases, and inline comment
  alignment.

## Decision

Keep the current generated YAML README examples limited to fixture-backed YAML
family behavior. Port the old Psych feature set through future slices as
portable YAML fixtures before implementation or README claims.

`psych-merge` remains Ruby/Psych prior art for these behaviors until the
corresponding fixture contracts exist. The old Ruby APIs are not themselves the
cross-language contract.
