# F-host-capability-matrix — feature-torture report

## ✂️ reshape

Keep the goal — unblock `F-collision-probe` — but **shrink the
slice to a one-page table at `docs/host-capability-matrix.md`,
scoped to `WebSearch` + `WebFetch` only, every cell carrying a
`Last-verified:` date and an evidence pointer**. Drop the bigger
framings (probe runner, session-time capability registry). Add a
top-of-file `🔁 revisit-when` trigger so the doc is self-aware
about staleness instead of pretending to be evergreen.

## TL;DR

The roadmap entry hides three features (doc, probe runner,
registry); the smallest slice that flips `F-collision-probe`'s
verdict is the doc. **The risk is not accuracy at write-time — it
is staleness six weeks later** when a host quietly enables web
tools and the matrix mis-routes the skill.

## Make me dream

A maintainer opens `docs/host-capability-matrix.md`, sees 3 rows
(plugin / npx / .skill) × 2 columns (`WebSearch`, `WebFetch`), each
cell ✅ / ❌ / ❓ with one-line evidence and `Last-verified:` date.
They re-torture `F-collision-probe`, get a deterministic verdict
(👍 / ✂️ / 👎, never 🤷), and ship or kill the technique the same
afternoon.

## Job to be done

- **User:** bfw maintainer running `/feature-torture
  F-collision-probe` (re-torture).
- **Trigger:** the v1 report's `🤷` blocks any naming-recipe polish.
- **Outcome:** a single doc the next torture cites to flip 🤷 →
  👍 / ✂️ / 👎 in one sentence.
- **Constraint:** no host-branching code in `SKILL.md`; no paid
  account required to verify any cell.

## Adjacency map

- **Scope-adjacent:** `docs/RELEASING.md` — the only existing entry
  under `docs/`. New file sits beside it; same audience (maintainer,
  not end user).
- **Priority-adjacent:** `F-collision-probe` — sole consumer today;
  `F-retro-output-schema` (P2, parked) does not need this.
- **Dependency-adjacent:** enables `F-collision-probe` re-torture;
  enabled by nothing — pure documentation.

## Roadmap-placement challenge

Cost of one cycle later: low — `F-collision-probe` stays 🤷, no
user is blocked. Cost of one cycle earlier: also low (~30–60 min
of probing). **Quantitative:** 1 file, 6 cells; vs the runner
alternative (~150 LOC of shell, `just probe-hosts` target, new
manifest surface). The doc is ~25× smaller and unblocks the same
verdict. Land this cycle; defer the runner until a second consumer
appears.

## ADR core

### Problem

`F-collision-probe`'s verdict is gated on whether `WebSearch` /
`WebFetch` are reliably available across the three install
channels. No canonical doc records that fact. The matrix must
serve the *maintainer* during torture, not the *facilitator* at
session time (host-branching at runtime would violate "announce +
adapt without asking permission").

### Current state

- `docs/` contains only `RELEASING.md`; no capability docs.
- `techniques.md` and `SKILL.md` reference zero external tools
  (one stray "search" hit, unrelated example).
- `.claude-plugin/plugin.json` declares no `permissions` / `tools`.
- Three install channels in `CLAUDE.md`: plugin / npx / `.skill`.
- `F-collision-probe.md:91` names this matrix as the blocking probe.

### Options

| # | Option | Pros | Cons |
| --- | --- | --- | --- |
| 1 | One-page doc, `WebSearch`+`WebFetch` only, dated cells | Smallest slice; unblocks F-collision-probe; no code | Goes stale; needs manual refresh |
| 2 | Tested probe runner (`just probe-hosts`) emitting a JSON matrix | Self-refreshing; reusable | ~150 LOC; no second consumer; new manifest surface |
| 3 | Session-time capability registry the skill reads | Enables host-branching at runtime | Violates "announce + adapt"; new architectural surface |
| 4 | Skip the matrix; ship F-collision-probe as Claude-Code-only | Saves a P2 row | Forces host-branching into the skill; same architectural cost as Option 3 |

### Choice

**Option 1 with two amendments**: (a) every cell carries
`Last-verified: YYYY-MM-DD` + a one-line evidence pointer; (b) the
doc declares a `🔁 revisit-when` trigger (any cell > 90 days, host
announces tool changes, or a 4th channel appears). Refutations:
**👍 ship as-stated** fails — the bare scope ("matrix in docs/") is
ambiguous between Options 1/2/3 and would gold-plate; **🧬 split**
fails — the runner/registry aren't hidden features here, they're
future features blocked by the same unknown and should spawn from
a *second* consumer.

### Consequences

- ✅ `F-collision-probe` re-torture lands deterministically next
  session; verdict pair in its v1 collapses to one of 👍 / ✂️ / 👎.
- ✅ Sets the precedent that capability claims in this repo are
  **dated and falsifiable**, not evergreen prose.
- ⚠️ Manual refresh burden on the maintainer (~10 min per audit).
  Acceptable while there is one consumer.
- 🔁 Revisit when a second tool-dependent technique is proposed,
  OR when any cell goes stale per the trigger above.

## Output type — decision + spec stub

- **Scope:** `docs/host-capability-matrix.md`. 2 tools × 3 channels.
  No other tool families.
- **Inputs:** one manual probe per channel (fresh install, trivial
  `WebSearch` prompt); public docs URLs for citations.
- **Outputs:** markdown table; per-cell ✅ / ❌ / ❓ plus evidence
  line and `Last-verified` date; top-of-file `🔁 revisit-when` block.
- **Edges:** ❓ is a valid cell (probe inconclusive); cite *why*.
  No paid-tier probes — note the gap.
- **Test shape:** `F-collision-probe` v2 cites this doc by path
  and line; its verdict is 👍 / ✂️ / 👎 — never 🤷.

## Spawned children

(none — runner and registry are blocked by absence of a second
consumer, not by this row)

## Open questions

- Does `.skill` upload to claude.ai web expose `WebSearch` to the
  uploaded skill, or only to first-party Anthropic tools? `#deps`
- Does `npx skills add` preserve any tool-permission contract, or
  is the host (Cursor / Cline / etc.) fully responsible? `#deps`
- Should the matrix also probe `WebFetch` allowlists per host, or
  is presence/absence enough for the F-collision-probe verdict?
  `#scope`

## Techniques used

- **ADR** (closing spine).
- **Job-to-be-done unpack** (forced the audience question — the doc
  serves the maintainer during torture, not the facilitator at
  runtime — which collapsed Options 2/3).
- **Constraint Mapping** (mapped "no host-branching" + "no paid
  account" + "must flip a 🤷"; Option 1 satisfies all three,
  Options 2/3 add architectural cost without changing the verdict).
- **Inversion** (asked "what makes this doc fail six weeks from
  now?" — yielded the staleness amendment).

Rejected: SCAMPER (no artefact to mutate yet); Decision Matrix
(4 options, 1 dominant criterion — Constraint Map sufficed);
Pre-mortem (Inversion covered the failure mode); Cost-of-delay
(symmetric and small both ways).

---

promote-worthy: yes
output-type: decision+spec
