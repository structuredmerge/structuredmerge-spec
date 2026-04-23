## Slice 347: Mini Template Tree Multi-Family Run Report

`ast-merge` MUST report multi-family miniature tree runs through the same stable
run-report helper.

Given:

1. a multi-family `template_tree_run` result whose real merge callbacks update
   Markdown, TOML, and Ruby entries,

the run-report helper MUST:

1. preserve execution-plan order in reported `entries`,
2. emit one report entry per execution-plan entry,
3. classify each merged entry status as `updated`, and
4. summarize the total counts across the run.
