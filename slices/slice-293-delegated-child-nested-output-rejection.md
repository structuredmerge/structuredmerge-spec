`ast-merge` MUST reject nested child outputs that reference a delegated child
surface address that does not exist in the current delegated child operations.

Given delegated child operations and nested child outputs keyed by
`surface_address`, if any requested surface address cannot be resolved, the
shared helper MUST:

1. fail the resolution attempt
2. emit a `configuration_error` diagnostic
3. identify the missing delegated child surface address in the diagnostic
   message

The helper MUST NOT synthesize a delegated child apply plan or applied child
outputs for a rejected request.
