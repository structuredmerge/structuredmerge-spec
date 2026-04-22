## Slice 332: Template Strategy Selection

`ast-merge` MUST provide a shared helper that selects the template-application
strategy for one logical destination-relative path.

The selector MUST:

1. default to `merge`
2. accept explicit override entries keyed by relative path
3. honor exact-path overrides before the default
4. support the strategy vocabulary:
   - `merge`
   - `accept_template`
   - `keep_destination`
   - `raw_copy`

This slice defines stable strategy selection from explicit data only. It does
not parse project config files or execute any merge/write behavior.
