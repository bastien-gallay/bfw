# Brainstorm Technique Library

Reference for the brainstorm skill. Each technique has: purpose, when to
use it, how to run it (AI facilitator instructions), and typical duration.

---

## Diverge — Generate and Expand

### Starbursting

- **Purpose:** Generate questions, not answers. Opens exploration space.
- **When:** Blank slate, poorly defined problem, need to discover unknowns.
- **How:** Build a 5W1H star (Who / What / Where / When / Why / How) around
  the topic. AI generates 3-5 questions per branch. User adds, removes, or
  rephrases. Output is a prioritized question list.
- **Duration:** 3-5 min
- **Output shape:** Bulleted question list grouped by W/H category.

### SCAMPER

- **Purpose:** Systematically mutate existing ideas to generate variants.
- **When:** Few ideas that need enrichment, or existing solution needs
  creative alternatives.
- **How:** Apply each lens to the current idea set:
  - **S**ubstitute — What component could be replaced?
  - **C**ombine — What ideas could merge?
  - **A**dapt — What similar solution exists elsewhere?
  - **M**odify / Magnify / Minimize — What if we scaled it up/down?
  - **P**ut to other use — What else could this serve?
  - **E**liminate — What's unnecessary?
  - **R**everse / Rearrange — What if we flipped the order?
  AI applies each lens, proposes 1-2 variants per lens, user reacts.
- **Duration:** 5-8 min
- **Output shape:** Table with columns: Lens | Original idea | Variant.

### Reverse Brainstorm

- **Purpose:** Find solutions by first imagining how to *cause* the problem.
- **When:** Stuck on a hard problem, need fresh angle, defensive thinking.
- **How:** Flip the goal ("How could we make this *worse*?"). List ways to
  fail, then invert each into a solution or safeguard.
- **Duration:** 3-5 min
- **Output shape:** Two-column table: "How to fail" | "Inverted solution".

### What-Would-X-Do

- **Purpose:** Borrow thinking patterns from known figures or domains.
- **When:** Need creative cross-pollination, stuck in domain thinking.
- **How:** AI picks 2-3 contrasting perspectives (e.g., "a startup founder",
  "a risk-averse regulator", "an end-user who hates complexity"). For each,
  generate 1-2 ideas or critiques. User can suggest personas too.
- **Duration:** 3-4 min
- **Output shape:** Grouped by persona, 1-2 bullet points each.

### Random Stimulus

