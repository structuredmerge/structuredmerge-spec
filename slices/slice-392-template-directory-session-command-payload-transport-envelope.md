## Slice 392: Template Directory Session Command Payload Transport Envelope

Wrap top-level session command-payload inputs in one explicit versioned
transport envelope.

Goals:
- define one stable session command-payload transport kind
- define one explicit transport version
- keep the underlying command-payload unchanged

This slice defines one narrow contract:

1. exported session command-payload inputs may be wrapped in an envelope
2. the envelope carries `kind`, `version`, and `payload`
3. the baseline session command-payload transport kind is
   `template_directory_session_command_payload`
4. the baseline session transport version is `1`

Fixture:
- `template-directory-session-command-payload-envelope.json`
