## Slice 85: Review Decision Diagnostics

Expose rejected review-decision identity in structured diagnostics.

Goals:
- keep review-decision rejection machine-readable
- avoid forcing hosts to parse diagnostic prose
- preserve the existing severity/category/message surface

This slice defines one narrow contract:

1. diagnostics may expose `request_id`
2. diagnostics may expose `action`
3. explicit review-decision validation failures populate both fields

Fixture:
- `explicit-review-decision-missing-context.json`
