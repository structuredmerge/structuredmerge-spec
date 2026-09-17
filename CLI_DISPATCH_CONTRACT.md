# Kernel CLI external dispatch

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
