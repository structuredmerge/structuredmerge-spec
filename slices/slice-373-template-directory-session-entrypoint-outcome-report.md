## Slice 373: Template Directory Session Entrypoint Outcome Report

`ast-template` MUST provide one top-level session entrypoint above the runner
request and runner payload layers.

The session entrypoint MUST:

1. accept a top-level input containing either a runner `payload` or a runner
   `request`,
2. execute `payload` inputs through the slice-372 payload runner,
3. execute `request` inputs through the slice-369 request runner,
4. avoid requiring callers to care which normalization layer they are entering
   through, and
5. return the same stable session outcome shape for both sources.

The fixture covers:

1. a ready direct-options payload source,
2. a blocked direct-options request source,
3. a ready profile request source, and
4. a blocked profile payload source.
