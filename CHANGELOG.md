# Changelog

## Unreleased

### Added

- **Schema / lock-in problem shape.** New SHAPE row routes
  schema / frontmatter / manifest / lock-in sessions to a fit-for-
  purpose recipe (`Atom Inventory → Constraint Mapping → Impact/Effort
  → Pre-mortem (day-1-blocker)`) instead of the wrong-default
  Few-ideas-runs-SCAMPER path. 25–30 min override. Schema *evolution*
  stays routed to "Decision under constraints" with the prior schema
  as a hard constraint.
- **Naming problem shape.** New SHAPE row with a lean recipe
  (`Free Association extended → Affinity Grouping → PCI on top 3 →
  Action Items`). External collision-check is documented as a manual
  user-side step. *Renaming* (existing name + reasons to change) stays
  routed to "Decision under constraints".
- **Atom Inventory technique.** Enumerates the atoms of a structured
  artefact before any mutation step. Explicit "route to Constraint
  Mapping or I/E — not SCAMPER" guard in the *When* clause prevents
  noise on enumerable inputs. Output shape (`atom — type —
  constraints`) is the exact handoff Constraint Mapping consumes.
- **Pre-mortem technique** with three scope tags (`day-1-blocker`,
  `migration-blocker`, `silent-drift`). The Schema-shape recipe reads
  `day-1-blocker` as a phase selector ("what breaks on first install /
  parse / run").
- **Coupled-carryover lift at INTAKE.** When a `BFW_OUTPUT_DIR` glob
  finds a prior session matching the current TOPIC slug stem (date
  prefix stripped), the parser reads the prior session's CRYSTALLIZE
  Selected Ideas and emits a **`Carried hard constraints`** block,
  citing `source: <path>:<line>` per bullet. Per-line `keep / drop /
  soften` offered to the user. Retrospective-mode invocations skip
  the lift. Parser is new code, distinct from the retrospective-mode
  META parser.
- **Anti-anchoring step on coupled carryover.** When the lift fires
  and the constraints block is non-empty, run **Reverse Brainstorm**
  (Inversion) on the lifted set once, just-after-lift, before the
  recipe's first technique. Surviving inversions feed Phase 2 as
  additional candidates. Counters the "ideas remain the same" decay
  risk on coupled chains. Mechanism-2 (recipe-swap) stays parked.
- **MoSCoW `revisit-when:` annotation.** Items shelved to *Won't*
  (or *Could*) MAY carry a trailing `— revisit-when: <observable
  trigger>` (date, named event, or count). Vague triggers rejected
  at facilitator discretion. Human-first, no parser; greppable
  across sessions via `^- .* — revisit-when: `.
- **`examples/coupled-pair/` fixture.** Two-file fixture (prior
  session doc + paired topic) so the carryover lift and anti-anchoring
  step are testable without waiting for organic schema/naming
  dogfood.

### Changed

- **Devil's Advocate gated on a named leader.** DA's *When* clause
  now requires that a ranking technique (Decision Matrix /
  Impact-Effort / PCI) has surfaced a leader. The Binary-choice
  recipe annotates DA with `(after PCI yields a leader)`. The REFLECT
  too-easy-consensus trigger now inserts PCI / I-E *before* DA.
  Mirrors Pre-mortem's existing precondition wording. Reason: DA on
  a still-divergent set manufactures false objections against
  undifferentiated candidates.
- **Retrospective mode probes capability and stamps tier.** No more
  host-name branching: the probe attempts a filesystem read, falls
  back to a chat-history search (`conversation_search` /
  `recent_chats`) on FS-miss, retries once on transient errors. Output
  starts with a greppable `Retro tier: <session-doc | chat-level |
  none> (...)` first line. Empty-but-readable directory is
  `none` tier (not silent fall-through).
- **META `Convergence point` is the load-bearing retro signal.**
  Three-site edit on `SKILL.md`: `(planned: Y min)` removed from
  Duration; the technique parenthetical on `Convergence point:` is
  now mandatory and the narrative tail dropped; the retrospective-
  mode synthesis bullet replaces "Average session duration vs.
  planned" with "Convergence-technique distribution by problem shape"
  (greps the corpus by field name). Old META blocks stay parseable.
- **Default `DURATION` lowered 20 → 12 min** with per-shape overrides in
  the SHAPE table (Blank slate 15, Few ideas 12, Many ideas 20 / 25 if
  15+, Binary / pre-formed 10–12, Decision under constraints 15).
  Explicit `DURATION` always wins. Driven by retro signals across
  real-world session corpora.
- **Six Hats demoted to opt-in only.** Removed from the Few-ideas and
  Many-ideas default recipes in `SKILL.md` and `README.md`; reframed in
  `techniques.md` as a cluster-only technique (4–8 themes max, never
  per-item). Empirical signal: across multiple session corpora, Six Hats
  was overwhelmingly skipped (0% in one, ~22% kept in another). Use
  `TECHNIQUES="six-hats,..."` to opt in.
- **I/E vs MoSCoW distinction codified** in Phase 1. Added a table +
  smells callout: Impact/Effort is a decision tool (rank / drop /
  choose); MoSCoW is a formalisation tool (communicate the chosen
  scope). Flags common mistakes — MoSCoW-first on raw ideas, I/E for
  roadmaps, and back-to-back use on tiny sets.
- **"Grounding First" intake rule** added to Phase 0. When the topic
  touches file syntax / schema / encoding / naming convention, the
  facilitator now greps existing files before generating options
  instead of proposing abstract alternatives. Announce + act, no
  permission ask. Reason: repeated retro signal that ungrounded
  ideation produces options that contradict existing repo conventions.
- **"Decision under constraints" recipe rewritten** to
  `Constraint Mapping → Impact/Effort → MoSCoW → Action Items`. Decision
  Matrix demoted to opt-in only (skipped in 8/9 sessions of one internal
  corpus — the weight-assignment step burns budget without changing the
  outcome on small option sets). Use `TECHNIQUES="decision-matrix,..."`
  to opt in.

## v0.1.1 — 2026-04-14

### Changed

- **Distribution refactor.** Repo is now a Claude Code plugin **and** a
  vercel-labs/skills source from a single layout. Skill moved from repo
  root to `skills/brainstorm/SKILL.md` + `techniques.md`. Added
  `.claude-plugin/plugin.json` and `.claude-plugin/marketplace.json`.
  Retired `install/install-claude-code.sh`. See the 2026-04-11
  distribution brainstorm for rationale.
- **Install paths** (README):
  - Claude Code: `/plugin marketplace add bastien-gallay/bfw` +
    `/plugin install bfw@bfw` (auto-updates at session start).
  - Cross-host: `npx skills add bastien-gallay/bfw` (manual updates via
    `npx skills update`).
  - Claude Desktop / claude.ai: download
    `bfw-brainstorm-vX.Y.Z.skill` from the latest GitHub Release.
    On Desktop, double-click opens an "Add to library" dialog
    (the `.skill` extension is OS-registered). On the web,
    upload via Settings → Capabilities → Skills. Manual updates.
  - Note the asymmetric update model — documented intentionally.
- Trimmed `skills/brainstorm/SKILL.md` `description` to ≤200 chars so
  the skill uploads cleanly to claude.ai (the 200-char frontmatter
  limit is enforced on upload there but not by Claude Code).

### Added

- `justfile` with `release X.Y.Z` target that bumps versions in both
  manifests atomically and tags, plus `check-versions` sanity target.
  Prevents the "silent freeze from forgotten version bump" failure
  mode identified in the brainstorm's Devil's Advocate pass.
- `just package` target that builds a
  `dist/bfw-brainstorm-vX.Y.Z.skill` bundle (zip archive with the
  `.skill` extension — OS-registered to Claude Desktop for
  double-click install, also accepted by the claude.ai web
  uploader). Skill folder at the archive root, dotfiles excluded.
  Reads the version from `plugin.json` so the filename cannot
  drift from the manifest.
- `.github/workflows/release.yml` — on `v*.*.*` tag push, asserts
  tag/manifest agreement, runs `just check-versions` and
  `just package`, extracts the matching CHANGELOG section, and
  creates a GitHub Release with the `.skill` asset attached. This
  is the delivery path for the Claude Desktop / claude.ai install
  channel.

### Follow-ups (tracked, not blocking this release)

- **A3** — Empirically validate both install paths on the restructured
  repo once pushed: `/plugin marketplace add` + `/plugin install` AND
  `npx skills add` from the same source, confirming both preserve the
  `techniques.md` sibling next to `SKILL.md`.
- **A5** — Verify `npx skills` version-pinning semantics (git tag
  respected? branch-only?). vercel-labs/skills docs do not explicitly
  document tag pinning; needs an empirical test.
- **A7** — (Optional) Upstream feature request in `vercel-labs/skills`
  for rename-on-collision detection.
- **A8** — Extend `SKILL.md` `--retrospective` mode with
  `--retrospective-global` flag. Separate PR after this one lands.

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
