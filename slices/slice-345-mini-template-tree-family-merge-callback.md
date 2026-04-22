## Slice 345: Mini Template Tree Family Merge Callback

`ast-merge` miniature template-tree runners MUST remain compatible with real
family merge callbacks.

Given:

1. a miniature template tree whose execution plan contains a
   `merge_prepared_content` entry with an existing destination, and
2. a family merge callback that dispatches by the execution entry's classified
   family and dialect,

executing the tree run MUST:

1. invoke the real family merge implementation for that entry,
2. return the same execution plan shape as ordinary tree planning, and
3. return an `apply_result` whose merged output reflects the family merge
   result, not a fixture stub.

The first required real-family case for this slice is Markdown.
