## Slice 301: Reviewed Nested Execution Transport Envelope

Wrap reviewed nested execution inputs in one explicit versioned transport
envelope.

Goals:
- define one stable reviewed-nested transport kind
- reuse the baseline review transport version
- keep the underlying reviewed nested execution payload unchanged

This slice defines one narrow contract:

1. exported reviewed nested execution inputs may be wrapped in an envelope
2. the envelope carries `kind`, `version`, and `execution`
3. the baseline reviewed-nested transport kind is `reviewed_nested_execution`
4. the baseline review transport version is `1`

Fixture:
- `reviewed-nested-execution-envelope.json`
