## Slice 367: Template Directory Session Request Report

`ast-template` MUST provide one normalized request-report shape for both
options-based and profile-based session setup.

The request report MUST:

1. identify whether the request came from direct `options` or a named
   `profile`,
2. report the resolved session `mode`,
3. expose the stable configuration diagnostics from slice 364,
4. include `resolved_options` when the request is ready to execute, and
5. return `resolved_options: null` when the request is not ready.

The fixture covers:

1. a valid direct options request,
2. an invalid direct options request with missing roots,
3. a valid named profile request, and
4. an invalid named profile request with an unknown profile name.
