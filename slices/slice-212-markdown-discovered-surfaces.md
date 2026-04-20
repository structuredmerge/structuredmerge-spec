## Slice 212: Markdown Discovered Surfaces

Defines the baseline mapping from Markdown fenced code blocks into shared
discovered-surface transport.

Rules:
- Recognized fenced code blocks SHOULD be exposed as discovered surfaces.
- The discovered surface SHOULD preserve the fence language as
  `declared_language`.
- The discovered surface SHOULD expose the selected child dialect as
  `effective_language`.
- The discovered surface owner MAY remain the structural Markdown fence owner
  until richer span and region tracking is standardized.
