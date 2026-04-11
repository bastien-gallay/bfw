<!--
Example session produced by the bfw brainstorm skill. Real output
from prioritising 30 site-improvement ideas for a MkDocs documentation
site (documentation audit, April 2026). Illustrates: large-backlog
problem shape detection, cluster-level dot voting, impact/effort
matrix on filtered items, MoSCoW with adaptation during reflect,
meta-analysis at the end.
-->

# Brainstorm: MkDocs Site Ideas Prioritization

| Field | Value |
| --- | --- |
| **Date** | 2026-04-10 |
| **Duration** | ~15 min |
| **Participants** | User + AI Facilitator |
| **Problem shape** | Many ideas (30+ items) |

## Session Plan

| # | Phase | Technique | Duration | Status |
| --- | --- | --- | --- | --- |
| 0 | Intake | Consolidate + re-tag site/pipeline | 2 min | Done |
| 1 | Analyze | Affinity Grouping (5 strategic clusters) | 2 min | Done |
| 2 | Converge | Dot Voting (10 dots, cluster-level) | 2 min | Done |
| 3 | Converge | Impact/Effort Matrix (2 voted clusters) | 3 min | Done |
| — | Reflect | Architecture decision on sidecar (E) | 2 min | Done |
| 4 | Converge | MoSCoW (final commitment) | 2 min | Done |
| 5 | Crystallize | Action items | 2 min | Done |

## Ideas — Starting Point

30 items from `wip/site-ideas.md` (A through DD + 2 bugs), re-categorized
into **Site**, **Site + Content**, **Pipeline**, and **Bugs**.

3 AI-suggested additions:

- `[AI-1]` Auto-generate changelog from git commits touching findings/
- `[AI-2]` Search integration (Material built-in)
- `[AI-3]` Link-rot CI check via `markdown-link-check`

## Step 1: Affinity Grouping

Regrouped by strategic value:

| Cluster | Items | What it achieves |
| --- | --- | --- |
| **Reader Experience** | I, K, L, M, N, R, Y, Z, U, S, T, CC, [AI-2] | Professional, navigable site for external audience |
| **Content Hygiene** | V, W, X, BB, AA, DD, [AI-3] | Structural fixes, trust in content |
| **Review Workflow** | A, B, C, D, E, F, G, H | Sidecar subsystem coherence |
| **Delivery Pipeline** | J, DD, [AI-1] | End-to-end wip → deliverable flow |
| **Quick Wins** | I, K, O, P | One-line mkdocs.yml toggles |
| **Bugs** | BUG1, BUG2 | Pre-requisites |

### Feedback

> User voted for **Content Hygiene** and **Review Workflow** clusters.
> Skipped cosmetics and quick wins — infrastructure over paint.

### Facilitator Notes

User's instinct is correct for the current project phase (still producing
content, audit pipeline active). Flagged that quick wins I and K are
near-zero effort and should not be forgotten.

## Step 2: Dot Voting

Cluster-level vote. User allocated all dots to:

- Content Hygiene cluster
- Review Workflow cluster

Quick wins and reader-experience polish explicitly deprioritized.

## Step 3: Impact/Effort Matrix

### Content Hygiene

| # | Item | Impact | Effort | Quadrant |
| --- | --- | --- | --- | --- |
| W | Missing index.md in 16+ folders | High | Low | Quick Win |
| V | Orphan pages in wip/ root | Med | Low | Quick Win |
| X | Cross-linking one-way | High | Med | Big Bet |
| BB | Bidirectional traceability | High | Med | Big Bet |
| AA | YAML frontmatter metadata | High | Med | Big Bet |
| DD | Status banners | Med | Med | Fill-in |
| [AI-3] | Link-rot CI | Med | Low | Quick Win |

### Review Workflow

| # | Item | Impact | Effort | Quadrant |
| --- | --- | --- | --- | --- |
| A | Standalone comments, artifacts as tags | High | Med | Big Bet |
| E | Deduplicate sidecar vs pipeline | High | High | Big Bet |
| B | Broader artifact list | Med | Low | Quick Win |
| D | Page/section-level comments | Med | Med | Fill-in |
| C | review-sidecar CLI | Med | Med | Fill-in |
| F | review-next dashboard | High | High | Big Bet |
| G | AI suggest rewrite | Med | High | Avoid |
| H | AI review insights | Med | High | Avoid |

### Architecture Decision (Step 3b)

**Question:** How to resolve E (sidecar vs pipeline triage duplication)?

**Decision:** **Merge — sidecar is the single backend.** JSONL is the
single source of truth. CLI reads/writes through a shared storage module.
Sidecar REST API is the only browser write path.

**Implication:** A becomes the keystone. B, C, D, F are incremental
additions on the merged architecture.

## Step 4: MoSCoW

### Must (do now)

| # | Item | Rationale | Status |
| --- | --- | --- | --- |
| BUG1 | Fix mermaid zoom | Broken visible feature | **Done** — mermaid2 + CDN + zoom JS |
| BUG2 | Fix build warnings | Broken links in delivery build | **Done** — 13→0 delivery-visible |
| I | Collapse left nav | 1-line fix, improves every page view | **Done** |
| K | Enable breadcrumbs | 1-line fix, deep nesting context | **Done** |
| W | Add missing index.md (16+ folders) | Empty nav entries visible to readers | **Done** — 3 real indexes created |
| A+E | Sidecar merge: JSONL single backend | Keystone for review workflow | **Done** — ADR 0003 written |

### Should (this month)

