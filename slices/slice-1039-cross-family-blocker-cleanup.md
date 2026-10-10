# Slice 1039: Cross-Family Blocker Cleanup

## Status and scope

Design for a `kettle-family` command that removes unreleased locally-installed
gems blocking a command, including gems from **other** families. This is the
capability gap that prevented completing the manual `gem push` releases of
kettle-dev 3.1.9 and kettle-family 1.3.7 by normal means.

Status: **design complete, implementation not started.** The originally proposed
mechanism was disproved by experiment and is replaced below, with the evidence.

## Problem

`clean-unreleased` is scoped to family siblings. It derives candidates from
`ReleaseStateCheck` per member, so it can only ever remove a member of its own
family whose installed version exceeds the latest released version.

The real blockers are cross-family. Measured live against the current workspace:

```
kettle-dev family
  kettle-changelog   2 pins   nomono 1.1.7, token-resolver 2.0.13
  kettle-dev        28 pins   ast-crispr 7.1.10, ast-crispr-markdown-markly
                              7.1.10, ast-crispr-ruby-prism 7.1.10, ...
  kettle-drift      22 pins   ast-crispr 7.1.10, ...
  kettle-family     28 pins   ast-crispr 7.1.10, ...

structuredmerge family
  kettle-jem         3 pins   kettle-test 2.0.24, nomono 1.1.7,
                              token-resolver 2.0.13
  smorg-rb           3 pins   kettle-test 2.0.24, nomono 1.1.7,
                              token-resolver 2.0.13
```

kettle-dev's release is blocked by **structuredmerge** gems (`ast-crispr`,
`ast-merge`, `tree_haver` at 7.1.10). structuredmerge's members are blocked by
**kettle-dev** gems (`kettle-test` 2.0.24, `nomono` 1.1.7, `token-resolver`
2.0.13). Neither family's `clean-unreleased` can see the other's offenders, and
each one's offenders are the other family's legitimately-installed development
versions.

This is why the release of kettle-dev 3.1.9 / kettle-family 1.3.7 had to be
completed manually: the tag, checksums and GitHub Release steps all run through a
release-mode dependency update, which cannot resolve while cross-family
unreleased pins are present.

## Disproved approach: parse a dry-run release report

The original design was to run the blocking command with `--json`, extract the
blockers from the report, and uninstall that set. **This does not work**, because
a dry-run release never surfaces them.

Verified by running `kettle-family release --only ast-merge --json` in
structuredmerge (read-only; confirmed no mutation, lockfile kept its 32 PATH
remotes). Every phase came back skipped:

```
phase=family_changelog              skipped=true  dry-run; pass --execute to run
phase=release_normalize_lockfiles   skipped=true  dry-run; pass --execute to run
phase=commit_normalized_lockfiles   skipped=true  dry-run; pass --execute to run
phase=release_build                 skipped=true  dry-run; release readiness
                                                  requires lockfile normalization
phase=aggregate_github_release      skipped=true  dry-run; pass --execute to run
```

`published_version_check` does not appear at all, and `diagnostics` is 0 on every
result.

Root cause is two-step:

1. `workflow.rb:2522-2526` — in dry-run, when lockfile normalization applies and
   readiness would fail, the member's result is replaced by
   `release_skipped_after_lockfile_normalization_result` and the method returns
   before `append_release_internal_checks` (line 2529) ever runs. That synthetic
   result is `skipped: true, success: true, stdout: ""` (lines 3349-3362).
2. `workflow.rb:5785-5794` — `release_lockfile_readiness_would_fail?`, which
   decides that substitution, **already calls `PublishedVersionCheck`** and then
   discards its diagnostics, returning only a boolean.

So the real findings are computed and thrown away, and the report carries a
generic "release readiness requires lockfile normalization" instead.

Running with `--execute` to get the findings is not acceptable: it would run the
actual release.

## Chosen approach: call the checks directly

`PublishedVersionCheck.call(member:)` is pure read-only — it reads the member's
`Gemfile.lock` and queries the registry. Verified directly on a member: no
mutation, lockfile mtime and PATH-remote count unchanged.

This also removes the need for a subprocess, JSON round-trip, and command
selection entirely.

Note that a member's lockfile must have **GEM-section** pins for anything to be
found. `ast-merge` returned 0 diagnostics because its lockfile is in local-gem
mode (32 PATH remotes), so `registry_gem_specs_from_source` yields nothing. That
is correct behaviour, not a bug — but it means the command must scan members
whose lockfiles are registry-resolved, and must not report "no blockers" as
success when it merely looked at PATH-mode lockfiles.

