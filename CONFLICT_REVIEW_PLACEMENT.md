# Source-backed conflict review with absent alternatives

Conflict markers represent unresolved review, never a successful or partially
resolved merge. Present alternatives retain their source references; an explicitly
absent alternative has no source fragments. Absence with nonempty source regions,
missing role records and conflicts with no present alternatives are invalid.

When ours is present, the review block replaces its owned line region. Empty base
or theirs sides are represented by adjacent markers. When ours is absent, no
owned insertion point exists: retain ours and append an empty-ours review block
at EOF. The block's metadata records `placement: end_of_ours_absent_owner`; do not
invent a source span or report the block as replacing an owned ours region.
Multiple absent owners receive distinct blocks in deterministic conflict order.
Present ours regions still reject overlapping line ownership.

If retained ours has no final newline, insert a separately attributed
`conflict_line_boundary` newline before appending markers. Original source bytes
are not normalized; CRLF and UTF-8 remain intact. Marker positions count actual
output newlines, not attribution records: one output line can contain both a
source fragment and a synthesized terminating newline.

The kernel CLI reports `absent_owner_review_markers` when appending an absent-owner
block. The typed Git operation reports `git-absent-owner-conflict-review` and its
source-backed rendering evidence. Ordinary owned-region placement retains its
existing strategy. Both paths remain conflicts with no merged output, and no
successful JSON reparse or structural-equivalence claim. This is not a whole-file
marker fallback or a transfer of default-provider authority.

This extends the previous unsupported absent-side case; it does not loosen
overlap rejection, parser failure handling or canonical conflict decisions.
The Slice 951 delete/edit fixture remains unchanged. The polyglot absent-owner
fixture now requires exact review bytes instead of the prior unrendered result.
