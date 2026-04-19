# Slice 59: Missing Suite Roles

## Goal

Treat suite definitions that reference undeclared family roles as configuration
errors.

## Scope

- forbid partial suite planning when required roles are absent
- preserve other valid suite planning where possible
- surface the error explicitly instead of burying it in plan details

## Contract

This slice defines one small missing-role contract:

1. if a suite definition references one or more undeclared family roles, that
   suite is invalid
2. invalid suites emit one configuration-error diagnostic
3. invalid suites are omitted from aggregate planned/reportable entries

## Shared Fixture

- `missing-suite-roles.json`
