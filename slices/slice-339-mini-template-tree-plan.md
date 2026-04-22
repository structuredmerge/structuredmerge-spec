## Slice 339: Mini Template Tree Plan

`ast-merge` MUST provide a shared helper that plans an ordered dry-run execution
for a whole template tree.

Given:

1. template source paths discovered from a real `template/` directory,
2. template source content keyed by template-relative path,
3. destination-relative existence and content state,
4. destination remapping context,
5. strategy overrides,
6. token replacements,

the helper MUST compose the existing template-path, planning, token-state,
prepared-content, and execution-plan helpers into one ordered execution plan.

This slice proves that a miniature real template tree can be walked and planned
portably without invoking any filesystem mutation APIs.
