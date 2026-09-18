# Shared CLI command and external-dispatch contract

## Scope and conformance status

`structuredmerge.cli/v1` is the shared command contract for `smorg` and the full
native-layer executables `smorg-rb`, `smorg-go`, `smorg-ts` and `smorg-py`.
Product-group extensions are not full CLIs. This document extends, rather than
replaces, Slices 1020 (Git roles), 1022/1023 (benchmark exchanges), 1025 (typed
operations), 1028 (diagnostics) and 1032 (artifact/provider availability).

The requirements below describe the target, not an assertion that existing
executables conform. In particular the current kernel lacks the version/report
and provider-aware introspection surface, and retains legacy default full-file
conflict rendering. These are migration gaps, not normative defaults. Existing
benchmark adapters and compatibility entry points remain until migrated.

### Command surface

| Invocation | Required behavior |
| --- | --- |
| `help`, `--help`, `-h` | Exit 0, human command summary on stdout; no parser loads or writes. |
| `--version` | Exit 0, executable/package version on stdout; no provider execution. |
| `--version --json` | One object with `schema: structuredmerge.cli-version/v1`, `executable`, `package`, `version`, `kernel_version`, `cli_contract: structuredmerge.cli/v1`. No source-tree version inference. |
| `merge-driver [OPTIONS] BASE OURS THEIRS [PATH]` | Map roles exactly to Slice 1020; execute one typed merge3, never merge2. Named `--ancestor BASE --current OURS --other THEIRS` is the alternate source form. |
| `diff-driver [OPTIONS] BEFORE AFTER` | Execute typed diff2 without modifying either input. Also accept Git's seven/nine-argument external-diff protocol as documented below. |
| `conflicts diff [--path-name PATH] [--exit-code] [--json] FILE` | Read-only conflict review; report conflict evidence, not a merge or provider-support claim. |
| `languages [--json]` | Human/machine view of artifact and runtime provider availability, including unavailable states; never a static source-tree language list. |
| `languages --inspect ID --kind parser\|workflow [--json]` | Inspect exactly that provider and retain the parser/workflow distinction. Unknown IDs fail explicitly. |
| `languages --preflight REQUEST.json [--json]` | Validate a Slice 1025 request using the same bounded selection path as execution. Retain Slice 1032 snapshot/staleness evidence; do not install assets. |
| `languages --gitattributes` | Print suggested Git attributes; never edit files or confer default authority. |
| `git install [--scope local\|global\|include-file] [--profile semantic-diff\|builtin-diff] [--check\|--undo\|--dry-run] [--json]` | Explicit Git configuration operation; local scope by default. Check/dry-run are read-only. Undo removes only configuration owned by this installation. |
| `benchmark-provider-session` | Existing Slice 1023 request/response JSONL stream; no banners or progress on stdout. |
| `benchmark-provider-diff BEFORE AFTER PATH` | Existing benchmark diff exchange; inputs remain unchanged. |
| `benchmark-provider-merge2 INCOMING CURRENT PATH` | Existing directional benchmark exchange; never reverse roles or synthesize a base. |
| `benchmark-provider-merge3 BASE OURS THEIRS PATH` | Existing benchmark merge3 exchange and conflict-evidence rule, not the Git driver's report transport. |

The benchmark exchanges retain their existing schema/version and output channels;
this contract does not wrap or silently reinterpret them. A native CLI must route
operations through the typed kernel, not copy the kernel's legacy per-format
dispatch or implement matching/rendering itself.

### Argument grammar and selectors

Validate the complete invocation before loading providers or opening output
destinations. Reject unknown options, missing/empty values, extra positionals,
duplicate singleton options, and mixed named/positional source forms with exit 2
and a nonempty stderr diagnostic. Named source form requires all three roles.
An optional positional logical PATH cannot be combined with `--path-name`.
`--` ends options; subsequent values are positional paths, not option names.
Per-command `--help` is read-only and exits 0. An empty invocation exits 2.

Shared merge/diff selectors are `--provider ID`, `--family FAMILY`, `--dialect
DIALECT`, `--backend ID`, `--profile ID`, repeatable `--require-capability NAME`,
and `--require-profile-status available|recommended|default`. They map to the
existing typed request/selection fields; they do not create another registry or
selection algorithm. Explicit constraints are conjunctive and fail closed.
Missing selectors are resolved by the kernel's declared policy and project
configuration, not a CLI-owned filename-to-parser map. No available compatible
selection means failure, never implicit text fallback.

