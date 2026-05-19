# Slice 980: Ruby Same-Owner Intra-Owner Merge

Ruby should report when two revisions touch the same source owner body and the
merge remains scoped to that owner instead of widening into a whole-file source
conflict.

This fixture uses a class method with the same owner identity and different
body content in template and destination. The current Ruby policy keeps the
destination-owned body, but the important portable behavior is that the matched
method is recognized as an intra-owner merge decision under the containing
class child group.

