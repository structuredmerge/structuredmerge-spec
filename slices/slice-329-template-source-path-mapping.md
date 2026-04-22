## Slice 329: Template Source Path Mapping

`ast-merge` MUST provide a shared helper that maps a template source-relative
path to its logical destination-relative path.

The mapping helper MUST:

1. preserve the original path when no template suffix is present
2. strip one trailing `.example` suffix
3. strip one trailing `.no-osc.example` suffix before considering `.example`
4. leave non-suffix `.example` segments untouched

This slice defines the path-normalization seam used by a future template-tree
runner before any gem-name rewriting, token expansion, strategy selection, or
filesystem writes occur.
