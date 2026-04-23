## Slice 349: Mini Template Tree Directory Apply Convergence

`ast-merge` MUST provide a directory-backed miniature template tree apply helper
that writes successful outputs into a destination tree and preserves second-run
no-op behavior.

Given:

1. a real miniature template tree stored on disk,
2. a real multi-family merge callback that updates Markdown, TOML, and Ruby
   entries, and
3. a destination tree seeded with pre-merge content,

the directory-backed apply helper MUST:

1. write created and updated files into the destination tree using relative
   paths,
2. leave blocked, omitted, and untouched destination files unchanged,
3. classify an apply result as `kept` when the produced output already matches
   the destination content, and
4. produce a second run report whose entries are all `kept` after the first
   successful apply has been written to disk.
