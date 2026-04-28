## Slice 386: Template Directory Session Invocation Transport Envelope

Wrap top-level session invocation inputs in one explicit versioned transport
envelope.

Goals:
- define one stable session-invocation transport kind
- define one explicit transport version
- keep the underlying invocation payload unchanged

This slice defines one narrow contract:

1. exported session invocation inputs may be wrapped in an envelope
2. the envelope carries `kind`, `version`, and `invocation`
3. the baseline session-invocation transport kind is
   `template_directory_session_invocation`
4. the baseline session transport version is `1`

Fixture:
- `template-directory-session-invocation-envelope.json`