Merge options also include `--path-name`, `--output`, `--report`, `--strict`,
`--check-only`, `--exit-code`, `--fallback`, and `--conflict-policy leave-ours|write`.
`--exit-code` requires check-only for merge-driver. Output defaults to OURS.
Fallback defaults to `none`; strict requires none. Legacy explicit fallback
names `line`, `local`, `full-file` are accepted only when the selected kernel
profile supports and records that policy. The CLI never fabricates a conflict
document or invokes a fallback algorithm itself. Conflict policy defaults to
leave-ours; write requires a validated provider `conflicted_output`.

Diff options include the shared selectors, `--path-name`, `--report`, `--json`
and `--exit-code`. Git's positional form is
`PATH OLD-FILE OLD-HEX OLD-MODE NEW-FILE NEW-HEX NEW-MODE [OLD-PREFIX NEW-PREFIX]`.
Only OLD-FILE and NEW-FILE are source files. PATH and prefixes are display
metadata, never files to read. Unsupported encodings and binary inputs must be
reported by the selected contract, never lossy-decoded.

### Results, writes and process exits

Machine reports are UTF-8 JSON, terminated by a newline, with no human preamble.
`--json` selects stdout; `--report FILE` selects a separate report file. Merge
output never goes to stdout implicitly. Diagnostics/progress go to stderr.
The version and benchmark forms above have their own schemas; other reports
use `schema: structuredmerge.cli-report/v1` with:

- `command`: `merge-driver`, `diff-driver`, `conflicts.diff`, `languages`,
  `languages.inspect`, `languages.preflight`, or `git.install`;
- `cli`: executable, package, version, kernel_version and cli_contract identities;
- `outcome`: `clean`, `changed`, `conflict`, `unsupported`, or `error`;
- `exit_code`: the computed operation outcome, not attestation of a later write;
- `operation_result`: the unmodified Slice 1025 result for merge/diff, else null;
- `availability`: the Slice 1032 artifact/runtime/preflight evidence for language
  commands, else null; a descriptor-only list is not availability evidence;
- `conflict_review`: for conflict review, source byte length/SHA-256 and ordered
  half-open byte regions with base/ours/theirs roles where known, else null;
- `git_install`: scope, profile and ordered install steps with action, target,
  status and diagnostics, for Git configuration commands, else null;
- `diagnostics`: Slice 1028 diagnostics for adapter/pre-execution failures;
- `output_commit_verified`: false for a report staged before an output commit.

Preserve typed provider identity, diagnostics, conflicts, verification,
preservation and fallbacks inside operation_result. Do not promote a parser's
identity into a merge-provider identity. Errors before kernel execution have a
null operation_result; never invent a successful envelope. Reserved fields cannot
be shadowed by extensions. Unknown compatible fields are forwarded, not discarded.

Exit 0 means successful completion (and a clean merge write unless check-only).
Exit 1 means validated unresolved conflict, or a requested read-only change check
(`diff --exit-code`, merge check-only/exit-code, conflict review/exit-code).
The report distinguishes these outcomes; exit 1 alone is never conflict evidence.
Exit 2 covers invalid invocation, unavailable/unsupported selection, malformed
input/result, provider/configuration errors and pre-execution file errors.
Exit 3 covers internal process/serialization errors and staged-write/commit
failures. Signal termination remains signal termination. Git-adapter error
categories from Slice 1020 remain in diagnostics; these CLI process distinctions
do not rewrite its provider envelope.

Check-only, diff, conflict review, introspection and preflight do not mutate input
bytes. All merge inputs stay unchanged on rejected arguments/selection/validation.
Conflict writes follow explicit conflict policy. The destination separation and
staged-write rules below apply to report/output writes; report success is not
output-commit proof. Global configuration changes require explicit global scope.
No command silently downloads parsers/grammars, publishes packages, starts a
sidecar, or grants default-driver authority. Git installation does not grant it.

### Portable conformance

`structuredmerge-fixtures/conformance/cli-v1/manifest.json` begins the real-process
suite. Its runner records each command's exit, stdout/stderr, before/after source
digests, executable digest and case-manifest digest, including failed cases.
This initial subset covers discovery and argument rejection. Passing it is not
full CLI conformance: positive provider execution, exact bytes, structured
reports, real Git integration, conflict policies, alias/write faults, availability
and dispatch must also pass per artifact/runtime. Missing commands must fail the
gate, not be skipped or counted as unsupported semantic capability coverage.

## External dispatch

The canonical kernel executable is `smorg`. Language suffixes (`rb`, `go`, `ts`,
`py`, and future language IDs) designate full native-layer CLIs. Product suffixes
such as `cloud` designate product command groups. Dispatch does not confer parser
or merge authority on either class.

