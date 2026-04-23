## Slice 370: Template Directory Session Runner Input Report

`ast-template` MUST provide a product-facing input contract that normalizes a
single top-level session runner payload into the lower-level session request
shape from slice 369.

The runner input report MUST:

1. accept one top-level payload with `request_kind`,
2. normalize direct `options` requests into the lower-level runner request
   shape,
3. normalize named `profile` requests into the lower-level runner request shape
   while preserving omitted override fields, and
4. avoid requiring callers to manually assemble nested runner request objects.

The fixture covers:

1. a ready direct-options input,
2. a blocked direct-options input,
3. a ready profile input, and
4. a blocked profile input.
