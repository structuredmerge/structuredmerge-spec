# Slice 188: Canonical Widened-Suite Polyglot Backend Report

## Goal

Prove that canonical widened-suite reporting remains stable when the `yaml`
family is executed through the polyglot backend.

## Contract

1. the widened-suite manifest report preserves the same ordered entries
2. the `yaml` family report context advertises `backend:
   "kreuzberg-language-pack"`
3. the `yaml` family report context advertises `supports_dialects: false`
4. expected case outcomes remain unchanged from the widened-suite backend report
   baseline
