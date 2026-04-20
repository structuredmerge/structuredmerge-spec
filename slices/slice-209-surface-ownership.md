## Slice 209: Surface Ownership

Defines a portable ownership shape for discovered merge surfaces.

Rules:
- A discovered surface MUST expose a stable `address`.
- A discovered surface MUST expose an `owner` reference describing the source
  from which the surface was derived.
- Ownership MAY come from parser structure, an owned region, or another
  parent surface.
- A discovered surface MAY expose `declared_language` in addition to
  `effective_language`.
- A discovered surface SHOULD expose a reconstruction strategy and any
  family-specific metadata required to safely rewrite the owned fragment.

This slice does not require a single parser architecture. It only standardizes
the observable shape families can use to report discovered nested surfaces.
