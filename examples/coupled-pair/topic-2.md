# Coupled-session topic for run N+1

Run this against an output dir containing `20260601-schema-lock.md`:

```bash
/brainstorm TOPIC="schema lock — extending to a manifest field" \
            IDEAS="cadence, owner, channel"
```

Expected: INTAKE step 4 matches the prior file via the `*-schema-lock*`
glob (date prefix stripped, slug stem `schema-lock` overlaps), lifts
the three Selected Ideas as `Carried hard constraints`, then the
anti-anchoring step runs Reverse Brainstorm on the lifted set before
Phase 2 STEP begins.
