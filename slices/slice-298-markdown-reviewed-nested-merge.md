`markdown-merge` MUST provide a reviewed nested-merge entrypoint that consumes:

- parent template Markdown source,
- parent destination Markdown source,
- Markdown dialect,
- delegated child review state aligned to discovered Markdown delegated-child
  operations,
- and applied delegated child outputs keyed by delegated child operation id.

The entrypoint MUST:

1. perform the parent Markdown merge first
2. rediscover delegated child operations from the merged parent output
3. derive the delegated-child apply plan from the supplied review state
4. apply only accepted delegated child outputs
5. return the final reconstructed parent Markdown output

Pending delegated child review requests MUST NOT affect the final output.
