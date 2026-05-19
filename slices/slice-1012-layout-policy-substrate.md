# Slice 1012: Layout-Policy Substrate

`ast-merge` should model layout ownership independently from comments and make
whitespace equivalence explicit.

The Ruby substrate exposes `Layout::Augmenter`, `Layout::Attachment`,
`Layout::Gap`, and `Layout::Policy`. Exact preservation is the default policy.
Treating whitespace-only lines as equivalent is available only through the
named `blank_line_equivalent` policy, not through generic cleanup.
