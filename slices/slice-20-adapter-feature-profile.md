# Slice 20: Adapter Feature Profile

## Goal

Define a normalized adapter-facing feature profile.

## Planned Scope

- a minimal feature profile shape for adapter capability reporting
- include backend identity, dialect support, and supported policies
- keep the profile descriptive rather than executable

## Shared Behavior

This slice defines a narrow reporting contract:

1. an adapter feature profile is a normalized descriptive view of adapter
   capability
2. the profile includes backend identity
3. the profile includes whether dialects are supported
4. the profile includes supported policy references when they are exposed
5. the profile does not represent active result policies

## Shared Types

- `FeatureProfile`

## Notes

- This slice is adapter-oriented rather than ruleset-oriented.
- It is intentionally smaller than the full draft concept of a feature profile,
  but it is compatible with it.
