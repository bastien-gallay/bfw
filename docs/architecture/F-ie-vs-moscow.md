# F-ie-vs-moscow

## ✂️ reshape

Keep the goal — codify the **I/E = decide / MoSCoW = formalise**
distinction so the brainstorm skill's recipes read cleanly when
both appear back-to-back. Change the slice. The TODO says "in
SKILL.md recipes"; that violates the architecture invariant
*SKILL.md drives process, techniques.md provides content*. **Move
the codification into `techniques.md`** as one short cross-
reference line on each of the two technique entries, plus a
single sentence in the `SKILL.md` preamble pointing to the pair.

## TL;DR

Ship the codification, but as two ~12-word annotations in
`techniques.md` (one per entry), not as new SKILL.md prose. **The
load-bearing call is putting the pedagogy where the techniques
live.** The risk that bites: if it's only in SKILL.md, the
distinction becomes invisible when users invoke `TECHNIQUES=` and
bypass shape-detection.

## Make me dream

Mid-session, the skill announces *"Now I/E — to decide which two
to commit to. Then MoSCoW — to lock what's in this round and what
defers."* The user nods; the back-to-back convergence finally
reads as **two different jobs**, not "the skill is hedging by
running two prioritisation steps".

## Job to be done

- **User:** facilitator (the skill, executing a recipe).
- **Trigger:** any recipe runs I/E and MoSCoW in the same session,
  or user invokes them explicitly via `TECHNIQUES=`.
- **Outcome:** announcement language for each step makes the
  decide-vs-formalise split explicit.
- **Constraint:** zero new technique entries; no SKILL.md bloat.

## Adjacency map

- **Scope-adjacent:** `techniques.md:155` (I/E) and `techniques.md:142`
  (MoSCoW) — both edited.
- **Priority-adjacent:** `F-decision-recipe-rewrite` (just shipped
  👍) consumes this distinction in its `Constraint Map → I/E →
  MoSCoW → Actions` chain.
- **Dependency-adjacent:** soft prerequisite for
  `F-decision-recipe-rewrite`; also clarifies the large-backlogs
  override at `SKILL.md:75` (`I/E (filtered) → MoSCoW`).

## Roadmap-placement challenge

One cycle later: `F-decision-recipe-rewrite` ships, users ask "why
both I/E and MoSCoW?", retro flags it within one session.
One cycle earlier: blocked — only Claude Desktop flagged it; we
needed `F-decision-recipe-rewrite`'s pressure to make it load-
bearing. **Now is right.** Quantitative anchor: ~2 lines of diff
across `techniques.md`; ~1 sentence added to `SKILL.md` preamble.
0 new technique entries. Should ship **in the same commit** as
`F-decision-recipe-rewrite` so the rewrite lands with its pedagogy.

## ADR core

**Problem.** Recipes that sequence I/E and MoSCoW (Many-ideas
override, large-backlogs override, the just-rewritten Decision-
under-constraints) read as if the skill is doing prioritisation
twice. Claude Desktop retro: users mentally collapse the two,
skip one, or pick the "wrong" one for the job. Pedagogy gap, not
a technique gap — both entries are already documented.

**Current state.**

- `techniques.md:142` — MoSCoW: "Prioritize by necessity. Feature
  lists, requirement sorting, scope decisions."
- `techniques.md:155` — I/E: "Visual prioritization on two axes.
  Need to find quick wins."
- Both entries describe **what** they do; neither names **when to
  use which** vs the other.
- `SKILL.md:75` chains them (`I/E (filtered) → MoSCoW`) without
  saying why both.

**Options.**

| # | Option | Pros | Cons |
|---|---|---|---|
| 1 | **Annotate `techniques.md` entries** (one line each) + one-sentence pointer in `SKILL.md` preamble | Pedagogy lives next to content; respects architecture invariant; reaches `TECHNIQUES=` users | Two-file diff |
| 2 | New SKILL.md sidebar "Decide vs Formalise" before SHAPE table | Visible during shape detection | Duplicates content into SKILL.md; misses `TECHNIQUES=` path; bloat |
| 3 | New combined `techniques.md` entry "Decide-then-Formalise (I/E → MoSCoW)" | One block to point at | Inflates technique count; recipes still need the two atoms separately |
| 4 | Status quo; rely on recipe order to teach implicitly | Zero churn | Claude Desktop retro proves it doesn't teach |

**Choice.** Option 1. Reasons: (a) keeps SKILL.md/techniques.md
split clean; (b) reaches users who bypass shape-detection via
`TECHNIQUES=`; (c) two ~12-word annotations is the smallest edit
that closes the gap. Cross-label challenges: **👍** as-scoped
(SKILL.md prose) — fails; violates the architecture invariant.
**🧬** (split into "I/E annotation" + "MoSCoW annotation" + "SKILL
pointer") — fails; one conceptual change, atomic.

**Consequences.**

- ✅ Recipes self-explain when announcing the I/E → MoSCoW chain.
- ✅ `TECHNIQUES=` users get the distinction too.
- ⚠️ Two-file diff (modest cost).
- 🔁 Revisit if a third technique enters the converge phase and
  needs similar discrimination from I/E or MoSCoW.

## Output type

**Decision + spec stub.**

- **Scope.** Add to `techniques.md:155` (I/E) Purpose line: *"Use
  to **decide** which to do — quick wins / big bets."* Add to
  `techniques.md:142` (MoSCoW) Purpose line: *"Use to **formalise**
  the decision — what's locked in, what defers."* Add one
  sentence to `SKILL.md` preamble (above SHAPE table): *"When a
  recipe chains I/E → MoSCoW, treat them as decide → formalise."*
- **Inputs.** None (documentation edit).
- **Outputs.** Updated technique entries; updated SKILL.md preamble.
- **Edges.** If user asks "why both?" mid-session, skill cites
  the decide / formalise split verbatim. If only one is in the
  recipe, no announcement change.
- **Test shape.** Re-run a daily-ops session against the
  rewritten Decision-under-constraints recipe; confirm the I/E
  step is announced as "decide" and MoSCoW as "formalise".

## Spawned children

None.

## Open questions

- Should the SKILL.md preamble sentence sit above the SHAPE table
  or inside the Phase 2 announcement guidance? `#scope`
- Does the **NUF Test** (`techniques.md:165`) need the same
  treatment vs I/E to avoid future drift? `#scope`
- Same-commit ship with `F-decision-recipe-rewrite`, or land
  first as a pure-doc PR? `#deps`
- Is "formalise" the right word for FR users, or should the
  annotation read "lock in" / "scope-fix"? `#i18n`

## Techniques used

- **Adjacency map** — sibling F-IDs and exact line numbers.
- **ADR** — required spine.
- **Devil's Advocate** — pressed the as-scoped slice ("codify in
  SKILL.md"); fell to the architecture-invariant objection.

Rejected: Constraint Map (the constraints — keep architecture
invariant, no bloat — surfaced naturally in DA, no need to
formalise); Pre-mortem (no risk surface; doc edit); Cost-of-delay
(cycle is forced by `F-decision-recipe-rewrite`, no separate timing
question).

---

promote-worthy: yes
output-type: decision+spec