| # | Item | Rationale | Status |
| --- | --- | --- | --- |
| V | Fix orphan pages in wip/ | Quick cleanup | **Done** — consolidated + .pages nav |
| B | Broader artifact list scan | Quick win post-merge | Pending (needs A+E implementation) |
| X | Fix one-way cross-linking | Content trust | **Done** — docs-indexer cross-refs |
| BB | Bidirectional traceability | Automatable, high value | **Done** — 14 services linked |
| AA | YAML frontmatter metadata | Enables filtering, badges, search | **Done** — meta+tags plugins, 26 pages |
| [AI-3] | Link-rot CI check | Prevents BUG2 regression | **Done** — `just lint-links [scope]` |

### Could (when time allows)

| # | Item | Status |
| --- | --- | --- |
| DD | Status banners (draft/review/final) | **Done** — 49 wip pages tagged |
| D | Page/section-level comments | Pending — needs A+E |
| C | `review-sidecar list/review` CLI | Pending — needs A+E |
| F | `review-next` dashboard | Pending — needs A+E |
| CC | Content type indicator in nav | Pending — design choice |

### Won't (parked) — progress

| # | Item | Status |
| --- | --- | --- |
| S | Print/PDF stylesheet | **Done** — brand headers/footers, @media print |
| P | Header auto-hide on scroll | **Done** |
| Z | Rename Wip → Drafts | **Done** |
| U | Font alignment (Plus Jakarta Sans) | **Done** |
| N | Glossary tooltips | **Done** — 42 terms (technical + domain) |
| L | Admonition color-coding | **Done** — 57 blockquotes → admonitions, 21 files |
| M | Branded admonition palette | **Done** — danger/warning/tip/note/abstract |
| R | Richer home page | **Done** — scope admonition, quick access table, entry points |
| O | "Edit this page" link | Pending — needs `repo_url` |
| Q | TOC integration into left nav | Pending — trade-off |
| T | Figure captions for mermaid | Pending — template override |
| [AI-1] | Auto-changelog from git | Pending |
| [AI-2] | Search tuning | Pending |
| G | AI suggest rewrite | Parked — premature |
| H | AI review insights | Parked — premature |
| J | Content assembly pipeline | Parked — ambitious |

### Extra items (emerged during implementation)

| Item | Status |
| --- | --- |
| Build perf: drop mermaid2 plugin (46s → 9s) | **Done** |
| Compact header: logos in brand bar, search in tabs row | **Done** |
| Review comments resolved (risk warning, perf, pipeline FR→EN) | **Done** |

## Outcome

### Action Items

- [x] **BUG1+BUG2** — Fix mermaid rendering (mermaid2 + CDN) + zoom JS + 13→0 broken links
- [x] **I+K** — Collapse nav + breadcrumbs in `mkdocs.yml`
- [x] **W** — 3 index.md created (adr, kt, reports)
- [x] **A+E** — ADR 0003: sidecar merge as single JSONL backend
- [x] **V** — Orphan consolidation (v1/v2 guide) + .pages nav
- [x] **AA** — meta + tags plugins, frontmatter on 26 pages, schema doc
- [x] **X+BB** — docs-indexer cross-service scanner, 14 services linked
- [x] **[AI-3]** — `just lint-links [delivery|wip|all]`
- [x] **DD** — Status banners (draft/review/final) on 49 wip pages
- [x] **S** — Print/PDF stylesheet + brand identity (logos, confidential, @media print)
- [x] **P** — Header auto-hide on scroll
- [x] **Z** — Rename Wip → Drafts
- [x] **U** — Font alignment (Plus Jakarta Sans)
- [x] **N** — Glossary tooltips (42 terms: technical + domain)
- [x] **L** — Admonition migration (57 blockquotes → colored admonitions, 21 files)
- [x] **M** — Branded admonition palette
- [x] **R** — Richer home page (scope, quick access table, entry points)
- [x] **Extra** — Build 46s → 9s, compact header, review comments resolved
- [ ] **B** — Broader artifact list scan (needs A+E implementation)
- [ ] **D, C, F** — Sidecar enhancements (need A+E implementation)
- [ ] **CC, O, Q, T, AI-1, AI-2** — Remaining independent items

---

## Session Meta-Analysis

- **Duration:** ~15 min (planned: 20 min)
- **Techniques used:** Affinity Grouping (2 min), Dot Voting (2 min),
  Impact/Effort Matrix (3 min), Architecture Decision (2 min embedded in
  reflect), MoSCoW (2 min)
- **Techniques skipped:** Six Hats (not needed — items were clear enough
  that Impact/Effort was sufficient), NUF (dot voting was faster for 30+
  items)
- **Adaptations made:** Replaced planned "Six Hats per group" with
  Impact/Effort Matrix — 30 items would have made Six Hats tedious.
  Inserted an architecture decision micro-step during reflect (E gates
  the entire sidecar cluster). Promoted I+K from Won't to Must after
  facilitator flagged near-zero effort.
- **Problem shape:** Many ideas (30+) — stayed consistent
- **Convergence point:** Step 2 (dot voting) — user's cluster votes
  eliminated 50% of items immediately
- **What worked well:** Cluster-level dot voting was the right
  granularity for 30+ items. The architecture decision embedded in
  reflect kept momentum without a separate analysis step.
- **What could improve:** Could have pre-filtered bugs as "fix regardless"
  to save one MoSCoW row. The Site vs Pipeline dimension (original topic
  question) was answered implicitly by the intake categorization — could
  have been made more explicit.
- **Session energy:** High — decisive answers, no hesitation
- **Recommendation for similar sessions:** For 30+ item backlogs, start
  with cluster-level voting before item-level analysis. Skip Six Hats
  unless items are ambiguous or contentious.