- **Purpose:** Force unexpected connections through random input.
- **When:** Circular thinking, all ideas feel too similar.
- **How:** AI introduces a random concept, word, or constraint (e.g., "What
  if this had to work offline?", "What if the budget was 10x?"). User
  free-associates from the stimulus.
- **Duration:** 2-3 min
- **Output shape:** Stimulus → association chain → resulting idea.

### Free Association / Brain Dump

- **Purpose:** Capture everything without filtering.
- **When:** Session start, clearing mental cache, raw input needed.
- **How:** User lists everything that comes to mind. AI captures, does not
  judge. Optional: AI groups by affinity at the end.
- **Duration:** 2-4 min
- **Output shape:** Raw bullet list, optionally grouped.

---

## Analyze — Understand and Challenge

### Six Thinking Hats (de Bono)

- **Purpose:** Systematic multi-perspective analysis of each idea.
- **When:** Need balanced evaluation, avoid groupthink, ideas need stress
  testing.
- **How:** For each idea (or the top N), apply all six hats:
  - White — Facts and data: what do we know?
  - Red — Feelings and intuition: gut reaction?
  - Yellow — Benefits and value: what's the upside?
  - Black — Risks and caution: what could go wrong?
  - Green — Creativity: how could we improve this?
  - Blue — Process: what's the next step for this idea?
  AI fills each hat, user reacts and adjusts. For large idea lists, apply
  to top 3-5 only.
- **Duration:** 5-10 min (depends on idea count)
- **Output shape:** Table per idea with one row per hat.

### First Principles

- **Purpose:** Strip assumptions, rebuild from fundamentals.
- **When:** Challenging "we've always done it this way", complex problems
  with hidden assumptions.
- **How:** Three steps:
  1. State the current assumption/approach
  2. Break it down: what are the fundamental truths?
  3. Rebuild: what solution follows from the fundamentals alone?
  AI guides the decomposition, user validates each fundamental.
- **Duration:** 4-6 min
- **Output shape:** Assumption → Fundamentals list → Rebuilt solution.

### 5 Whys

- **Purpose:** Drill to root cause.
- **When:** Problem is unclear, surface symptoms mask deeper issues.
- **How:** Start with the problem statement. AI asks "Why?" iteratively
  (up to 5 times). Each answer becomes the next input. Stop when a
  root cause is actionable.
- **Duration:** 3-5 min
- **Output shape:** Chain: Problem → Why1 → Why2 → ... → Root cause.

### SWOT (per idea)

- **Purpose:** Structured strength/weakness assessment.
- **When:** Comparing 2-4 concrete options, need balanced view.
- **How:** For each option, fill the 2x2: Strengths, Weaknesses,
  Opportunities, Threats. AI proposes, user adjusts.
- **Duration:** 3-5 min per option
- **Output shape:** 2x2 table per option.

### PCI — Pros, Cons, Interesting

- **Purpose:** Quick balanced assessment lighter than SWOT.
- **When:** Fast evaluation, many ideas to scan, or as a warm-up before
  deeper analysis.
- **How:** Three columns per idea. "Interesting" captures neutral
  observations that could go either way.
- **Duration:** 2-3 min per idea
- **Output shape:** Three-column table.

---

## Converge — Prioritize and Select

### MoSCoW

- **Purpose:** Prioritize by necessity.
- **When:** Feature lists, requirement sorting, scope decisions.
- **How:** Classify each item:
  - **Must** — Non-negotiable, core
  - **Should** — Important but not blocking
  - **Could** — Nice-to-have
  - **Won't** — Explicitly out of scope (this round)
  AI proposes classification, user confirms/moves items.
- **Duration:** 3-5 min
- **Output shape:** Four groups with items listed under each.

### Impact / Effort Matrix

- **Purpose:** Visual prioritization on two axes.
- **When:** Need to find quick wins and deprioritize time sinks.
- **How:** Rate each idea on Impact (Low/Med/High) and Effort
  (Low/Med/High). Plot in a 2x2 or 3x3 grid. Quadrant labels:
  Quick Wins (high impact, low effort), Big Bets, Fill-ins, Avoid.
- **Duration:** 3-5 min
- **Output shape:** Grid or table with I/E ratings per idea.

### NUF Test — New, Useful, Feasible

- **Purpose:** Quick three-criteria scoring.
- **When:** Large idea list needs fast filtering, or as a complement to
  other convergent techniques.
- **How:** Score each idea 1-5 on New, Useful, Feasible. Sum = priority.
  AI proposes scores, user adjusts.
- **Duration:** 2-4 min
- **Output shape:** Table: Idea | N | U | F | Total, sorted by total.

### Decision Matrix (Weighted Criteria)

- **Purpose:** Rigorous multi-criteria comparison.
- **When:** High-stakes decision, multiple important criteria, need
  defensible justification.
- **How:**
  1. Define criteria (3-5 max)
  2. Assign weights (must sum to 100%)
  3. Score each option 1-5 per criterion
  4. Compute weighted totals
  AI proposes criteria and weights, user adjusts before scoring.
- **Duration:** 5-8 min
- **Output shape:** Weighted matrix table with totals.

### Binary Comparison

- **Purpose:** Direct head-to-head when exactly 2 options remain.
- **When:** Convergence has narrowed to 2 finalists.
- **How:** Side-by-side on 3-5 key dimensions. AI highlights the
  differentiators. Ask user: "If you had to commit right now, which
  one and why?"
- **Duration:** 2-3 min
- **Output shape:** Side-by-side comparison table + user's call.

### Dot Voting (Simulated)

- **Purpose:** Quick democratic ranking.
- **When:** Many options, need a fast filter, or as a warm-up before
  detailed analysis.
- **How:** User gets N dots (typically N = item_count / 3, min 3).
  Allocate dots to favorite items. AI tallies. Can also do negative
  dots ("which would you eliminate?").
- **Duration:** 1-2 min
- **Output shape:** Items sorted by vote count.

---

## Crystallize — Commit and Plan

### Action Items

- **Purpose:** Convert decisions into executable steps.
- **When:** End of session, after selection is made.
- **How:** For each selected idea/decision, define:
  - What exactly needs to happen (concrete next step)
  - Who does it (if applicable)
  - By when (if applicable)
  - Dependencies or blockers
- **Duration:** 2-3 min
- **Output shape:** Checklist with owner and deadline columns.

### Elevator Pitch

- **Purpose:** Crystallize the selected idea into a compelling one-liner.
- **When:** Need to communicate the decision to others, or test clarity.
- **How:** AI drafts a 1-2 sentence pitch. User refines until it feels
  right. Format: "We will [action] for [audience] by [method] because
  [reason]."
- **Duration:** 1-2 min
- **Output shape:** Single polished statement.

---

## Special — Adaptive Techniques

### Affinity Grouping

- **Purpose:** Find natural clusters in a messy idea list.
- **When:** Many items (>8) that likely overlap, need structure before
  analysis.
- **How:** AI proposes groups based on semantic similarity. User adjusts
  groupings and names the clusters. Can merge or split groups.
- **Duration:** 2-4 min
- **Output shape:** Named groups with items listed under each.
- **Phase:** Can be used as diverge (discover structure) or converge
  (reduce redundancy).

### Devil's Advocate

- **Purpose:** Stress-test a decision that feels too easy.
- **When:** Group is converging too fast, need to check for blind spots.
- **How:** AI argues *against* the current frontrunner. Raises the
  strongest possible objections. User defends or adjusts.
- **Duration:** 2-3 min
- **Output shape:** Objection list + user responses.

### Constraint Mapping

- **Purpose:** Surface hidden constraints before diverging.
- **When:** Decision under constraints, or when ideas keep hitting the
  same wall.
- **How:** List all constraints (technical, budget, time, political,
  skills). Classify as Hard (non-negotiable) vs. Soft (could change).
  AI proposes, user validates.
- **Duration:** 2-3 min
- **Output shape:** Two-column table: Hard constraints | Soft constraints.
