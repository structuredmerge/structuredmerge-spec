## Slice 375: Template Directory Session Resolution Report

`ast-template` MUST provide one final pre-execution resolution report above the
entrypoint layer.

The session resolution report MUST:

1. accept the same top-level entrypoint input as slice 373,
2. accept the active session profile set,
3. report the selected `source_kind`,
4. include the normalized `runner_request`, and
5. include the normalized `session_request` report that would be executed.

The fixture covers:

1. a ready direct-options payload source,
2. a blocked direct-options request source,
3. a ready profile request source, and
4. a blocked profile payload source.
