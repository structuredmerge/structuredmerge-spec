## Slice 397: Template Directory Session Entrypoint Envelope Application

Execute top-level session entrypoint inputs from the supported transport
envelope.

Goals:
- accept the supported session entrypoint transport envelope from slice 395
- unwrap the enclosed entrypoint without changing its meaning
- execute the entrypoint through the existing top-level helper

This slice defines one narrow application contract:

1. a supported session entrypoint transport envelope may be imported and
   executed
2. the imported entrypoint routes through the same top-level helper already
   used for direct entrypoint execution
3. the resulting session outcome matches the equivalent direct entrypoint
4. rejected envelopes preserve the hard edge defined by slice 396

Fixture:
- `template-directory-session-entrypoint-envelope-application.json`
