`ast-merge` MUST provide a shared reviewed nested-merge execution helper that
consumes delegated child review state instead of raw nested child outputs.

Given:

- delegated child group review state,
- a family name,
- and applied delegated child outputs keyed by delegated child operation id,

the shared helper MUST:

1. derive a delegated child apply plan from the supplied review state
2. preserve accepted delegated child-group ordering from the review state
3. execute shared delegated-child apply execution using the derived apply plan
4. skip any pending delegated child review requests that were not accepted for
   apply

This contract binds delegated child review and delegated child application into
the shared nested-merge execution pipeline.
