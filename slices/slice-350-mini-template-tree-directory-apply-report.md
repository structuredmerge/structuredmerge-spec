## Slice 350: Mini Template Tree Directory Apply Report

`ast-merge` MUST provide a stable report helper for directory-backed template
application runs.

Given:

1. a first directory-backed apply run that writes updated files to disk, and
2. a second directory-backed apply run over that already-updated destination
   tree,

the directory apply report helper MUST:

1. preserve execution-plan order in reported entries,
2. emit one report entry per execution-plan entry,
3. include a `written` flag for each entry,
4. mark `written: true` only for entries whose content was actually written to
   disk during the apply run, and
5. summarize `created`, `updated`, `kept`, `blocked`, `omitted`, and `written`
   totals for the run.
