## Slice 371: Template Directory Session Runner Payload Report

`ast-template` MUST provide one top-level payload contract above the session
runner-input report.

The session runner payload report MUST:

1. accept a single product-facing payload object,
2. infer `request_kind` as `options` when no profile wiring is present,
3. infer `request_kind` as `profile` when profile wiring is present and no
   explicit request kind is supplied,
4. resolve `profile_name` from an explicit value first, then from
   `default_profile_name`, and
5. normalize the result into the session runner-input shape from slice 370.

The fixture covers:

1. an explicit direct-options payload,
2. a direct-options payload with inferred request kind,
3. a profile payload using a default profile name, and
4. a profile payload where an explicit profile name overrides the default.
