# Slice 731: ZIP merge planner

## Goal

Plan ZIP member operations against source, destination, and ancestor archives
without rendering the final archive.

## Contract

The ZIP merge planner produces member decisions:

1. `preserve` for unchanged members whose compressed bytes can be copied;
2. `delegate` for safe structured members that can be merged by an existing
   source, config, or document family;
3. `rewrite` for changed members whose bytes are supplied directly or returned
   by a delegated family;
4. `add` and `delete` for archive membership changes;
5. `reject` for unsafe or unsupported mutations.

Planner output also includes:

- preserved byte ranges;
- checksum and length updates required by later rendering;
- nested dispatch requests and statuses;
- diagnostics for conflicts, duplicate paths, traversal paths, encrypted
  members, signing-sensitive members, and executable mutations.

## Nested Merge Dispatch

ZIP members may themselves be structured merge inputs. The planner must be able
to emit nested dispatches for changed members whose normalized path, MIME
metadata, or format sniffing selects another family. For example:

- `docs/readme.md` dispatches to Markdown;
- `docs/readme.md` may then dispatch fenced code blocks back to Markdown, Ruby,
  JSON, or another family;
- Ruby members may dispatch YARD comment regions to Markdown;
- nested outputs return as member bytes before ZIP rendering.

Nested dispatches are recursive through the existing reviewed nested-execution
contract. The ZIP planner owns only archive membership, path safety, compressed
member ranges, and renderer evidence. The selected nested family owns parsing,
merge semantics, review artifacts, and final uncompressed member bytes.

Plans must preserve unchanged archive members without invoking nested work.
Nested dispatch is only required for members that are added, rewritten, or
changed relative to the selected merge side.

## Boundary

The planner may request nested merges, but nested families own their own merge
semantics. The ZIP planner only owns archive membership, metadata, and byte
range safety.
