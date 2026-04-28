## Slice 403: Template Directory Session Runner Payload Envelope Application

Execute top-level session runner-payload inputs from the supported transport
envelope.

Goals:
- accept the supported session runner-payload transport envelope from slice 401
- unwrap the enclosed payload without changing its meaning
- execute the payload through the existing top-level helper

This slice defines one narrow application contract:

1. a supported session runner-payload transport envelope may be imported and
   executed
2. the imported payload routes through the same top-level helper already used
   for direct runner-payload execution
3. the resulting session outcome matches the equivalent direct runner-payload
4. rejected envelopes preserve the hard edge defined by slice 402

Fixture:
- `template-directory-session-runner-payload-envelope-application.json`
