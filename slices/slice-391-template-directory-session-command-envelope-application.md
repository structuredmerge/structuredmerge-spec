## Slice 391: Template Directory Session Command Envelope Application

Execute top-level session command inputs from the supported transport envelope.

Goals:
- accept the supported session-command transport envelope from slice 389
- unwrap the enclosed command payload without changing its meaning
- execute the command through the existing top-level helper

This slice defines one narrow application contract:

1. a supported session-command transport envelope may be imported and executed
2. the imported command routes through the same top-level helper already used
   for direct command execution
3. the resulting dispatch report matches the equivalent direct command
4. rejected envelopes preserve the hard edge defined by slice 390

Fixture:
- `template-directory-session-command-envelope-application.json`
