# F-shape-variation — feature-torture report (v2)

## 👍 ship — with amendments

The v1 ✂️ landed correctly: ship mechanism 1 (anti-anchoring step) as
a discrete row, defer the recipe-swap to `F-shape-variant-recipes` (P2).
But v1 left the **firing point** unspecified, and that is the weakest
part of the slice. **Pin it explicitly: anti-anchoring fires once,
just after F-coupled-carryover lifts the constraint, before the recipe's
first step.** Also: the hidden `F-tech-inversion` dependency dissolves
on inspection — `Reverse Brainstorm` at `techniques.md:37-44` already
*is* inversion-as-generation. Amend, don't add.

## TL;DR

Mechanism-1-only ships cleanly with two amendments — **pin the firing
point** (just-after-lift, single fire) and **resolve the inversion dep
by amending `Reverse Brainstorm` rather than adding `Inversion`**.
Risk that bites: a single-shot Inversion may be too weak against the
user's "ideas remain the same" thesis, leaving us shipping a
half-measure that gets retired when `F-shape-variant-recipes` lands.

## Make me dream

A user runs a second `/brainstorm` on the same topic three days later.
The facilitator detects carryover via the `BFW_OUTPUT_DIR` glob, lifts
the prior CRYSTALLIZE bullets as Hard constraints, then announces:
*"You ran this last week and converged on X. Before we touch the same
recipe, let me invert: how would these constraints make the project
fail?"* Two minutes of inverted-angle ideas, then back to the
recipe — but with seeds the prior session never produced.

## Job to be done

- **User:** facilitator running a second-or-later coupled-session on
  the same topic.
- **Trigger:** `F-coupled-carryover` lifts prior verdicts as Hard
  constraints.
- **Outcome:** new ideation seeds that the prior session structurally
  could not have produced.
- **Constraint:** must add ≤ 3 min to session duration.

## Adjacency map

- **Scope-adjacent:** `SKILL.md` Phase 0 INTAKE / Phase 2 STEP — the
  carryover-detection + recipe-injection happens between intake and
  the first technique. One file.
- **Priority-adjacent:** `F-tech-inversion` (now reframed as a
  Reverse-Brainstorm amendment, not a new entry) — same PR ideal.
  `F-coupled-carryover` is the prerequisite, not a competitor.
- **Dependency-adjacent:** **Enabled by:** F-coupled-carryover (lift).
  **Enables:** F-shape-variant-recipes (P2 — uses the same hook).

## Roadmap-placement challenge

Cost of one cycle later: low — F-coupled-carryover ships first
regardless, and a coupled-carryover with no anti-anchoring is still a
net win. Cost of one cycle earlier: zero (no commits exist on either
row). **Ship in the same PR as F-coupled-carryover** if possible:
~10 LOC in `SKILL.md` plus ~3 LOC in `techniques.md` (Reverse
Brainstorm amendment). Splitting into two PRs costs review surface
without buying isolation, since the two rows share one code path.

## ADR core

### Problem

When a coupled session fires, the prior session's recipe locked the
user's enumeration order, converge mechanism, and stress angle. Same
shape, same exit. Lifting prior verdicts as Hard constraints (per
F-coupled-carryover-v3) narrows the next session further — without a
counter-pressure for divergence, the second session re-generates the
same ideas with higher confidence.

### Current state

- `SKILL.md:166-198` — REFLECT phase covers within-session
  adaptation only. No cross-session recipe modulation.
- `SKILL.md:200-208` — CRYSTALLIZE bullets are the lift source per
  F-coupled-carryover-v3.
