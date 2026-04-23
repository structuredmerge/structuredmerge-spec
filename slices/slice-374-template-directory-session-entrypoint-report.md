## Slice 374: Template Directory Session Entrypoint Report

`ast-template` MUST provide a dry report for the session entrypoint layer.

The session entrypoint report MUST:

1. accept the same top-level input as slice 373,
2. identify whether the selected source is `payload` or `request`,
3. normalize `payload` sources into the runner request shape,
4. preserve `request` sources in the runner request shape, and
5. avoid executing the session.

The fixture covers:

1. a ready direct-options payload source,
2. a blocked direct-options request source,
3. a ready profile request source, and
4. a blocked profile payload source.
