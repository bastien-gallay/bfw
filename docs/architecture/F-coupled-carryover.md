# F-coupled-carryover (v3) — Standalone session-level lift, fixture-tested

## 👍 ship — with amendments

Third pass. v1 returned 👍 (auto-lift unsafe) → v2 returned ✂️ (gate
under-specified, false sequencing dep). v3 converges. The reshape
asked for in v2 is **specifiable as it stands**: date-stripped glob
over `BFW_OUTPUT_DIR` keyed on slug-stem; `examples/coupled-pair/`
fixture replaces the schema+naming organic-test wait; upstream-dep
claim on `F-tech-reflect-micro-decision` is dropped (that row was
killed; ROADMAP contradiction note resolves the same way). **A third
✂️ would mean the feature is unstable — it is not.** What looked like
ambiguity in v2 was the unresolved kill verdict on the alleged
upstream. With that resolved, the slice is clean. Amendments below
name the three gaps that survived pressure-testing.

## TL;DR

Verdict 👍-with-amendments: gate predicate, fixture, and
session-level parser are all specifiable today. The decision that
matters: **lift session-level CRYSTALLIZE bullets** (not META, not
intra-step decisions) into a `Carried hard constraints` block at
INTAKE step 3.5. Risk: parser is new code — not the retrospective-
mode parser — name it as such in the spec stub.

## Make me dream

User runs `/brainstorm TOPIC="naming for the schema lock"`. INTAKE
step 3.5 globs `${BFW_OUTPUT_DIR}/*-schema-lock*.md` (date prefix
stripped), finds yesterday's `20260506-schema-lock.md`, parses the
`## Outcome → Selected Ideas / Decisions` bullets, prints a
**Carried hard constraints** block citing `path:line` per item, and
offers `keep / drop / soften` per line. Today's consolidated list
arrives pre-pruned. One observable change, one user role, one
artefact, one command.

## Job to be done

- **User:** solo dev running session N+1 in a coupled chain.
- **Trigger:** prior session file exists with overlapping slug stem,
  OR user names it.
- **Outcome:** prior CRYSTALLIZE verdicts lift as Hard constraints.
- **Constraint:** announce verbatim, allow per-line override.

## Adjacency map

- **Scope-adjacent:** `skills/brainstorm/SKILL.md:43–66` (Phase 0
  INTAKE) and `:200–208` (Phase 5 CRYSTALLIZE — the lift source).
- **Priority-adjacent:** `F-schema-shape` + `F-naming-shape` (P1) —
  remain the natural organic test pair, but no longer ship-gates.
- **Dependency-adjacent:** `F-grounding-first` (shipped) — same
  announce-and-act pattern; this rule is its session-level sibling.
  No vocabulary contention.

## Roadmap-placement challenge

Cost of one cycle later: schema+naming may ship and re-litigate
already-decided constraints; one dogfood point lost. Cost of one
cycle earlier (now): ~15 LOC in `SKILL.md` + ~30 lines fixture.
**Quantitative:** v2 wait was 2 cycles (2 P1 rows); v3 path is 0
cycles (no deps after kill resolution). Net: ship in next batch.

## ADR core

**Problem.** Prior session decisions re-enter session N+1 as prose
context, treated as suggestions. The carry-over surface exists
(`SKILL.md:62-63` "Any hard constraints?") but is user-driven.
Coupled chains drift.

**Current state.**

- `SKILL.md:24` — `OUTPUT` default `brainstorm/YYYYMMDD-<slug>.md`.
- `SKILL.md:27-29` — `BFW_OUTPUT_DIR` env override **exists today**;
  glob root is canonical.
- `SKILL.md:200-208` — CRYSTALLIZE produces "Selected Ideas /
  Decisions" with rationale. **This is the lift source**, not META.
- `SKILL.md:339-353` — Retrospective mode reads the same dir but
  parses META, not CRYSTALLIZE. Different parser; do not reuse.
- `examples/` exists; no `coupled-pair/` subdir yet.

**Options.**

