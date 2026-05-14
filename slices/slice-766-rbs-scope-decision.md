# Slice 766: RBS Scope Decision

## Goal

Decide whether old `rbs-merge` behavior is in scope for the current README
example migration pass, should be retired, or should be preserved for later
implementation.

## Evidence

The old `reference/rbs-merge` package contains real RBS-specific merge value:

- official RBS parser backend adapter;
- declaration matching by RBS signatures;
- recursive class/module/member merge behavior;
- comment attachment and preservation;
- template-only declaration insertion/removal behavior;
- configurable signature generator;
- freeze marker and freeze block support;
- merge result summaries and provenance-oriented result objects.

The old package also has reproducible fixtures for method add/remove/change,
comment preference/promotion, overloaded members, aliases, type aliases,
comment-only destinations, custom freeze markers, reason-bearing freeze
markers, and freeze blocks.

No active package exists today under `ruby/gems`, `go`, `rust/crates`, or
`typescript/packages` for an RBS family or provider.

## Decision

RBS is later, not retired.

Do not include `rbs-merge` as a current generated README family/package claim
until an active RBS package and fixture-backed contract exist. Keep the old
README value and old reproducible fixtures as migration source material for a
future Ruby-adjacent source/signature family.

The next time RBS work is resumed, start by creating a family feature profile
and portable fixtures before porting implementation. The old Ruby API shape is
not itself the new public contract.

## Future Fixture Order

Recommended future order:

1. Declaration identity for class/module/interface/type alias/constants/globals.
2. Method/member identity, including overloaded methods and attr declarations.
3. Recursive class/module/interface member merge.
4. Comment attachment, comment preference, and comment-only destination
   preservation.
5. Template-only declaration policy.
6. Freeze markers and freeze blocks, including custom and reason-bearing
   tokens.
7. Configurable signature generation.
8. Merge result summaries and provenance reporting.

Until those fixtures exist, generated READMEs should mention RBS only as a
future or unresolved package, not as active supported behavior.
