## Slice 335: Template Token Keys

`ast-merge` MUST provide a shared helper that discovers unique template token
keys in first-appearance order.

The default template token grammar for this helper MUST match the historical
template runner contract:

- `pre`: `{`
- `post`: `}`
- `separators`: `["|", ":"]`
- `min_segments`: `2`
- `segment_pattern`: `[A-Za-z0-9_]`

The helper MUST also accept an explicit token-grammar override so callers can
use a different delimiter or separator set when needed.

Malformed token-shaped text MUST be ignored rather than reported as a valid
token key.
