`ast-merge` MUST provide a shared helper that executes reviewed nested
execution payloads directly.

Given:

- a reviewed nested execution payload,
- parent merge execution,
- delegated child discovery,
- and family-provided delegated child application,

the shared helper MUST:

1. consume the reviewed nested execution payload directly
2. use the payload family as the reviewed nested merge family
3. use the payload review state as the reviewed nested merge review state
4. use the payload applied delegated child outputs unchanged
5. delegate execution to the shared reviewed nested merge execution pipeline

This contract binds the reviewed nested execution transport payload to actual
shared nested-merge execution.
