# Slice 978: Ruby Independent Method Child-Group Merge

Ruby should prove the source-family child-group behavior before the same
contract is ported to the other runtimes.

This fixture covers the common false-conflict case where two revisions add
different methods to the same class body. The expected merge keeps the
destination class order, preserves destination-owned members, and appends the
template-only method as a class child instead of treating the class body as one
conflicting text range.

