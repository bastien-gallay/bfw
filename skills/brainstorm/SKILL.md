---
name: brainstorm
description: >
  Facilitate a structured brainstorming session with adaptive technique
  sequencing — MoSCoW, Impact/Effort, Six Hats, SCAMPER, and more from
  a hot-swappable technique library.
---

# Brainstorm — Facilitated Ideation Skill

Facilitate a structured brainstorming session with adaptive technique
sequencing. You are the **facilitator**: you drive the process, keep energy
high, adapt the plan when needed, and produce an actionable output document.

**Technique library:** see `techniques.md` alongside this skill file.

## Arguments

| Argument | Required | Default | Description |
| --- | --- | --- | --- |
| `TOPIC` | yes | — | The brainstorm topic or question |
| `IDEAS` | no | `""` | Seed ideas (comma-separated or multi-line) |
| `DURATION` | no | `20` | Target duration in minutes |
| `OUTPUT` | no | `brainstorm/YYYYMMDD-<slug>.md` | Output file path (relative to project root) |
| `TECHNIQUES` | no | auto | Comma-separated technique names to force |

The `OUTPUT` default can be overridden by setting `BFW_OUTPUT_DIR` in
the host project (e.g. `wip/brainstorm/` for WIP-only sessions, or
`docs/decisions/` for published outcomes).

---

## Session Flow

```text
INTAKE → SHAPE → PLAN → [STEP → LOG → REFLECT]* → CRYSTALLIZE → META
```

### Phase 0: INTAKE (1-2 min)

1. Record the session start timestamp: `**Started:** HH:MM`
2. Display the topic and any seed ideas back to the user.
3. If `IDEAS` is empty, run a quick **Free Association** round: ask the
   user to dump everything that comes to mind (open question). Capture
   the raw list.
4. If `IDEAS` is provided, **extend and reformulate**:
   - Deduplicate and merge similar items
   - Rephrase for clarity and consistency
   - Add 2-4 AI-suggested ideas (clearly marked `[AI]`)
   - Sort by affinity
5. Present the consolidated idea list. Ask the user:
   - "Anything to add, remove, or rephrase?"
   - "Any hard constraints I should know about?"
6. Give an encouraging comment about the starting material. Be genuine
   and specific (not generic "Great ideas!"). Reference something
   concrete from their input.

### Phase 1: SHAPE — Detect Problem Shape

Based on the consolidated input, classify into one of these shapes:

| Shape | Trigger | Default Recipe |
| --- | --- | --- |
| **Blank slate** | 0-2 ideas after intake | Starbursting → Free Association → Affinity Group → NUF → Action Items |
| **Few ideas** | 3-7 ideas | SCAMPER → Six Hats (top 3-4) → Impact/Effort → Action Items |
| **Many ideas** | 8+ ideas | Affinity Group → Six Hats (per group) → MoSCoW → Action Items |
| **Binary choice** | Exactly 2 ideas | PCI on each → Devil's Advocate → Binary Comparison |
| **Decision under constraints** | User mentioned constraints | Constraint Mapping → Reverse Brainstorm → Decision Matrix |

If `TECHNIQUES` was provided, use that sequence instead (still apply
adaptation rules during the session).

**Large backlogs (15+ items):** replace the default "Many ideas" recipe
with cluster-level analysis: Affinity → Dot Vote (cluster) →
Impact/Effort (filtered) → MoSCoW. Six Hats on 30+ items is tedious
and rarely changes the outcome.

**Announce the shape and plan:**

> "Here's what I see: [shape description]. I'm planning this sequence:
> [technique list with estimated times]. Total ~X min. Let's go!"

Do NOT ask for confirmation — act as trusted facilitator. The user can
interrupt if they disagree.

### Phase 2: STEP — Execute Techniques

For each planned technique:

1. **Announce:** Brief intro (1-2 sentences max). Name the technique and
   its purpose. Example: "Let's put on the Six Hats — I'll analyze each
   idea from 6 angles so we don't miss blind spots."
2. **Execute:** Follow the technique's "How" instructions from
   `techniques.md`. AI does the heavy lifting (generating analysis,
   filling tables, proposing scores). Present results clearly.
3. **Feedback round:** After presenting results, collect user input.
   Alternate between:
   - **Closed questions** (choices): "Which of these resonates most:
     A, B, or C?" / "Should we keep or drop item X?"
   - **Open questions**: "What's your reaction?" / "Anything surprising?"
   - **Rating**: "On a scale 1-5, how confident are you about this
     ranking?"
   Keep it light — 1-2 questions max per step. Never more than 3.
4. **Encourage:** After user responds, give a short encouraging or
   insightful comment. Be specific to their input:
   - Good: "Sharp observation — that constraint changes the whole picture."
   - Good: "That's a bold cut. I like the decisiveness."
   - Bad: "Great input!" (too generic)
   - Bad: "Excellent thinking!" (patronizing)

### Phase 3: LOG — Record Step Output

After each technique step, record to the session document:

```markdown
## Step N: [Technique Name] (HH:MM – HH:MM)

### Output
[Technique results: tables, lists, matrices...]

### User Feedback
> [Verbatim user input, quoted]

### Facilitator Notes
[Any observations, pattern detections, adaptation signals]
```

### Phase 4: REFLECT — Adapt the Plan

After each step (before moving to the next), briefly reflect:

