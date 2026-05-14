# Slice 764: Prism/Ruby Fixture Coverage Verification

## Goal

Verify fixture coverage for old `prism-merge` behavior called out by the README
migration task: begin/rescue semantics, magic comments, `:nocov:`, gemspec
variable rename, top-level runner behavior, recursive body merge, and scaffold
chunk removal.

## Current Fixture-Backed Claims

The current Ruby family can claim:

- Ruby feature, backend, plan, provider, named-suite, and manifest metadata.
- module owner analysis.
- path/equality owner matching.
- Ruby doc-comment discovered surfaces.
- delegated child operations for YARD examples.
- nested merge and reviewed nested merge for YARD examples.
- module merge.
- Gemfile signature merge behavior.
- gemspec signature, field, dependency, file, version loader, and
  self-dependency policies.
- appraisals self-dependency and minimum Ruby prune policies.
- structured-edit provider projections through Prism.

## Missing Fixture Obligations

The following old values are not current generated README claims yet:

- begin/rescue clause merge semantics, including clause ordering, broad versus
  specific rescue ordering, rescue binding preservation, rescue/ensure recursive
  merge, and comment preservation inside clauses;
- magic comment preservation and magic-comment-only leading-region handling;
- `:nocov:` wrappers in rescue clauses, blocks, trailing statement ownership,
  malformed or unbalanced marker rejection, and interaction with freeze blocks;
- AST-directed gemspec variable rename from legacy `gem` receiver to `spec`
  receiver;
- top-level runner behavior as a generic Ruby merge entrypoint versus a
  recipe/tooling entrypoint;
- recursive body merge for class/module/call blocks, recursion depth limits,
  nested freeze blocks, and trailing blank lines;
- scaffold chunk removal from bundle-gem generated Rakefiles;
- method fuzzy matching and moved-node detection beyond current path/equality
  owner matching;
- freeze block behavior for Ruby source.

## Decision

Keep generated Ruby README examples limited to fixture-backed Ruby family and
Prism provider behavior. Port old Prism semantics through future portable Ruby
fixture slices before implementation or generated README claims.

Gemspec variable rename, top-level runner behavior, and scaffold chunk removal
are likely Kettle/Jem recipe behavior unless future fixtures define them as
portable Ruby family behavior.
