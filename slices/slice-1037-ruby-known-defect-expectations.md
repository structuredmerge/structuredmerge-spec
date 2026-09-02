# Slice 1037: Ruby Known-Defect Expectations

## Status and scope

This slice defines how a confirmed defect in the Ruby golden master is retained
as migration evidence without becoming desired portable behavior. The initial
registry contains the v7.1.7 `ast-template` README/API discrepancy identified
in Slice 1034.

Architecture questions, unsupported parser capabilities, optional dependency
absence, and provider coverage gaps are not defects merely because they need
work. They remain in their corresponding review queues until a reproducible
behavioral failure establishes a defect.

## Defect record

Every known-defect expectation contains:

- stable defect ID and `pending` status;
- observed Ruby source revision and package version;
- affected public surface and operation;
- reproducible observation and expected behavior;
- reason the observation is not golden-master authority;
- accepted resolution classes;
- fixture or test evidence;
- diagnostic category, metadata, and extensions.

A pending defect is an expected failure, not unsupported coverage. A conforming
runner reports it separately from passing behavior and quality denominators. If
the expected behavior starts passing, the pending expectation fails as
unexpectedly fixed until the defect record is resolved or promoted with new
evidence.

## Initial defect

The v7.1.7 `ast-template` README invokes:

- `Ast::Template.package_directory_session_request`; and
- `Ast::Template.run_package_directory_session`.

Neither method exists at the pinned revision. The callable session entry points
are those recorded in Slice 1034. This mismatch is pending and excluded from
portable authority.

Two resolution classes are acceptable:

1. correct the README to use the intended released session API; or
2. deliberately add, document, test, and version the advertised aliases.

The migration must not invent either method merely to match the defective
documentation.

## Admission and resolution

A new defect enters this registry only with a deterministic reproduction and a
reviewed distinction from intentional unsupported behavior. Resolving a defect
requires evidence at a new Ruby revision, removal of the pending expectation,
and an explicit decision about whether the corrected behavior belongs in the
portable contract.

Known defects never become desired behavior through snapshot capture alone.
