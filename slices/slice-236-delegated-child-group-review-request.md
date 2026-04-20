# Slice 236: Delegated Child Group Review Request

`ast-merge` MUST support a delegated child group review request kind.

The request:

- MUST use a stable request identifier derived from the delegated child group.
- MUST preserve the delegated child group shape in the request body.
- MUST use an apply action that does not require additional payload.

This slice extends the shared review transport so delegated child groups can be
reviewed without inventing a separate replay system.
