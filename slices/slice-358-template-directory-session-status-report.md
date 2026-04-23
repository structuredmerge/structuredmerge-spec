## Slice 358: Template Directory Session Status Report

`ast-template` MUST provide a stable session-status summary above the
directory session envelope.

Given an existing session envelope, the session-status helper MUST:

1. include the session `mode`,
2. report `ready` as `true` only when there are no missing adapter families and
   no blocked plan entries,
3. include the sorted `missing_families`,
4. include the ordered `blocked_paths`,
5. include `planned_write_count` derived from plan entries with `create` or
   `update` status, and
6. include `written_count` derived from the directory apply report when present,
   otherwise `0`.

The fixture covers:

1. a dry-run session with a missing required adapter and a blocked path,
2. a successful apply session with writes performed, and
3. a filtered-discovery apply session that remains not ready because a required
   family adapter is unavailable.
