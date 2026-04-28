## Slice 409: Template Directory Session Outcome Envelope Application

Apply the supported session-outcome transport envelope through the existing
top-level consumers.

Goals:
- accept the supported session-outcome transport envelope from slice 407
- unwrap the enclosed outcome without changing its meaning
- reuse the same stable top-level outcome shape already consumed directly

This slice defines one narrow application contract:

1. a supported session-outcome transport envelope may be imported and exposed
   unchanged to the caller
2. the imported outcome preserves the exact top-level plan or registry-backed
   report shape
3. the resulting object matches the equivalent direct session outcome
4. rejected envelopes preserve the hard edge defined by slice 408

Fixture:
- `template-directory-session-outcome-envelope-application.json`
