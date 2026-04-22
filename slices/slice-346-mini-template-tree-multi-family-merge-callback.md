## Slice 346: Mini Template Tree Multi-Family Merge Callback

`ast-merge` miniature template-tree runners MUST support multi-family dispatch
through real family merge callbacks in a single run.

Given:

1. a miniature template tree whose execution plan contains multiple
   `merge_prepared_content` entries with existing destinations, and
2. a family merge callback that dispatches by classified family and dialect,

executing the tree run MUST:

1. invoke the real family merge implementation for each supported family,
2. preserve execution-plan order across those entries, and
3. return an `apply_result` whose merged outputs reflect the real family merge
   results for every dispatched family.

The required families for this slice are:

- Markdown
- TOML
- Ruby
