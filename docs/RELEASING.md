# Releasing bfw

Maintainer-facing notes on how a release is cut today (manual, driven
by `just release`) and how the process is expected to evolve toward
GitHub Actions automation. Not linked from the public README on
purpose — this is internal.

## What a release actually ships

There is no build step in the repo itself. A release is:

1. A bumped `version` in `.claude-plugin/plugin.json`.
2. A bumped `metadata.version` AND `plugins[0].version` in
   `.claude-plugin/marketplace.json` (both must match — see
   `just check-versions`).
3. A commit on `main` with the above changes.
4. An annotated git tag `vX.Y.Z` on that commit.
5. A CHANGELOG.md entry describing what changed.
6. A `bfw-brainstorm-vX.Y.Z.skill` bundle attached to the GitHub
   Release — a zip archive with the `.skill` extension
   (OS-registered to Claude Desktop for double-click install, also
   accepted by the claude.ai web uploader). Built by `just package`
   in CI (`.github/workflows/release.yml`) when the tag is pushed.

Users pick up the release via:

- **Claude Code plugin channel** — `/plugin marketplace update bfw`
  (or auto-update at session start) reads the new `plugin.json` version
  and refreshes its cache. Skipping the version bump is a silent
  freeze: users stay on the cached old code forever. This is the
  single most important invariant the release process protects.
- **vercel-labs/skills channel** — `npx skills update` re-clones the
  repo. No version field drives it; it always pulls latest `main`.
  The tag is useful for humans browsing `bastien-gallay/bfw` on
  GitHub, not for this install path.
- **Claude Desktop / claude.ai channel** — users download
  `bfw-brainstorm-vX.Y.Z.skill` from the GitHub Release page. On
  Desktop they double-click it (the `.skill` extension is
  OS-registered, so it opens an "Add to library" dialog); on the
  web they upload it via Settings → Capabilities → Skills. Updates
  are manual (re-download + re-install). The archive layout and
  SKILL.md description-length constraint are documented in
  CLAUDE.md "Installation model".

## Current process (manual)

### Prerequisites

- `just` and `jq` on `PATH`.
- Working tree is clean and on `main`.
- `origin` points at `github.com/bastien-gallay/bfw` and you can push.
- CHANGELOG.md has an `## Unreleased` section with the changes you
  want to ship.

### Steps

1. **Rename the CHANGELOG section.** In `CHANGELOG.md`, change
   `## Unreleased` to `## vX.Y.Z — YYYY-MM-DD`, then add a new empty
   `## Unreleased` above it. Commit this on its own (e.g.
   `docs(changelog): cut vX.Y.Z section`) so the release commit
   itself stays manifest-only and easy to audit.
2. **Run `just release X.Y.Z`.** This does all of:
    - Validates `X.Y.Z` is semver (accepts `X.Y.Z-prerelease` too).
    - Aborts if the working tree is dirty.
    - Aborts if `vX.Y.Z` already exists as a tag.
    - Rewrites both manifest version fields via `jq` (atomic per file,
      atomic across files because the whole target is one bash block).
    - Creates a commit `chore: release vX.Y.Z`.
    - Creates an annotated tag `vX.Y.Z`.
3. **Push commits and tag.** `git push && git push --tags`. These are
   two operations; pushing the commit without the tag leaves the
   tag local, which silently breaks the "release is visible on
   GitHub" expectation. Do both.
4. **Verify.** Check:
    - The tag shows at
      <https://github.com/bastien-gallay/bfw/releases/tag/vX.Y.Z>.
    - `just check-versions` still passes on a fresh clone.
    - Install in a scratch Claude Code session:
      `/plugin marketplace update bfw` then `/plugin install bfw@bfw`,
      and confirm the new version is what you just released.
    - Cross-host install in a scratch directory:
      `npx skills add bastien-gallay/bfw`, then inspect the copied
      `SKILL.md` for the expected changes.

### Guardrails `just release` enforces

- Semver format.
- Clean working tree.
- Tag uniqueness.
- Atomic version bump across both manifests (drift is impossible if
  this target runs to completion).
- Annotated tag (not lightweight) so `git describe` and GitHub's
  release UI treat it as a real release.

### Guardrails `just release` does NOT enforce (yet)

These are the gaps the planned CI workflows are meant to cover:

- CHANGELOG.md contains a section matching the version being released.
- The tag version matches the manifest version (currently relies on
  the maintainer passing the same `X.Y.Z` that they bumped).
