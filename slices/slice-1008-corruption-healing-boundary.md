# Slice 1008: Corruption-Healing Boundary

`ast-merge` should model suspected corruption healing as a policy layer above
core merge semantics. Owner matching, attachment analysis, layout ownership,
and render planning must remain valid when healing is configured to `skip` for
clean inputs or performance-sensitive callers.

Current Ruby behavior is classified as normative merge behavior, corruption
recovery, retired output repair, or ambiguous gap-ownership work. Generic
post-render cleanup is outside the shared contract; owned oddities are
preserved unless a ruleset or format-specific policy defines an equivalence or
rendering rule.
