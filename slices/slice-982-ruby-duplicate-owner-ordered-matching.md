# Slice 982: Ruby Duplicate Owner Ordered Matching

Ruby should prove duplicate source-owner matching through a stable ordered
cursor model. Repeated owner identities must pair 1:1 by structural identity and
occurrence index instead of collapsing to one match.

This fixture uses duplicate Ruby method definitions because they exercise the
same ambiguity class as repeated source owners in other languages and DSLs.