- Markdown files pass markdownlint.
- Prior `main` was actually pushed to `origin` before the new release
  is cut (unpushed in-flight work can get tagged by accident).
- The `jq` edits didn't break JSON schema (currently only structural
  validity is guaranteed; semantic validity against Claude Code's
  plugin schema is trusted).

## Planned CI integration (GitHub Actions)

No workflows exist yet. These are the ones to add under
`.github/workflows/`, in order of priority.

### 1. `lint.yml` — PR & push validation

- **Triggers:** `pull_request`, `push` to `main`.
- **Jobs:**
  - `markdownlint` — runs `markdownlint-cli2` against changed `*.md`
    files, honoring `.markdownlint.json`. `paths:` filter to `**.md`
    so non-doc PRs don't run it at all.
  - `check-versions` — runs `just check-versions` to catch the
    version-drift failure mode even outside a release cut.
- **Rationale:** enforces the global user instruction (lint
  markdown on every change) and protects the "silent freeze from
  forgotten version bump" failure mode identified in the 2026-04-11
  distribution brainstorm.

### 2. `release.yml` — tag push → GitHub Release (SHIPPED)

Lives at `.github/workflows/release.yml`.

- **Trigger:** `push` on tags matching `v*.*.*`.
- **Steps:**
    1. Checkout at the tag.
    2. Assert `jq -r .version .claude-plugin/plugin.json` equals
       `${GITHUB_REF_NAME#v}`. Hard fail on mismatch — this is the
       belt-and-braces check on `just release`.
    3. Run `just check-versions`.
    4. Run `just package` to build `dist/bfw-brainstorm-vX.Y.Z.skill`.
    5. Extract the `## vX.Y.Z` section from CHANGELOG.md (everything
       between that heading and the next `##`-level heading).
    6. `gh release create "$GITHUB_REF_NAME" --notes-file <extracted>
       dist/bfw-brainstorm-v*.skill` — the `.skill` is uploaded as a
       release asset in the same call.
- **Rationale:** makes releases visible on GitHub without forcing the
  maintainer to author release notes twice, AND produces the
  `.skill` artefact that the Claude Desktop / claude.ai install
  channel depends on. CHANGELOG stays the source of truth; the
  GitHub Release is generated from it.
- **Failure modes handled:**
  - CHANGELOG section missing → hard fail, surfaces the omission
    loudly instead of shipping an empty release.
  - Tag → manifest version mismatch → hard fail, this is the
    scenario that would silently break the plugin cache.
  - `just package` failure (e.g. malformed SKILL.md frontmatter or
    missing `zip`/`jq` tool) → stops before `gh release create` so
    no partial release is published.

### 3. `schema.yml` — plugin manifest validation (stretch)

- **Trigger:** `pull_request` touching `.claude-plugin/**`.
- **Steps:** validate `plugin.json` and `marketplace.json` against
  Claude Code's published JSON schemas (if/when they're published).
- **Rationale:** today the `jq`-based bump trusts that no one
  hand-edited the manifest into an invalid state. A schema check
  would make the whole release path safe to run from CI directly,
  which opens up the option of a fully automated release workflow
  (see next section).

## Possible future: fully automated release from CI

Once `lint.yml` + `release.yml` are in place, the next step is a
`release-dispatch.yml` workflow that:

1. Is triggered via `workflow_dispatch` with a `version` input.
2. Runs `just release $version` inside the runner.
3. Pushes the resulting commit and tag with a PAT that has `contents:
   write`.
4. Chains into `release.yml` via the tag push.

This is explicitly a **later** concern. Reasons it's not urgent:

- `just release` already runs in <2 seconds locally.
- A human-in-the-loop release is still valuable at current scale
  (one maintainer, low release frequency).
- Automating before the PR-time guardrails exist would just move the
  failure modes into CI logs.

Revisit when either (a) releases become frequent enough that the
manual steps are friction, or (b) a second maintainer joins and
consistent tooling matters more than individual local setups.

## Non-goals for CI

- **Running tests** — there are none, and the skill's correctness is
  qualitative (does it facilitate a good brainstorm?), not something
  unit tests would catch.
- **Building** — no build step exists; skill files ship as-is.
- **Publishing to a package registry** — distribution is GitHub-only
  (plugin marketplace reads the repo; `npx skills` clones the repo).
  Nothing to publish.
