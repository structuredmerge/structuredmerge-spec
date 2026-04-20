# Slice 156: Canonical Stable-Suite Report

## Goal

Report the stable config-family suites directly from the canonical manifest.

## Shared Behavior

This slice defines one canonical stable-suite reporting contract:

1. the canonical manifest MAY report the stable config-family suites without
   involving source-family suites,
2. the observable result remains the ordinary manifest report envelope plus any
   diagnostics,
3. canonical suite widening does not require canonical source-suite promotion.
