# F-decision-recipe-rewrite

## 👍 ship

Rewrite the **Decision under constraints** recipe in
`skills/brainstorm/SKILL.md:68` from `Constraint Mapping → Reverse
Brainstorm → Decision Matrix` to `Constraint Map → I/E → MoSCoW →
Actions`. All four target techniques already exist in
`techniques.md`. Diff is one row + one rationale paragraph. Multi-
source corpus (cisac 8/9 skip rate on Decision Matrix, daily-ops
×2 retro-flagged) makes the "drop DM" half non-controversial; the
"add I/E + MoSCoW" half closes the convergence gap the drop
creates.

## TL;DR

Ship as scoped. **The load-bearing call is dropping Decision Matrix
from the default** — its 89% cisac skip rate proves it isn't
earning its slot. The risk that bites: shipping this without
F-ie-vs-moscow lands the recipe before users have language for why
I/E and MoSCoW sit back-to-back.

## Make me dream

A solo dev opens `/brainstorm` with "I need to cut a release but
I'm boxed in by GPG signing, marketplace cache TTL, and a frozen
CHANGELOG". The skill announces: *"Decision-under-constraints
shape. Plan: Constraint Map (3m) → I/E (4m) → MoSCoW (3m) →
Actions (2m). ~12 min."* Twelve minutes later they have one
decision, three Must-do actions, two Should-defer, and a Won't.
No 8-minute weighted matrix nobody trusts. They commit and move
on.

## Job to be done

- **User:** solo dev / PM running a brainstorm under hard limits.
- **Trigger:** input mentions constraints (budget, time, deps, scope-lock).
- **Outcome:** defensible decision + concrete next steps in ≤15 min.
- **Constraint:** facilitator must not waste a slot on a technique
  the corpus shows users skip.

## Adjacency map

- **Scope-adjacent:** `skills/brainstorm/SKILL.md:68` — same row.
- **Priority-adjacent:** `F-six-hats-demote` (also edits the SHAPE
  table; ship in the same commit). `F-ie-vs-moscow` (defines the
  conceptual split this recipe relies on).
- **Dependency-adjacent:** `F-ie-vs-moscow` is a soft prerequisite
  — the recipe works without it, but users will ask "why both?".

## Roadmap-placement challenge

One cycle later: cisac-style 89% skip rate on Decision Matrix
keeps contaminating retros and the corpus drifts further from
documented behaviour. One cycle earlier: blocked — we needed the
~35-session cross-retro to confirm the pattern is not noise.
**Now is right.** Quantitative anchor: 1-line diff in `SKILL.md`,
0 new technique definitions, all four targets already at lines
261, 155, 142, 214 of `techniques.md`. Ship with `F-six-hats-demote`
as a single SHAPE-table commit.

## ADR core

**Problem.** The default recipe for decisions under constraints is
skipped at the converge step. Corpus shows users mentally swap
Decision Matrix for I/E or MoSCoW, then drift off-recipe entirely.
The intake step (Constraint Mapping) and divergence (Reverse
Brainstorm) work fine; the failure is at converge.

**Current state.**

- `SKILL.md:68` — recipe `Constraint Mapping → Reverse Brainstorm → Decision Matrix`.
- `techniques.md:175` — Decision Matrix entry, 5–8 min, weighted-criteria scoring.
- `techniques.md:155` — I/E Matrix already documented.
- `techniques.md:142` — MoSCoW already documented.
- Corpus: cisac 8/9 sessions skip DM; daily-ops ×2 retro-flagged.

**Options.**

| # | Option | Pros | Cons |
|---|---|---|---|
| 1 | **Ship as proposed** (drop DM, add I/E + MoSCoW + Actions) | Matches observed behaviour; zero new technique debt; uses I/E + MoSCoW back-to-back to clarify decision-vs-formalisation | Lands before `F-ie-vs-moscow` ships the pedagogy |
| 2 | Keep DM as opt-in; default to I/E + MoSCoW | Preserves DM for the rare high-stakes case | Two ways to do the same thing; opt-in techniques rarely get reached for |
| 3 | Drop Reverse Brainstorm too; recipe = Constraint Map → I/E → MoSCoW → Actions only | Even tighter | Loses the inversion ideation seed; not corpus-backed |
| 4 | Status quo | Zero churn | Documented behaviour ≠ actual behaviour; retros keep firing |

**Choice.** Option 1. Reasons: (a) drops the technique with the
hard skip-rate evidence; (b) replacement chain is already in
`techniques.md`; (c) I/E-then-MoSCoW models *decide → formalise*
which is what users do off-recipe anyway. Cross-label challenges:
**✂️** (drop DM only, keep Reverse Brainstorm + nothing-after) —
fails; leaves no converge step. **🧬** (split into "drop DM" +
"add I/E/MoSCoW" + "add Actions") — fails; one-row diff is atomic
and contrived to split.

**Consequences.**

- ✅ Recipe matches observed behaviour; retros stop flagging it.
- ✅ Reuses existing technique definitions; zero new debt.
- ⚠️ Decision Matrix stays in `techniques.md` as opt-in (cite via
  `TECHNIQUES=` arg). Cost accepted: one paragraph in SKILL.md
  noting "weighted scoring is opt-in for high-stakes decisions".
- 🔁 Revisit if I/E skip-rate climbs above 30% across two retros.

## Output type

**Decision + spec stub.**

- **Scope.** Single edit: `SKILL.md:68` row + a 2-line note above
  the SHAPE table on opt-in DM.
- **Inputs.** User input naming constraints (hard or soft).
- **Outputs.** Constraint table (Hard/Soft) → I/E quadrant grid
  → MoSCoW four-bucket → Action Items checklist.
- **Edges.** 0–2 ideas under constraints → fall back to Blank-slate
  recipe but inject Constraint Map at intake. 8+ items under
  constraints → use Many-ideas recipe + Constraint Map at intake.
- **Test shape.** Re-run a flagged daily-ops retro session against
  the new recipe; confirm Decision Matrix no longer appears in the
  announced plan and the META block reports zero adaptations on
  the converge step.

## Spawned children

None. The rewrite is atomic.

## Open questions

- Does "Actions" reuse the existing **Action Items** technique
  (`techniques.md:214`) or earn a new entry? `#scope`
- Ship before, after, or with `F-ie-vs-moscow`? `#deps`
- Per-shape duration override — does this shape want its own
  number under `F-duration-default`, or inherit the new 12-min
  default? `#scope`
- Does **Reverse Brainstorm** earn a spot in Stress-test phase
  elsewhere, or graveyard cleanly? `#scope`

## Techniques used

- **Constraint Map** (Intake) — surface the hard constraints on
  the rewrite itself: backwards-compat, technique-file reuse, ship
  cadence.
- **Adjacency map** (required) — sibling F-IDs in the same release.
- **ADR** (Closing) — required spine.
- **Devil's Advocate** (Stress-test) — pressed Option 2 (DM as
  opt-in); fell to the "two ways to do the same thing" objection.

Rejected: Five Whys (the "why drop DM" is already in retros — no
hidden need); Cost-of-delay (no cycle mismatch — current is right);
SCAMPER (only one shape to compare).

---

promote-worthy: yes
output-type: decision+spec