## Design

New command `clean-blockers`, distinct from `clean-unreleased` rather than a flag
on it (consistent with the existing decision against flag options for this).

```
kettle-family clean-blockers [--only MEMBER] [--command release] [--execute]
```

Steps:

1. For each selected member, call `PublishedVersionCheck.call(member: member)`
   directly.
2. Collect `diagnostics` entries of `kind == "unpublished_lockfile_pin"`, union
   across members, deduplicated by `[gem, version]`.
3. Uninstall that exact set with the batched machinery already in
   `UnreleasedGemCleanup`.

Step 3 must reuse, not reimplement. `UnreleasedGemCleanup` already solves the two
hard parts, both documented in its class comment:

- **Batched single `gem uninstall`.** Per-gem invocation raises
  `Gem::DependencyRemovalException` whenever another installed gem still depends
  on the one being removed, because RubyGems' `uninstall_specific` needs the whole
  set to topologically sort (`strongly_connected_components.flatten.reverse`).
  Observed live: removing `tree_haver` first failed because `ast-merge` still
  required it, and four iterative passes still left two gems installed; one
  batched invocation removed both. Family members are heavily interdependent, so
  this is the normal case, not an edge case.
- **Post-uninstall verification.** `gem uninstall` exits 0 and prints "Gem is not
  installed" when it removes nothing, so exit status alone cannot distinguish a
  completed cleanup from one that found the wrong gem home. Candidates are
  re-enumerated afterwards and any survivor converts the outcome to a failure
  naming it.

`UnreleasedGemCleanup` needs a new entry point that accepts an externally supplied
`[name, version]` set instead of deriving candidates from family members. Its
`installed_versions` scanning (filesystem-based, because every RubyGems
enumeration API is bundle-scoped under `bundle exec` and hides unreleased
versions the lockfile does not pin) is directly reusable.

### Safety constraints

- Cross-family removal deletes gems another family is actively developing against.
  The command must name every gem and version it will remove before doing so, and
  must not act without `--execute`.
- A blocker that is not installed in a gem home (a PATH/git source checkout) must
  be reported but not treated as removable. `UnreleasedGemCleanup` already
  excludes non-gem-home specs by construction; that behaviour must be preserved.
- Failure to remove one gem must not be reported as success. The existing
  verified-outcome behaviour covers this.
- Report which members contributed which blockers, so a cross-family offender is
  attributable rather than mysterious.

### Follow-up required, not automatic

Uninstalling does not fix the lockfile — the check's own message says to "run a
release-mode dependency update to re-resolve". The command must say so, and must
not silently re-lock. Whether it should offer to run `bup` afterwards is an open
question; doing so unprompted would rewrite lockfiles the user did not ask to
touch.

## Prerequisite (already shipped)

`CommandResult#diagnostics` — the structured, unsummarized findings channel
(kettle-family `ae6a287`). Required because `stdout` is truncated to its last 20
lines by `summarize`, and the reported failure had 28 blockers, so a consumer
parsing `stdout` would have lost 8 gems: `ast-crispr`,
`ast-crispr-markdown-markly`, `ast-crispr-ruby-prism`, `ast-merge`, `bash-merge`,
`citrus-toml-merge`, `dotenv-merge`, `json-merge`.

The same truncation affects `readiness_check`, `changelog_check`, and
`branch_lane_audit`, which still populate `stdout` only. They can adopt
`diagnostics` when a consumer needs their complete set.

## Acceptance criteria

1. `clean-blockers` finds cross-family blockers that `clean-unreleased` cannot:
   given kettle-dev selected, it reports structuredmerge's `ast-crispr 7.1.10`
   and siblings.
2. Without `--execute` it lists every gem and version it would remove and changes
   nothing.
3. With `--execute` it removes the set in one batched `gem uninstall`, verifies
   removal by re-enumeration, and fails loudly on any survivor.
4. It reads members directly via `PublishedVersionCheck` rather than shelling out
   to a command and parsing JSON, so it works without `--execute` and without a
   release run.
5. Members whose lockfiles are PATH-mode contribute no findings, and the report
   distinguishes "no blockers" from "nothing was inspectable".
6. The report attributes each blocker to the members that pin it.
7. The output states that a release-mode dependency update is still required to
   re-resolve the lockfile, and does not perform it.
