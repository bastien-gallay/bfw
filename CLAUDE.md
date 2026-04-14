# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## What this repo is

`bfw` is a **Claude Code skill package**, not an application. There is no
build step, no runtime code, no tests. The "product" is two markdown
files that get installed as a skill into Claude Code (or any compatible
host) and loaded as a prompt at session time:

- `skills/brainstorm/SKILL.md` — the facilitator prompt. Defines the
  session flow, the argument contract (`TOPIC`, `IDEAS`, `DURATION`,
  `OUTPUT`, `TECHNIQUES`), the problem-shape recipes, and the output
  document template. This is "the brain".
- `skills/brainstorm/techniques.md` — the technique library (20
  techniques across 5 phases: diverge / analyze / converge /
  crystallize / adaptive). Each entry has Purpose / When / How /
  Duration / Output shape. `SKILL.md` references this file by name at
  session start and treats it as hot-swappable content.

These two files are tightly coupled by convention: the recipe tables in
`SKILL.md` name techniques that must exist in `techniques.md` with the
expected phase and output shape. When editing one, check the other.

The repo also contains two manifest files that make `bfw` installable
as a Claude Code plugin **and** as a cross-host skill via
[vercel-labs/skills](https://github.com/vercel-labs/skills):

- `.claude-plugin/plugin.json` — Claude Code plugin manifest. Plugin
  name is `bfw`; the skill inside is auto-discovered at
  `skills/brainstorm/`.
- `.claude-plugin/marketplace.json` — single-plugin marketplace catalog
  that lets users run `/plugin marketplace add bastien-gallay/bfw` then
  `/plugin install bfw@bfw`. Plugin source is `"./"` because the
  plugin root IS the marketplace root.

## Architecture invariants worth preserving

- **SKILL.md drives process, techniques.md provides content.** Do not
  inline technique instructions into `SKILL.md`, and do not put session
  flow logic into `techniques.md`. The split is what makes the library
  hot-swappable.
- **The session flow is fixed:** `INTAKE → SHAPE → PLAN → [STEP → LOG →
  REFLECT]* → CRYSTALLIZE → META`. New behaviors should slot into one of
  these phases rather than introducing a new top-level phase.
- **Announce + adapt without asking permission** is a design principle
  (see README "Why" and SKILL Phase 4). Changes that add confirmation
  prompts before adaptation go against the framework's intent.
- **Meta-analysis is first-class.** Every session must end with a META
  block; the retrospective mode (`TOPIC="--retrospective"`) depends on
  it being present and parseable.
- **Problem-shape table is the routing layer.** The shape table in
  README.md, `SKILL.md` Phase 1, and CHANGELOG must stay in sync when
  recipes change.
- **Repo layout must simultaneously satisfy Claude Code plugin
  conventions AND vercel-labs/skills discovery.** Both look for
  `skills/<name>/SKILL.md` at the repo root, so the brainstorm skill
  lives at `skills/brainstorm/`. Moving it breaks both install paths
  at once. Adding a second skill means adding a sibling directory
  under `skills/`, not nesting.
- **Version fields must stay aligned.** `.claude-plugin/plugin.json`
  `version`, `.claude-plugin/marketplace.json` `metadata.version`, and
  `.claude-plugin/marketplace.json` `plugins[0].version` are all
  bumped together by `just release X.Y.Z`. Do not edit them by hand —
  Claude Code caches by version, and a skipped bump means users
  silently freeze on the old code.

## Installation model

`bfw` distributes through three channels that all target the same
`skills/brainstorm/` directory:

- **Claude Code plugin** via `/plugin marketplace add bastien-gallay/bfw`
  then `/plugin install bfw@bfw`. Auto-updates at session start.
  Driven by `.claude-plugin/plugin.json` and `.claude-plugin/marketplace.json`.
- **Cross-host** via `npx skills add bastien-gallay/bfw` (vercel-labs/skills),
  which discovers `skills/brainstorm/SKILL.md` and copies it to the
  target host's skill directory. Updates are manual
  (`npx skills update`).
- **Claude Desktop / claude.ai (web)** via a `.skill` file — a zip
  archive with an OS-registered extension. Double-clicking opens
  Claude Desktop's "Add to library" dialog; the web uploader also
  accepts `.skill` directly. Built by `just package` and attached
  to each GitHub Release by `.github/workflows/release.yml`. The
  archive root must be the `brainstorm/` folder (claude.ai
  requires this layout) and the SKILL.md `description` field must
  stay ≤200 chars (enforced on upload). Updates are manual
  (re-download + re-install).

Releases go through `just release X.Y.Z` which bumps both manifests
atomically and creates an annotated git tag. The tag push then
triggers `release.yml`, which re-packages and publishes the zip.
There is no build step in the repo itself and no separate installer
script. Full release procedure and CI integration plans live in
`docs/RELEASING.md`.

## Working on the markdown

- Per user global instruction: run markdownlint on any modified markdown
  file. Repo config is in `.markdownlint.json` (MD013 / MD033 / MD041
  disabled — long lines, inline HTML, and missing H1 are OK).
- `brainstorm/` and `wip/` are gitignored: they are where *users* of the
  skill write session outputs, not repo content. Do not commit example
  sessions there — `examples/` is the curated location.
- Commit messages: no "Claude" signature (per user global instruction).
