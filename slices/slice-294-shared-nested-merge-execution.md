`ast-merge` MUST provide a shared nested-merge execution helper that
orchestrates:

- parent merge,
- delegated child discovery,
- delegated child output resolution,
- and parent reconstruction from applied delegated child outputs.

The shared helper MUST accept family-provided operations for:

1. merging the parent template and destination sources
2. discovering delegated child operations from the merged parent result
3. applying resolved delegated child outputs back into the merged parent result

Given nested child outputs keyed by delegated child `surface_address`, the
shared helper MUST:

1. execute the parent merge first
2. stop immediately if parent merge fails
3. discover delegated child operations from the merged parent result
4. stop immediately if delegated child discovery fails
5. resolve nested child outputs through the shared delegated-child output
   resolution helper
6. apply the resolved delegated child outputs through the family-provided
   reconstruction callback

The helper MUST return the reconstructed parent output from the family-provided
apply step without altering its success state, diagnostics, or policies.
