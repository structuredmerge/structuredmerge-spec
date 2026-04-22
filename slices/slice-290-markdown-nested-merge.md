`markdown-merge` MUST support an end-to-end nested merge that combines:

- baseline parent Markdown merge, and
- applied outputs for matched delegated child surfaces.

Given template and destination Markdown documents plus nested child outputs keyed
by discovered fenced-code surface address, the family package MUST:

1. perform the normal parent Markdown merge first
2. discover delegated child surfaces in the merged parent result
3. rewrite only the targeted child surfaces with the provided nested outputs
4. preserve the surrounding parent Markdown structure and untouched child
   surfaces

If a requested child surface address cannot be resolved in the merged parent
result, the merge MUST fail with `configuration_error`.
