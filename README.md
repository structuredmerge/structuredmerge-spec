# Merge Spec Workspace

This directory is the working area for language-neutral merge specifications and
cross-language conformance planning.

Current intent:

- Treat `MERGE_RULESET_INFORMATIONAL_DRAFT_01.md` at the workspace root as the
  only active merge draft.
- Use this directory for stable, implementation-facing summaries that help keep
  Ruby, TypeScript, Rust, and Go implementations aligned.
- Keep conformance fixtures language-neutral so each implementation can run the
  same corpus.

Initial files:

- `merge-lexicon.md` - portable terminology snapshot derived from the active draft
- `conformance-matrix.md` - MVP capability matrix across language stacks

Non-goals for this directory:

- Replacing the active draft
- Language-specific package planning
- Templating/package-scaffold implementation details

