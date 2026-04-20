## Slice 213: Markdown Delegated Child Operations

Defines the baseline mapping from Markdown discovered fence surfaces into
delegated child operations.

Rules:
- Each discovered fence surface SHOULD be convertible into a delegated child
  operation.
- Markdown delegated child operations SHOULD use `delegate_child_surface` as
  the requested strategy.
- The language chain SHOULD preserve the Markdown parent context before the
  child dialect context.
