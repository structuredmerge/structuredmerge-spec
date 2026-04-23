## Slice 369: Template Directory Session Request Runner Report

`ast-template` MUST provide one top-level request runner that accepts either a
direct options request or a named profile request and returns the stable session
outcome shape.

The request runner MUST:

1. accept a direct `options` request source,
2. accept a named `profile` request source with overrides,
3. internally build the normalized session request report from slice 367,
4. execute it through the request-outcome path from slice 368, and
5. return the same top-level session outcome shape as the existing options and
   profile runners.

The fixture covers:

1. a ready direct-options request,
2. a blocked direct-options request,
3. a ready profile request, and
4. a blocked profile request.
