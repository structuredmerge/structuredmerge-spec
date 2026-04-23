## Slice 372: Template Directory Session Runner Payload Outcome Report

`ast-template` MUST provide one top-level runner that accepts the session
runner payload from slice 371 and returns the stable session outcome shape.

The payload runner MUST:

1. accept one product-facing session runner payload,
2. normalize that payload through the slice-371 payload report,
3. normalize the resulting runner input through slice 370,
4. execute the resulting runner request through slice 369, and
5. return the same top-level session outcome shape as the existing request
   runner.

The fixture covers:

1. a ready direct-options payload,
2. a blocked direct-options payload with inferred request kind,
3. a ready profile payload using a default profile name, and
4. a blocked profile payload with an explicit missing profile name.
