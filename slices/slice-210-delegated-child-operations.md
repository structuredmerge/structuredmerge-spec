## Slice 210: Delegated Child Operations

Defines the portable operation shape for running a merge against a discovered
child surface.

Rules:
- A delegated child operation MUST identify both its own `operation_id` and
  its `parent_operation_id`.
- A delegated child operation MUST carry the discovered child `surface`.
- A delegated child operation MUST expose a `requested_strategy`.
- A delegated child operation MUST expose `language_chain` when the host keeps
  track of nested language context.
- The delegated child-operation shape is transportable and does not require
  inline execution or a particular runtime session implementation.
