`ruby-merge` MUST provide a reviewed nested-merge entrypoint that consumes:

- parent template Ruby source,
- parent destination Ruby source,
- Ruby dialect,
- delegated child review state aligned to discovered Ruby delegated-child
  operations,
- and applied delegated child outputs keyed by delegated child operation id.

The entrypoint MUST:

1. perform the parent Ruby merge first
2. rediscover delegated child operations from the merged parent output
3. derive the delegated-child apply plan from the supplied review state
4. apply only accepted delegated child outputs
5. return the final reconstructed parent Ruby output

Pending delegated child review requests MUST NOT affect the final output.
