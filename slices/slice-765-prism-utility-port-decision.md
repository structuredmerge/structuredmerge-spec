# Slice 765: Prism Utility Port Decision

## Goal

Decide whether any old `prism-merge` utilities should be ported now.

## Decision

Do not port additional old Prism utilities in this README migration pass.

The active workspace already has fixture-backed `ruby-merge` and `prism-merge`
behavior for the current public contract:

- Ruby family/provider metadata;
- Prism provider metadata;
- owner analysis and path/equality matching;
- module merge;
- doc-comment nested merge;
- reviewed nested merge;
- structured-edit Prism provider projections;
- Gemfile/gemspec policy fixtures.

All other old Prism utilities should wait for future fixtures that define the
behavior and destination package:

- portable Ruby family behavior goes to `ruby-merge`;
- Prism parser/provider behavior goes to `prism-merge`;
- gem templating and scaffold cleanup behavior goes to `kettle-jem` or a
  recipe/tooling fixture.

## Future Fixture Order

Recommended future order:

1. Magic comments and `:nocov:` wrappers.
2. Ruby freeze blocks.
3. Begin/rescue semantics.
4. Recursive class/module/call body merge.
5. Method fuzzy matching and moved-node detection.
6. Kettle/Jem gemspec variable rename and scaffold chunk removal recipes.

Until those fixtures exist, generated READMEs should avoid old advanced Prism
claims.
