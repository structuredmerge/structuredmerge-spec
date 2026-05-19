# Slice 1009: Ruleset Runtime Translation

`ast-merge` should keep parsed ruleset declarations normalized and translate
them into merge-facing runtime objects through one shared layer.

The Ruby reference translator maps `read`, `attach`, `capability`, and
`logical_owner` into a `RuntimeDeclaration`, then builds the shared
`FeatureProfile` from that declaration. Comment-free formats are supported by
omitting `comment_style`, which leaves `support_style` unset and keeps the
profile non-comment-aware.