| # | Option | Pros | Cons |
| --- | --- | --- | --- |
| 1 | Ship v3 spec: glob + fixture + CRYSTALLIZE parser, standalone | No deps; fixture-testable; gate is unambiguous | New parser, not retrospective-mode reuse |
| 2 | Wait for organic schema+naming sessions | Real test pair | 2-cycle wait; fixture is cheaper |
| 3 | Re-couple to a future MUST/WON'T tagger | Cleaner lift source | The killed `F-tech-reflect-micro-decision` was that tagger; reviving it contradicts the kill |

**Choice.** Option 1. Reasons: (a) all three v2 ambiguities resolve
with the kill verdict on the alleged upstream; (b) `BFW_OUTPUT_DIR`
glob is verified to exist at `SKILL.md:27-29`; (c) fixture removes
the organic-test gate. **Cross-label refutations.** ✂️ rejected — a
third reshape on the same feature with no new ambiguity surfacing
would mean the feature is unstable; it is not, the v2 ambiguity was
the upstream-dep contradiction, now resolved. 🧬 rejected — gate +
parser + fixture form one feature; the fixture is a test artefact,
not a roadmap row.

**Consequences.**

- ✅ Gate: `glob("${BFW_OUTPUT_DIR:-brainstorm}/*-${slug_stem}*.md")`
  with date prefix stripped, plus user-mention OR.
- ✅ Lift source is CRYSTALLIZE bullets, not META — stable schema
  (`SKILL.md:200-208`), no MUST/WON'T tagger needed.
- ⚠️ Slug-stem cross-topic collisions accepted; mitigated by per-line
  override.
- ⚠️ Retrospective-mode invocation (`TOPIC="--retrospective"`) MUST
  bypass the lift — it reads the dir as a corpus, not as priors.
  Spec must encode this skip explicitly.
- 🔁 Revisit if fixture-based testing misses a class of bug, or if
  cross-channel `BFW_OUTPUT_DIR` resolution diverges (plugin / npx /
  `.skill` install paths).

## Output type

decision+spec

**Spec stub:**

- **Scope:** `SKILL.md` Phase 0 INTAKE step 3.5 (between Grounding-
  First and Free Association); `examples/coupled-pair/` fixture
  (2 files: prior session doc + topic for N+1).
- **Inputs:** `BFW_OUTPUT_DIR` (default `brainstorm/`), `TOPIC` slug
  stem, optional user mention.
- **Outputs:** `**Carried hard constraints**` block, one bullet per
  CRYSTALLIZE Selected Idea with `source: <path>:<line>`.
- **Edges:** retrospective mode → skip lift; empty glob + no
  mention → skip silently; multiple matches → ask user (max 3);
  user strikes line → drop; CRYSTALLIZE section absent → degrade
  with one-line warning.
- **Test shape:** `examples/coupled-pair/` provides session-1.md
  with a known CRYSTALLIZE block; running `/brainstorm` against
  the paired topic must print the carried block, cite paths, honour
  per-line override. Negative test: `--retrospective` invocation
  against same fixture must not lift.

## Spawned children

(none — fixture is a test artefact)

## Open questions

- Cross-channel `BFW_OUTPUT_DIR` resolution: does `.skill` install
  honour the env var on Claude Desktop? `#scope`
- Glob recursion: top-level only, or `**`? Default top-level. `#scope`
- Fixture format: full session doc, or trimmed CRYSTALLIZE-only
  stub? Recommend full doc for realism. `#scope`

## Techniques used

- **ADR** — spine.
- **Constraint Mapping** — separated load-bearing constraints (parser
  source, retrospective skip) from ambient ones (recursion, fixture
  shape).
- **Devil's Advocate** — pressure-tested the "third ✂️ = unstable"
  claim; survived because v2's ambiguity traced to an external
  contradiction (killed upstream), not feature-internal instability.

**Rejected.** Inversion (v2 already ran it productively). Pre-mortem
(failure modes named in Consequences). SCAMPER (location forced).

---

```text
promote-worthy: yes
output-type: decision+spec
```
