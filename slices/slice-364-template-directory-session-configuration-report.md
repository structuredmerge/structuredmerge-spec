## Slice 364: Template Directory Session Configuration Report

`ast-template` MUST provide stable product-layer configuration diagnostics for
session setup before any directory walk or merge execution begins.

The configuration report MUST:

1. validate direct session options for required directory roots,
2. validate profile-based session requests for a missing named profile,
3. surface all configuration failures as `configuration_error` diagnostics with
   stable `reason` values, and
4. return `ready: true` only when the session request is valid enough to run.

The fixture covers:

1. a valid direct options request,
2. a direct options request missing both roots,
3. a valid profile-based request,
4. a profile-based request with an unknown profile name, and
5. a profile-based request with a known profile but missing roots in the
   overrides.
