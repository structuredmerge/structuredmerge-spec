## Slice 368: Template Directory Session Request Outcome Report

`ast-template` MUST execute a normalized session request report without
recomputing request readiness through a separate setup path.

Given a session request report, the request outcome helper MUST:

1. execute the embedded `resolved_options` when the request is ready,
2. return the existing configuration-failure outcome shape when the request is
   not ready,
3. preserve the request `mode`, and
4. return the same top-level session outcome shape as the options-based and
   profile-based runners.

The fixture covers:

1. a ready direct-options request,
2. a blocked direct-options request,
3. a ready profile request, and
4. a blocked profile request.