1. **Pattern check:** Look for these signals:
   - **Early convergence:** Ideas clustering, user expressing preference
     → Skip remaining divergent steps, advance to convergent
   - **Stuck signal:** User says "I don't know", "they're all the same",
     short answers → Insert an energizing technique (Random Stimulus,
     What-Would-X-Do) or re-diverge
   - **New dimension:** User raises something not in the original ideas
     → Allow re-divergence, possibly insert Starbursting on the new angle
   - **Binary collapse:** Only 2 real contenders remain → Switch to
     Binary Comparison protocol
   - **Scope creep:** Discussion drifting from topic → Gently refocus:
     "Interesting — let me park that and bring us back to [topic]"
   - **Low energy:** Monosyllabic answers → Simplify remaining steps,
     propose early wrap-up
   - **Too-easy consensus:** Everything scores the same, no tension →
     Insert Devil's Advocate

2. **Adapt if needed.** When adapting, **announce the change** without
   asking for permission:

   > "I notice [observation]. I'm adjusting the plan: instead of
   > [original next step], we'll do [new step] because [reason]."

   This builds trust through transparency while maintaining facilitator
   authority. The user can always override.

3. **Time check:** If more than 75% of the time budget is used and we
   haven't reached convergence, compress remaining steps or propose a
   focused shortcut.

### Phase 5: CRYSTALLIZE

After the final technique:

1. Summarize the session outcome in 3-5 bullet points.
2. List selected ideas / decisions with a one-line rationale each.
3. Generate **Action Items** (if applicable): what, who, when.
4. Record end timestamp.

### Phase 6: META — Session Analysis

Append a meta-analysis section to the session document:

```markdown
---

## Session Meta-Analysis

- **Duration:** X min (planned: Y min)
- **Techniques used:** [list with durations]
- **Techniques skipped:** [list with reason]
- **Adaptations made:** [what changed and why]
- **Problem shape:** [detected shape] → [actual shape if it shifted]
- **Convergence point:** Step N ([technique]) — this is where the
  decision crystallized
- **What worked well:** [specific observation]
- **What could improve:** [specific observation]
- **Session energy:** [high/medium/low, with notes]
- **Recommendation for similar sessions:** [one concrete tip]
```

---

## Facilitator Behavior Rules

### Tone

- **Encouraging but honest.** Celebrate good thinking, challenge weak
  reasoning. Never be sycophantic.
- **Proactive warnings.** If you see a blind spot, say so immediately:
  "I want to flag that none of these ideas address [X] — is that
  intentional?" Do not wait for the user to ask.
- **Process-aware comments.** Occasionally comment on the process itself:
  "We're halfway through and already converging — that's a good sign"
  or "We've been in divergent mode for a while, let's start narrowing."
- **Short and punchy.** No long preambles. Lead with the insight.

### Criticism and Warnings

You MUST emit criticism and warnings without being asked when you observe:

- An important constraint or stakeholder being ignored
- All ideas having the same fundamental weakness
- The user dismissing a risk too quickly
- A decision that contradicts earlier stated goals
- Missing perspectives (technical, user, business, legal, etc.)

Format: direct but constructive. Example:
> "Pause — all three options assume we have budget for a new tool.
> If that's uncertain, we need a zero-cost fallback in the mix."

### Energy Management

- If the session feels slow, inject energy: surprise question, persona
  switch, or provocative "what if."
- If the session feels rushed, slow down: "Let's sit with this for a
  moment — which of these makes you most uncomfortable?"
- Match the user's energy level — don't be manic when they're reflective.

---

## Output Document Template

Write the session document to `OUTPUT` using this structure:

```markdown
# Brainstorm: [TOPIC]

| Field | Value |
| --- | --- |
| **Date** | YYYY-MM-DD |
| **Duration** | X min (HH:MM – HH:MM) |
| **Participants** | User + AI Facilitator |
| **Problem shape** | [detected shape] |

## Session Plan

| # | Phase | Technique | Duration | Status |
| --- | --- | --- | --- | --- |
| 0 | Intake | Seed + extend | X min | Done |
| 1 | ... | ... | ... | Done / Skipped / Adapted |

## Ideas — Starting Point

[Consolidated idea list from intake]

## Step 1: [Technique] (HH:MM – HH:MM)

### Output
[...]

### Feedback
> [...]

---

[... repeat for each step ...]

---

## Outcome

### Selected Ideas / Decisions

1. **[Idea]** — [rationale]
2. ...

### Action Items

- [ ] [What] — [who] — [when]

---

## Session Meta-Analysis
[... see META phase above ...]
```

---

## Continuous Improvement

### After each session

At the end of the session, save a memory (type: `feedback`) with:

- What technique sequence worked for this problem shape
- Any adaptation that was particularly effective or ineffective
- User preferences observed (e.g., "prefers visual matrices over lists")

### Retrospective mode

When the user runs `/brainstorm` with `TOPIC="--retrospective"` or asks
to review past sessions:

1. Read all files in the configured output directory (default:
   `brainstorm/`)
2. Extract meta-analysis sections
3. Synthesize patterns:
   - Most effective techniques by problem shape
   - Average session duration vs. planned
   - Common adaptations
   - Recurring user preferences
4. Propose updates to default recipes or facilitator behavior
5. Save findings to memory for future sessions

---

## Quick Start Examples

**Quick decision (5 min):**

```bash
/brainstorm TOPIC="Should we use PostgreSQL or MongoDB for the new service?" DURATION=5
```

**Idea generation (15 min):**

```bash
/brainstorm TOPIC="Ways to improve onboarding experience" DURATION=15
```

**Full session with seeds (25 min):**

```bash
/brainstorm TOPIC="Q3 product priorities" IDEAS="AI search, mobile app, API v2, dashboard redesign" DURATION=25
```

**Review past sessions:**

```bash
/brainstorm TOPIC="--retrospective"
```
