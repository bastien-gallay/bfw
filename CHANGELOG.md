# Changelog

## 0.1.0 — 2026-04-11

Initial public release, extracted from the project where the skill was
developed and refined through real sessions.

### Features

- **Adaptive session flow:** `INTAKE → SHAPE → PLAN → [STEP → LOG →
  REFLECT]* → CRYSTALLIZE → META`
- **Problem shape detection** with 5 default recipes (Blank slate,
  Few ideas, Many ideas, Binary choice, Decision under constraints),
  plus a Large backlog recipe (15+ items) for cluster-level analysis.
- **Technique library** with 20 techniques across 5 phases
  (diverge / analyze / converge / crystallize / adaptive).
- **Announce + adapt without permission** — the facilitator changes
  course transparently based on convergence, stuck, or new-dimension
  signals.
- **Session output template** with timestamps, per-step logs, user
  feedback quotes, facilitator notes, final outcome, and meta-analysis.
- **Retrospective mode** (`TOPIC="--retrospective"`) to aggregate
  past sessions and propose improvements to default recipes.
- **Claude Code installer** with user-level and per-project modes.

### Known limitations

- Output path conventions assume a git-tracked project with a
  writable working directory.
- Memory integration is Claude Code specific (uses the user-memory
  subsystem); other hosts need to adapt the "save a feedback memory"
  phase.
