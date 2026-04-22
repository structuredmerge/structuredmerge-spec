`ruby-merge` MUST support an end-to-end nested merge that combines:

- baseline parent Ruby merge, and
- applied outputs for matched delegated child surfaces.

Given template and destination Ruby documents plus nested child outputs keyed by
discovered child-surface address, the family package MUST:

1. perform the normal parent Ruby merge first
2. discover delegated child surfaces in the merged parent result
3. rewrite only the targeted child surfaces with the provided nested outputs
4. preserve the surrounding parent Ruby source and untouched child surfaces

For YARD example block surfaces, rewritten lines MUST retain the original
comment/body prefix style from the merged parent result.

If a requested child surface address cannot be resolved in the merged parent
result, the merge MUST fail with `configuration_error`.
