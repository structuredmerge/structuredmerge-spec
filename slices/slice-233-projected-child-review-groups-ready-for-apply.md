# Slice 233: Projected Child Review Groups Ready For Apply

`ast-merge` MUST provide a helper that selects projected child review groups
whose `case_ids` have all been resolved.

The helper:

- MUST preserve the original group shape.
- MUST return only groups whose `case_ids` are entirely present in the supplied
  resolved case identifier set.
- MUST NOT collapse or rewrite incomplete sibling groups.

This slice defines the stable delegated-child apply boundary for partial replay.
