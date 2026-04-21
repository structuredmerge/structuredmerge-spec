# Slice 254: Family Merge Adapter Boundary

## Goal

Define the boundary between shared merge-contract tooling and family-local
merge packages.

## Contract

1. a family merge package MUST remain responsible for parser, grammar, and
   runtime-specific discovery of merge subjects, nested surfaces, and
   family-local interpretation rules
2. when family-local behavior can be expressed through an existing shared
   contract shape, the family merge package MUST emit that shared shape instead
   of introducing a parallel family-specific transport
3. shared tooling MUST accept normalized family output through shared contract
   shapes without requiring knowledge of the originating parser or runtime
4. canonical review, default, replay, and apply planning SHOULD operate on the
   normalized shared shapes emitted by family merge packages
5. family merge packages MAY attach generic extension entries when a required
   behavior cannot yet be represented through an existing shared shape
6. shared tooling MUST preserve family-emitted shared shape identity and
   extension references so equivalent logical results remain reconstructible
   across implementations

## Notes

- This slice defines an adapter boundary, not a packaging requirement.
- It allows different implementations to discover and normalize family data in
  different ways while still targeting the same portable merge contract.
