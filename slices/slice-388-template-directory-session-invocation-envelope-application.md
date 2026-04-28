## Slice 388: Template Directory Session Invocation Envelope Application

Execute top-level session invocation inputs from the supported transport
envelope.

Goals:
- accept the supported session-invocation transport envelope from slice 386
- unwrap the enclosed invocation payload without changing its meaning
- execute the invocation through the slice-383 helper

This slice defines one narrow application contract:

1. a supported session-invocation transport envelope may be imported and
   executed
2. the imported invocation routes through the same top-level helper defined by
   slice 383
3. the resulting dispatch report matches the equivalent direct invocation
4. rejected envelopes preserve the hard edge defined by slice 387

Fixture:
- `template-directory-session-invocation-envelope-application.json`
