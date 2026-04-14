# Changelog

## Unreleased

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
