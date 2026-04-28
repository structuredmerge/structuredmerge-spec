## Slice 415: Template Directory Session Status Envelope Application

Apply the supported session-status transport envelope through the existing
top-level consumers.

Goals:
- accept the supported session-status transport envelope from slice 413
- unwrap the enclosed status report without changing its meaning
- reuse the same stable top-level status shape already consumed directly

This slice defines one narrow application contract:

1. a supported session-status transport envelope may be imported and exposed
   unchanged to the caller
2. the imported status preserves the exact top-level readiness and count
   fields
3. the resulting object matches the equivalent direct session status report
4. rejected envelopes preserve the hard edge defined by slice 414

Fixture:
- `template-directory-session-status-envelope-application.json`
