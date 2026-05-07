# Brainstorm: schema lock for the SKILL frontmatter

| Field | Value |
| --- | --- |
| **Date** | 2026-06-01 |
| **Duration** | 27 min |
| **Participants** | User + AI Facilitator |
| **Problem shape** | Schema / lock-in |

## Session Plan

| # | Phase | Technique | Duration | Status |
| --- | --- | --- | --- | --- |
| 1 | Diverge | Atom Inventory | 4 | Done |
| 2 | Converge | Constraint Mapping | 6 | Done |
| 3 | Converge | Impact / Effort | 8 | Done |
| 4 | Stress | Pre-mortem (`day-1-blocker`) | 6 | Done |
| 5 | Crystallize | Action Items | 3 | Done |

## Ideas — Starting Point

`name`, `description`, `type`, `tags`, `version`.

## Step 1: Atom Inventory

| Atom | Type | Constraints |
| --- | --- | --- |
| `name` | string | snake-case, ≤60 chars |
| `description` | string | ≤200 chars (host enforced) |
| `type` | enum | `skill` only for now |
| `tags` | list[string] | ≤8, lowercase |
| `version` | semver | required |

## Step 4: Pre-mortem — `day-1-blocker`

Top failure causes:

1. `description` exceeds 200 chars on upload — **day-1-blocker**.
2. Missing `name` on first install — **day-1-blocker**.
3. `version` non-semver tripping the auto-update path — **silent-drift**.

---

## Outcome

### Selected Ideas / Decisions

1. **Lock the four MUST fields: `name`, `description`, `type`,
   `version`.** Rationale: every host parses these on first install.
2. **`description` is hard-capped at 200 chars.** Rationale: web
   uploader rejects longer values; cap is non-negotiable.
3. **`tags` stays SHOULD, not MUST.** Rationale: not every host reads
   them; useful but not load-bearing.

### Action Items

- [ ] Encode the schema in `.claude-plugin/plugin.json` — bastien — 06-03
- [ ] Add 200-char check to `just package` — bastien — 06-04

---

## Session Meta-Analysis

- **Duration:** 27 min
- **Techniques used:** Atom Inventory (4) · Constraint Mapping (6) ·
  Impact/Effort (8) · Pre-mortem `day-1-blocker` (6) · Action Items (3)
- **Techniques skipped:** SCAMPER (anti-pattern on enumerable atoms).
- **Adaptations made:** none — recipe held.
- **Problem shape:** Schema / lock-in → confirmed.
- **Convergence point:** Step 3 (Impact/Effort) — *the technique
  parenthetical is mandatory; this line is the load-bearing retro
  signal and must stay greppable*
- **What worked well:** Atom Inventory caught the 200-char cap before
  Pre-mortem had to surface it as a failure mode.
- **What could improve:** Pre-mortem would have benefited from the
  prior `description` lint; ground-first half-fired only.
- **Session energy:** high.
- **Recommendation for similar sessions:** lead with Atom Inventory
  whenever IDEAS lists ≥3 enumerable atoms.
