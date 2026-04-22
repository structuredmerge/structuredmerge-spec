`ast-merge` MUST provide a shared delegated-child apply execution helper that
consumes:

- parent merge execution,
- delegated child discovery,
- a delegated child apply plan,
- and applied delegated child outputs keyed by delegated child operation id.

The shared helper MUST:

1. execute parent merge first
2. stop immediately if parent merge fails
3. discover delegated child operations from the merged parent result
4. stop immediately if delegated child discovery fails
5. invoke the family-provided delegated-child apply callback with:
   - the merged parent output,
   - discovered delegated child operations,
   - the supplied delegated child apply plan,
   - and the supplied applied delegated child outputs

The helper MUST return the family-provided apply result unchanged.
