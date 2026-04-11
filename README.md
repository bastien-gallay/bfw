# bfw — Brainstorming Framework

A **facilitated ideation skill** for Claude Code (and compatible AI
coding assistants). Drives structured brainstorming sessions from raw
ideas through crystallised decisions, using classical techniques
(Six Hats, SCAMPER, MoSCoW, Impact/Effort, First Principles, and more)
with adaptive sequencing.

## Why

Most AI brainstorming sessions drift: you start with a question, dump
some ideas, the AI agrees with everything, and you end with a longer
list of unordered thoughts. `bfw` treats the AI as a **facilitator,
not a participant** — it drives a structured process, keeps energy
high, detects convergence or stuck signals, and adapts the plan
mid-session.

The key design decisions:

- **Announce + adapt without asking permission.** A good facilitator
  changes course when the room shifts. Constantly asking "is that OK?"
  breaks trust and flow.
- **Problem shape detection.** The same generic "brainstorm" template
  doesn't fit a blank-slate question and a 30-item backlog. `bfw`
  classifies the input into 5 shapes and picks a recipe accordingly.
- **Meta-analysis is first-class.** Every session ends with "what
  worked, what didn't, what to try next time" — feeding back into the
  technique library for continuous improvement.
- **Encouraging but honest.** The facilitator celebrates good thinking,
  but emits unprompted criticism when it spots blind spots, missing
  constraints, or unchallenged assumptions.

## What's in the box

```text
bfw/
├── .claude-plugin/
│   ├── plugin.json              # Claude Code plugin manifest
│   └── marketplace.json         # Single-plugin marketplace catalog
├── skills/
│   └── brainstorm/
│       ├── SKILL.md             # The main skill prompt — the brain
│       └── techniques.md        # Technique library (20 techniques, 5 phases)
├── README.md                    # This file
├── CHANGELOG.md
├── CLAUDE.md                    # Orientation for Claude Code sessions
├── LICENSE                      # MIT
├── justfile                     # Release automation
└── examples/                    # Real session outputs
    └── site-ideas-prioritization.md
```

## Installation

`bfw` ships on two parallel install channels from the same repo, so
you can use it whether your assistant speaks Claude Code plugins or
the cross-host `skills` CLI.

### Claude Code (recommended)

```bash
/plugin marketplace add bastiengallay/bfw
/plugin install bfw@bfw
```

This installs the `bfw` plugin from its own marketplace and exposes
the `brainstorm` skill. Claude can invoke it automatically from the
description, or you can call it explicitly via `/bfw:brainstorm`.
Claude Code auto-updates the plugin at session start.

### Everywhere else (45+ hosts via `skills`)

```bash
npx skills add bastiengallay/bfw
```

Works in Cursor, Codex, Cline, Continue, Copilot, Windsurf, Warp,
Gemini CLI, Roo Code, and [dozens more](https://github.com/vercel-labs/skills).
Run `npx skills update` periodically to pull the latest version —
unlike the Claude Code plugin path, updates here are manual.

### Manual / other hosts

`bfw` is just two markdown files under `skills/brainstorm/`. Any
assistant that can load a system prompt or skill file can use it —
point it at `skills/brainstorm/SKILL.md` (and keep `techniques.md`
next to it).

## Usage

```bash
/brainstorm TOPIC="Should we rewrite the legacy API?" DURATION=15
```

```bash
/brainstorm \
  TOPIC="Q3 product priorities" \
  IDEAS="AI search, mobile app, API v2, dashboard redesign" \
  DURATION=25
```

**What happens:**

1. **Intake** — extends your ideas, adds 2-4 AI suggestions, asks for
   constraints
2. **Shape** — detects whether you have too few / too many ideas, a
   binary choice, or decision under constraints
3. **Plan** — announces a technique sequence (Six Hats, MoSCoW,
   Impact/Effort, etc.) with estimated times
4. **Execute** — runs each technique, presents results, collects
   feedback (closed + open questions)
5. **Reflect** — after each step, adapts the plan if the session
   signals convergence / stuck / new dimension
6. **Crystallise** — selects final ideas with rationale, generates
   action items
7. **Meta-analysis** — records what worked for future improvement

Sessions are persisted as markdown under the configured output
directory (default: `brainstorm/YYYYMMDD-<slug>.md`).

## Problem shapes and default recipes

| Input shape | Trigger | Recipe |
| --- | --- | --- |
| **Blank slate** | 0-2 ideas | Starbursting → Free Association → Affinity Group → NUF → Action Items |
| **Few ideas** | 3-7 ideas | SCAMPER → Six Hats (top 3-4) → Impact/Effort → Action Items |
| **Many ideas** | 8+ ideas | Affinity Group → Six Hats (per group) → MoSCoW → Action Items |
| **Large backlog** | 15+ ideas | Affinity → Dot Vote (cluster) → Impact/Effort (filtered) → MoSCoW |
| **Binary choice** | Exactly 2 ideas | PCI → Devil's Advocate → Binary Comparison |
| **Decision under constraints** | Constraints mentioned | Constraint Mapping → Reverse Brainstorm → Decision Matrix |

Recipes can always be overridden with `TECHNIQUES="six-hats,moscow"`.

## Technique library

20 techniques across 5 phases. See
[skills/brainstorm/techniques.md](skills/brainstorm/techniques.md) for
the full reference.

**Diverge** — Starbursting, SCAMPER, Reverse Brainstorm, What-Would-X-Do,
Random Stimulus, Free Association
**Analyze** — Six Thinking Hats, First Principles, 5 Whys, SWOT, PCI
**Converge** — MoSCoW, Impact/Effort Matrix, NUF Test, Decision Matrix,
Binary Comparison, Dot Voting
**Crystallize** — Action Items, Elevator Pitch
**Adaptive** — Affinity Grouping, Devil's Advocate, Constraint Mapping

## Customization

Add your own techniques by editing `techniques.md`. Each entry is a
markdown section with:

- **Purpose** — what it's for
- **When** — when to use it
- **How** — step-by-step instructions for the AI facilitator
- **Duration** — typical time budget
- **Output shape** — what the result looks like

The skill reads `techniques.md` at session start, so new techniques are
available immediately.

## Session output example

See [examples/site-ideas-prioritization.md](examples/site-ideas-prioritization.md)
for a real session that prioritised 30 ideas for a documentation site
into a Must/Should/Could/Won't plan, with meta-analysis.

## Design philosophy

Four principles drove the design:

1. **Structure beats freeform for AI brainstorming.** LLMs are too
   agreeable on their own. Imposing a process forces real analysis.
2. **Adaptation beats rigid plans.** The best facilitators change
   course when the room shifts. The framework detects and announces
   changes transparently.
3. **Double Diamond over single-pass.** Every session alternates
   divergence (opening) and convergence (closing), mirroring the
   classic design-thinking pattern.
4. **Meta-analysis is the moat.** Recording what worked turns every
   session into a data point for improving the next one.

## License

MIT — see [LICENSE](LICENSE).

## Credits

Created by Bastien Gallay. Contributions welcome.
