## Slice 73: Review State Transport Envelope

Wrap exported review state in one explicit versioned transport envelope.

Goals:
- define one stable review-state transport kind
- define one explicit transport version
- keep the underlying review-state payload unchanged

This slice defines one narrow contract:

1. exported conformance-manifest review state may be wrapped in an envelope
2. the envelope carries `kind`, `version`, and `state`
3. the baseline review-state transport kind is
   `conformance_manifest_review_state`
4. the baseline review transport version is `1`

Fixture:
- `review-state-envelope.json`
