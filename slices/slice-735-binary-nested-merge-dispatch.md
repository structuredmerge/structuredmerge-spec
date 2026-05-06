# Slice 735: Binary nested merge dispatch

## Goal

Route structured payloads embedded in binary containers through the existing
reviewed nested-merge machinery.

## Contract

Binary-family planners may emit nested dispatches when a byte range or archive
member is identified as another mergeable family. Dispatch identity must include:

1. the parent binary schema path;
2. the selected child family;
3. the child input bytes after container-level extraction or decompression;
4. the reviewed nested-execution request id;
5. the status of the child result before final binary rendering.

Nested dispatch may recur. For example, a ZIP member `docs/readme.md` dispatches
to Markdown, a Markdown fence may dispatch to Markdown again, and that nested
Markdown may dispatch a Ruby code fence whose YARD comments dispatch back to
Markdown.

## Rendering Boundary

Binary render providers do not perform child merges. They receive reviewed child
outputs as final member or range bytes. The parent binary provider then updates
container metadata such as CRC32, compressed size, uncompressed size, offsets,
central directories, and preserved-range evidence.

## Safety

Unchanged binary members must be preserved without nested dispatch. Changed
members that require nested output must remain unresolved until the reviewed
nested-execution contract accepts the child output. Rendering fails closed when
a required child output is missing, rejected, or belongs to a different request
id than the reviewed plan.
