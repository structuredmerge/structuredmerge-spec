## Slice 418: Template Directory Session Diagnostics Envelope Application

Apply the supported session-diagnostics transport envelope through the
existing top-level consumers.

Goals:
- accept the supported session-diagnostics transport envelope from slice 416
- unwrap the enclosed diagnostics report without changing its meaning
- reuse the same stable top-level diagnostics shape already consumed directly

This slice defines one narrow application contract:

1. a supported session-diagnostics transport envelope may be imported and
   exposed unchanged to the caller
2. the imported diagnostics preserve the exact top-level readiness and
   diagnostic-entry fields
3. the resulting object matches the equivalent direct session diagnostics
   report
4. rejected envelopes preserve the hard edge defined by slice 417

Fixture:
- `template-directory-session-diagnostics-envelope-application.json`
