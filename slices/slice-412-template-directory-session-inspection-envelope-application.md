## Slice 412: Template Directory Session Inspection Envelope Application

Apply the supported session-inspection transport envelope through the existing
top-level consumers.

Goals:
- accept the supported session-inspection transport envelope from slice 410
- unwrap the enclosed inspection report without changing its meaning
- reuse the same stable top-level inspection shape already consumed directly

This slice defines one narrow application contract:

1. a supported session-inspection transport envelope may be imported and
   exposed unchanged to the caller
2. the imported inspection preserves the exact top-level entrypoint,
   resolution, capability, status, and diagnostic report shape
3. the resulting object matches the equivalent direct session inspection
4. rejected envelopes preserve the hard edge defined by slice 411

Fixture:
- `template-directory-session-inspection-envelope-application.json`
