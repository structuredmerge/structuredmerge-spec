## Slice 400: Template Directory Session Runner Request Envelope Application

Execute top-level session runner-request inputs from the supported transport
envelope.

Goals:
- accept the supported session runner-request transport envelope from slice 398
- unwrap the enclosed request without changing its meaning
- execute the request through the existing top-level helper

This slice defines one narrow application contract:

1. a supported session runner-request transport envelope may be imported and
   executed
2. the imported request routes through the same top-level helper already used
   for direct runner-request execution
3. the resulting session outcome matches the equivalent direct runner-request
4. rejected envelopes preserve the hard edge defined by slice 399

Fixture:
- `template-directory-session-runner-request-envelope-application.json`
