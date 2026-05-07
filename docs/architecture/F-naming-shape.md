# F-naming-shape — feature-torture report (v2 re-torture)

## 👍 ship

Add a **Naming** shape to the SHAPE table with the lean recipe
`Free Association (extended) → Affinity Grouping → PCI on top 3 →
Action Items`. The reshape from v1 split off the web-collision probe
into `F-collision-probe` (P2, gated on runtime web capability) and
left this row using only techniques that already exist in
`techniques.md`. The recipe is now self-contained, the routing fix
(away from SCAMPER on word-lists) is the load-bearing value, and the
external collision check is honestly named as a manual user step.
Ship it.

## TL;DR

The reshape worked: the recipe resolves entirely against existing
techniques, and the collision probe is correctly parked in P2.
Risk: users expect the facilitator to do the googling — mitigate
with one explicit recipe line.

## Make me dream

A user runs `/brainstorm TOPIC="name for a new doctor skill"
IDEAS="probe, vital, pulse, healthcheck"`. The facilitator detects
**Naming**, plans 15 min, extends to ~12 candidates, clusters by
metaphor family, runs PCI on the top 3, and ships a ranked shortlist
with a final line: "before commit, google these three for prior
art." User feels facilitated, not deceived.

## Job to be done

- **User:** developer choosing a name for a skill, command, package,
  or public artefact.
- **Trigger:** about to commit a public identifier.
- **Outcome:** a chosen name + a shortlist with documented
  trade-offs + a flagged manual verification step.
- **Constraint:** ≤15 min; no runtime web access required.

## Adjacency map

- **Scope-adjacent:** `skills/brainstorm/SKILL.md:72-89` (SHAPE
  table) and `SKILL.md:82` (`naming 15` placeholder, same line as
  schema).
- **Priority-adjacent:** `F-schema-shape` (P1) — same SHAPE-table
  edit; coordinate the PR to avoid merge churn.
- **Dependency-adjacent:** `F-collision-probe` (P2) is the *enabled*
  follow-up, not a blocker. None upstream.

## Roadmap-placement challenge

Cost one cycle later: negligible (n=1 retro signal; current failure
is noise, not data loss). Cost one cycle earlier: **~10 LOC in one
file**. Quantitative comparison: ~1/3 the LOC of `F-schema-shape`
(2 techniques + 1 row) and zero new dependencies. **Land alongside
schema** — same file, same review surface.

## ADR core

### Problem

Naming sessions route to **Few ideas** and run SCAMPER → I/E.
SCAMPER on words produces noise; the real moves are extended
generation, family clustering, and pros/cons on top contenders. v1
smuggled a non-existent web-collision step; the reshape moved that
to a separate F-row and replaced it with a manual user note.

### Current state

- `SKILL.md:72-89` — five SHAPE rows; no naming row.
- `SKILL.md:82` — `naming 15` named as a future override.
- `SKILL.md:43-52` — Grounding First fires on `naming` trigger word
  (already lands the grep-existing-names half).
- `techniques.md:67` Free Association, `:255` Affinity, `:135` PCI,
  `:230` Action Items — all present.
- `F-collision-probe` filed in P2, gated on runtime web capability.

### Options

| # | Option | Pros | Cons |
| --- | --- | --- | --- |
| 1 | Ship lean recipe + manual-verify note | Self-contained; uses only existing techniques; honest about the gap | Loses inline collision-check signal until P2 lands |
| 2 | Hold until F-collision-probe ships | Single coherent recipe at v1 | Couples to web-capability decision; delays the routing fix |
| 3 | Drop the shape | n=1 honesty | Loses the SCAMPER-on-words fix, which is the real value |

### Choice

**Option 1.** The shape's load-bearing value is the *routing fix*
(away from SCAMPER), not the collision check. Shipping with the lean
recipe captures that value now and lets the collision probe land
when web capability is settled.

Cross-label challenge:

- **✂️ again** — refuted: v1 already extracted the only separable
  concern (collision probe). Re-shaping is infinite regress.
- **🧬** — refuted: Free Association and Affinity exist already;
  splitting would manufacture children with no scope.

If a third round produced ✂️, the original reshape was
insufficient. It is not — the recipe references resolve.

### Consequences

- ✅ Naming sessions get a fit-for-purpose recipe; SHAPE table
  closes the `naming 15` placeholder.
- ⚠️ Manual verification is on the user until `F-collision-probe`
  lands — recipe paragraph must say so explicitly.
- 🔁 Revisit when `F-collision-probe` ships, or after 3 naming
  sessions surface a recipe gap in META.

## Output type — decision + spec

### Spec stub

- **Scope:** one new SHAPE row in `skills/brainstorm/SKILL.md`,
  ~10 LOC. No `techniques.md` edits.
- **Inputs:** trigger = topic mentions `name`, `naming`, `rename`,
  `identifier`, `slug` *and* IDEAS lists candidates (or is empty —
  blank-slate naming routes here too, ahead of the Blank-slate row).
- **Outputs:** SHAPE row with Trigger / Duration 15 / Recipe
  `Free Association (extended) → Affinity Grouping → PCI on top 3 →
  Action Items`. Recipe paragraph names manual external verification
  as a user-side step until `F-collision-probe` lands.
- **Edges:** *renaming* (existing name + reasons to change) routes
  to "Decision under constraints" with the current name as a hard
  constraint — not this shape. Document in the recipe note.
- **Test shape:** dogfood on the next public skill name; expect META
  to record convergence at PCI step 3.

## Spawned children

None. `F-collision-probe` already exists in P2.

## Open questions

- Should the recipe enforce a minimum candidate count (e.g. ≥8
  before convergence) given naming benefits from breadth? `#ux`
- For renaming sessions, is the prior name a hard constraint by
  default, or user-confirmed each time? `#scope`

## Techniques used

- **ADR** (closing spine).
- **Devil's Advocate** (cross-label challenge: forced ✂️ and 🧬
  refutations against the converged 👍).
- **Cost-of-delay** (quantitative comparison vs `F-schema-shape`).

Rejected: SCAMPER (recursion theatre — the report argues against it
on word-lists); Adjacency map run as a deep technique (one paragraph
sufficed; v1 already did the heavy lift); Pre-mortem (no real
runtime risk left after the reshape — the placeholder step was the
risk and it is gone).

---

promote-worthy: yes
output-type: decision+spec
