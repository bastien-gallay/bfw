# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## What this repo is

`bfw` is a **Claude Code skill package**, not an application. There is no
build step, no runtime code, no tests. The "product" is two markdown
files that get installed as a skill into Claude Code (or any compatible
host) and loaded as a prompt at session time:

- `SKILL.md` — the facilitator prompt. Defines the session flow, the
  argument contract (`TOPIC`, `IDEAS`, `DURATION`, `OUTPUT`,
  `TECHNIQUES`), the problem-shape recipes, and the output document
  template. This is "the brain".
- `techniques.md` — the technique library (20 techniques across 5
  phases: diverge / analyze / converge / crystallize / adaptive). Each
  entry has Purpose / When / How / Duration / Output shape. `SKILL.md`
  references this file by name at session start and treats it as
  hot-swappable content.

These two files are tightly coupled by convention: the recipe tables in
`SKILL.md` name techniques that must exist in `techniques.md` with the
expected phase and output shape. When editing one, check the other.

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

## Installation model

`install/install-claude-code.sh` copies `SKILL.md` and `techniques.md`
to either `~/.claude/skills/brainstorm/` (default) or
`./.claude/skills/brainstorm/` (`--project`). This is the only
"executable" in the repo. If file names or the two-file structure
changes, the installer must change with them.

## Working on the markdown

- Per user global instruction: run markdownlint on any modified markdown
  file. Repo config is in `.markdownlint.json` (MD013 / MD033 / MD041
  disabled — long lines, inline HTML, and missing H1 are OK).
- `brainstorm/` and `wip/` are gitignored: they are where *users* of the
  skill write session outputs, not repo content. Do not commit example
  sessions there — `examples/` is the curated location.
- Commit messages: no "Claude" signature (per user global instruction).
