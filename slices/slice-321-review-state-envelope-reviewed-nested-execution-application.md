## Slice 321: Review State Envelope Reviewed Nested Execution Application

Execute reviewed nested work directly from a
`conformance_manifest_review_state` transport envelope.

Goals:
- make review-state transport artifacts directly executable at the shared
  `ast-merge` layer
- preserve the existing reviewed nested execution behavior from slice 308
- keep import and execution behavior aligned across hosts

This slice defines one contract:

1. a valid `conformance_manifest_review_state` envelope may be imported and
   executed
2. the resulting reviewed nested execution runs match the equivalent direct
   review-state execution

Fixture:
- `review-state-envelope-reviewed-nested-execution-application.json`
