## Slice 348: Mini Template Tree Directory Run Report

`ast-merge` MUST provide a directory-backed miniature template tree runner that
reads `template/` and `destination/` roots, executes the existing shared tree
run, and reports the result through the same stable run-report helper.

Given:

1. a real miniature template tree stored on disk, and
2. a real multi-family merge callback that updates Markdown, TOML, and Ruby
   entries,

the directory-backed runner MUST:

1. read the template and destination trees using relative paths,
2. preserve the same execution-plan order as the in-memory runner, and
3. produce the same stable run report as the shared multi-family miniature
   fixture.
