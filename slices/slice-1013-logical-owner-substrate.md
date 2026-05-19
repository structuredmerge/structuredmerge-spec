# Slice 1013: Logical-Owner Substrate

`ast-merge` should treat logical owners as runtime policy objects, not just
ruleset parser metadata.

The Ruby substrate introduces `Ruleset::LogicalOwnerPolicy` and exposes
materialized policies from runtime declarations and feature profiles. The first
shared hook covers `preserve_if_referenced`, which downstream formats can use
for link definitions, anchors, or similar logical owners.