Built-in commands take precedence over executables on PATH: `merge-driver`,
`diff-driver`, `conflicts`, `languages`, `git`, `help`, help flags, and the explicit
`benchmark-provider-session`, `benchmark-provider-diff`,
`benchmark-provider-merge2`, `benchmark-provider-merge3` commands.

For any other command name, `smorg NAME ARGS...` executes `smorg-NAME` using PATH.
NAME must start with an ASCII lowercase letter and contain only lowercase ASCII
letters, digits and hyphens. Path separators, dots, whitespace, empty names and
option-like names are rejected. Dispatch uses an argument vector, never a shell;
remaining OS-native arguments (including non-UTF-8 Unix bytes), environment,
working directory and standard streams are preserved. No parser selection,
provider fallback or file access precedes external execution. PATH is trusted
operator configuration, not a sandbox or executable-authentication mechanism.
An unset PATH fails explicitly. Unix script targets need a valid shebang; an
executable text file without one must not trigger an implicit shell fallback.

On Unix, successful dispatch replaces the kernel process, preserving child exit
and signal behavior. On other targets, the kernel waits and returns the child's
numeric exit code (or internal-error code 3 if none exists). Invalid names and
failure to start the requested executable report a diagnostic and exit 2; no
similarly named or built-in substitute is attempted. Built-in arguments currently
require UTF-8 and reject invalid encoding explicitly.

The compatibility executable `smorg-rs` retains the historical unlabelled
`BASE OURS THEIRS PATH` benchmark invocation: an unrecognized command with at
least four arguments uses that legacy router before external dispatch. This
ambiguous form is **not** accepted by canonical `smorg`; use its explicit
`benchmark-provider-merge3 BASE OURS THEIRS PATH` command instead. Existing
benchmark consumers may continue to invoke `smorg-rs`. Built-ins retain precedence
on both executables. This is a documented compatibility exception, not a file-
existence heuristic that could turn a missing external command into a merge.

Conformance must test real processes: built-in precedence, literal and binary
argument forwarding, inherited streams/environment/cwd, numeric exit status,
Unix signal termination, missing/non-executable targets, invalid names and the
legacy-versus-canonical routing distinction. OS-specific tests prove only the
targets on which they execute; publication and default-driver approval are separate.

## Merge-driver argument safety

Both executable names reject a missing or empty value for `--ancestor`,
`--current`, `--other`, `--path-name`, `--output`, `--report`, `--profile`,
`--require-profile-status`, and `--fallback`. A following long option is not a
value. These errors produce a diagnostic on stderr, exit 2, and no merge output
write; they must not silently reuse positional sources or default to overwriting
the current file. A filename beginning with `--` must be expressed as a relative
path such as `./--name` or an absolute path when used as an option value.

Required promotion status accepts only `available`, `recommended`, or `default`,
whether supplied by `--require-profile-status` or the
`smorg.requireProfileStatus` attribute. Unknown values fail with exit 2 before
merge writes; they must not lower a required status to `available`. Recognizing
a status does not establish promotion authority: existing profile evidence and
enforcement still determine whether execution is permitted.

## Report destination separation

Before merge-driver writes, its report destination must be distinct from every
input and the selected output (current by default), including in check-only mode.
Existing filesystem identity, not just path spelling, determines collisions:
symlink and hard-link aliases are rejected. For a new destination, resolve its
existing parent directory and compare the final filename. An unresolvable or
inaccessible identity fails closed rather than assuming the paths are distinct.
Rejection emits stderr and exits 2 without modifying sources or the merge output.

This preflight assumes a stable filesystem. It does not provide locking against
concurrent path replacement; successful collision tests do not establish that.

## Staged merge-driver writes

Both executable names stage output and report bytes in temporary files in each
destination's directory, finish writing and syncing those files, then replace
the report followed by the output. Check-only mode never stages output.
Staging failures leave existing destinations unchanged and exit 3. A report
commit failure leaves the output unchanged. Normal error handling removes
uncommitted temporary files, including after an injected partial staging write.

Replacement is atomic per file, not a transaction across report and output.
If the output commit fails after the report commit, the report may already
describe the computed merge result. Its `ok` and `exit_code` describe that result,
not proof of an output write; `output_commit_verified` is always false. The actual
process exits 3 on an I/O failure. Consumers must inspect the process exit status.

Existing regular-file destinations keep their permission bits; existing symlinks
are followed to their canonical target. Directories, dangling symlinks, and
read-only destinations fail closed. Newly created destinations use private
temporary-file permissions. Replacement changes the inode: other hard links
retain their old content, and preservation of ownership, ACLs, extended attributes,
or other inode metadata is not guaranteed. Parent-directory write permission is
required. There is no concurrent-writer locking, multi-file rollback, or
power-loss durability guarantee (parent directories are not synced).
