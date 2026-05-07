## Coupled-pair fixture

Two-file fixture for the coupled-carryover lift + anti-anchoring step.

- `20260601-schema-lock.md` — prior session for `TOPIC="schema lock for
  the SKILL frontmatter"`. Provides the CRYSTALLIZE block that the lift
  parser must read.
- `topic-2.md` — the topic to run for session N+1. Slug stem
  `schema-lock` overlaps the prior session by design.

### Expected behaviour on a real run

1. INTAKE step 4 globs `*-schema-lock*.md` against the configured output
   dir, finds `20260601-schema-lock.md`, parses
   `## Outcome → Selected Ideas / Decisions`.
2. `Carried hard constraints` block is announced verbatim, each line
   citing `source: examples/coupled-pair/20260601-schema-lock.md:<line>`.
3. The anti-anchoring step (Reverse Brainstorm) fires once on the
   lifted constraint set, before Phase 2 STEP.
4. META on the new session shows convergence at a step **not** matched
   by the prior session's `Convergence point:` line.

### Negative test

Running `/brainstorm TOPIC="--retrospective"` against the same dir
must **not** lift; retrospective mode skips the carryover gate.
