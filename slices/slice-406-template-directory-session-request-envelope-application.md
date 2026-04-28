## Slice 406: Template Directory Session Request Envelope Application

Execute normalized session-request inputs from the supported transport
envelope.

Goals:
- accept the supported session-request transport envelope from slice 404
- unwrap the enclosed request report without changing its meaning
- execute the request through the existing top-level helper

This slice defines one narrow application contract:

1. a supported session-request transport envelope may be imported and executed
2. the imported request report routes through the same top-level helper already
   used for direct session-request execution
3. the resulting session outcome matches the equivalent direct request report
4. rejected envelopes preserve the hard edge defined by slice 405

Fixture:
- `template-directory-session-request-envelope-application.json`
