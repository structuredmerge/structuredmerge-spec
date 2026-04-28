## Slice 394: Template Directory Session Command Payload Envelope Application

Execute top-level session command-payload inputs from the supported transport
envelope.

Goals:
- accept the supported session command-payload transport envelope from slice
  392
- unwrap the enclosed command-payload without changing its meaning
- execute the payload through the existing top-level helper

This slice defines one narrow application contract:

1. a supported session command-payload transport envelope may be imported and
   executed
2. the imported command-payload routes through the same top-level helper
   already used for direct command-payload execution
3. the resulting dispatch report matches the equivalent direct command-payload
4. rejected envelopes preserve the hard edge defined by slice 393

Fixture:
- `template-directory-session-command-payload-envelope-application.json`