- `techniques.md:37-44` — `Reverse Brainstorm` ("Flip the goal …
  list ways to fail, then invert each into a solution") is
  structurally Inversion-as-generation. The "F-tech-inversion" dep
  surfaced in v1 torture is misnamed.
- No counter exists for "Nth coupled session." Mechanism-2
  (recipe-swap) needs one; mechanism-1 does not.
- Brainstorm session 2026-05-07 (`brainstorm/2026-05-07-shape-staleness.md`)
  produced this row.

### Options

| # | Option | Pros | Cons |
| --- | --- | --- | --- |
| 1 | Ship mech-1 with pinned firing point (just-after-lift) + amend Reverse Brainstorm | Clean slice; same-PR with carryover | Single shot may be too thin against the "ideas-remain-same" thesis |
| 2 | Add a second injection mid-recipe (between converge and stress steps) | Stronger anti-anchoring | Doubles surface; harder to time-box; partly subsumes mechanism-2 |
| 3 | Park until F-shape-variant-recipes is ready, ship as one piece | Coherent | Wastes the cheap win; F-coupled-carryover loses a free booster |
| 4 | Drop the new row; rely solely on F-shape-variant-recipes (P2) | One-feature simplicity | Leaves coupled sessions exposed for indefinite time |

### Choice

**Option 1.** Ship the single, pinned anti-anchoring step. **Reasons:**
(a) the user's thesis remains *load-bearing* even in the half-measure
case — one fresh seed is strictly better than zero; (b) the dep
collapses on inspection (Reverse Brainstorm = Inversion, amend not
add); (c) mech-2 is rightfully P2 because its trigger (N≥2 chains)
hasn't been observed yet. **Refutations:** ✂️ (further reshape into
mech-1.5 with a mid-recipe second fire) — fails because mid-recipe
injection is what mech-2's recipe-swap *is*; we'd be re-merging the
v1 split. 🧬 (split firing-point pinning into its own row) — refused
as theatre; pinning is a one-line spec amendment, not a feature.

### Consequences

- ✅ Coupled sessions get a cheap divergence-booster from day 1.
- ⚠️ The "ideas remain the same" thesis is only *partially*
  addressed — accepted; full address comes with mech-2.
- 🔁 **Revisit when:** 2 N≥2 coupled chains have been observed →
  triggers F-shape-variant-recipes work; OR 3 sessions report users
  saying "the inversion didn't surface anything new" → mech-1 is
  too weak and needs mid-recipe re-fire.

## Output type — decision + spec

### Spec stub

- **Scope:** ~10 LOC in `SKILL.md` (new step between F-coupled-carryover
  lift and Phase 2 STEP); ~3 LOC amendment to `techniques.md:37`
  (alias `Inversion` to `Reverse Brainstorm`, or rename).
- **Inputs:** F-coupled-carryover has fired AND the lifted constraint
  set is non-empty.
- **Outputs:** the Reverse-Brainstorm two-column table on the lifted
  constraint, presented before any planned technique runs.
- **Edges:** retrospective-mode invocations skip the anti-anchoring
  step (composes with F-coupled-carryover-v3's same skip rule —
  co-locate the rule).
- **Test shape:** dogfood on `examples/coupled-pair/` fixture; expect
  META to show `anti-anchoring: yes` and convergence point at a
  technique step *not* matched in the prior session's META.

## Spawned children

- None. The `F-tech-inversion` row in P1 should be either renamed to
  **F-tech-inversion-amend** with scope "alias/rename Reverse Brainstorm
  to surface the Inversion vocabulary" — or absorbed into this row as
  the `techniques.md:37` amendment in the same PR.

## Open questions

- Should the anti-anchoring step's output be logged in META as a
  dedicated `anti-anchoring:` field, or folded into "Adaptations
  made"? `#data`
- What if F-coupled-carryover lifts an *empty* constraint set
  (prior session ended in 🤷 or all Could)? Skip anti-anchoring or
  invert the *topic* instead of constraints? `#scope`
- Does pinning the firing point to "just-after-lift" make
  `F-shape-variant-recipes` (P2) place its mid-recipe injection at
  a different point, or do they collide? `#deps`

## Techniques used

- **ADR** — closing spine.
- **Adjacency map** — surfaced that F-tech-inversion ≈ Reverse
  Brainstorm; load-bearing collapse.
- **Inversion (meta)** — applied to the proposal itself: "what
  would make mech-1 fail?" → produced the firing-point amendment.

Rejected: SCAMPER (no near-neighbour shape), Decision Matrix (4
options × 1 dimension, overkill), Pre-mortem (the feature *is* a
pre-mortem mechanism — recursion theatre).

---

promote-worthy: yes
output-type: decision+spec
