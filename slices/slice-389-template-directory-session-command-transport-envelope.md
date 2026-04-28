## Slice 389: Template Directory Session Command Transport Envelope

Wrap top-level session command inputs in one explicit versioned transport
envelope.

Goals:
- define one stable session-command transport kind
- define one explicit transport version
- keep the underlying command payload unchanged

This slice defines one narrow contract:

1. exported session command inputs may be wrapped in an envelope
2. the envelope carries `kind`, `version`, and `command`
3. the baseline session-command transport kind is
   `template_directory_session_command`
4. the baseline session transport version is `1`

Fixture:
- `template-directory-session-command-envelope.json`
