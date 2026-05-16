# Slice 844: Template-Only And Partial-Template Helper Inventory

## Goal

Classify the old Ruby `ast-merge` helpers for partial-template targeting,
diff-to-node mapping, file alignment, and template-only insertion against the
active StructuredMerge contracts.

## Contract

Template-only insertion is portable behavior. Legacy helper classes are not
portable API.

Portable insertion behavior:

- align exact matched peers before placing template-only nodes;
- preserve destination-backed node order;
- insert template-only nodes relative to matched template neighbors rather than
  only appending globally;
- delay interior template-only groups until all preceding matched template
  anchors have been consumed, so destination reordering does not cause early
  insertion;
- emit prefix and tail template-only groups deterministically;
- report the insertion basis, including matched anchors, group anchors, and
  fallback insertion mode.

Portable partial-template behavior:

- describe a target region by selector, key path, owner path, or structured edit
  destination profile;
- merge only the selected region when it exists;
- apply an explicit missing-target policy such as skip, append, prepend, or add
  key path;
- report whether the region or key path was found and whether fallback policy
  was used.

The old `TrailingGroups::*` modules are useful algorithm vocabulary, but should
be reintroduced as private implementation helpers only after fixtures require
identical behavior in at least two active families. `PartialTemplateMergerBase`,
`KeyPathPartialTemplateMergerBase`, `DiffMapperBase`, and `FileAlignerBase`
remain retired as public/common base classes because they encode legacy
`SmartMerger` and file-analysis APIs. Their behaviors should be preserved by
fixture contracts, structured edit requests, normalized node metadata, and
family/provider-local helpers.

## Current Coverage

Ruby already exercises template-only placement through direct class/module
methods, visibility sections, nested declarations, constants, and array
constant element insertion. Structured edit slices already cover destination
profiles, append fallback, and provider execution reports. Future non-Ruby
families should add equivalent family fixtures before claiming the same
placement capability.
