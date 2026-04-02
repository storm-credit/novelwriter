---
id: q_{name}
title: Open Question — {brief description}
entity_type: open_question
project_id: chronicle_example
canon_status: official
scope: project_only
source_priority: 2
status: active

question_type: design_decision
urgency: medium
domain: canon
blocking: false
discovered_date: 2026-04-02
last_reviewed: 2026-04-02
reviewed_by: author
target_resolution_by:

related_entities:
  - {affected note id}
  - {affected note id}

resolution_status: open
resolution_date:
resolution_note_id:

tags:
  - open_question
  - design_decision
---

# Open Question — {brief description}

## Question

State the unresolved question as precisely as possible in one or two sentences.

> Example: When exactly does Lyra first hear the sound distortion that signals Stage 1 dissolution? Is it before or after the confrontation in ep_041?

---

## Classification

| Field | Value |
|-------|-------|
| Question type | `design_decision` / `canon_gap` / `rule_clarification` / `timeline_ambiguity` / `character_motivation` / `structural_choice` |
| Urgency | `critical` / `high` / `medium` / `low` |
| Domain | `canon` / `structure` / `character` / `timeline` / `world` / `rule` |
| Is it blocking? | Yes / No |
| Blocks which task? | {task or episode id} |

---

## Why This Matters

Explain why this question needs to be answered and what breaks if it is left unresolved.

### If answered early

What does an early answer enable?

### If left too long

What problems could emerge?

---

## Current Best Guess

What is the working assumption or most likely answer right now?

> Example: Current assumption is Stage 1 onset occurs slightly before the confrontation scene, which is why Lyra's perception feels slightly off during the conversation.

Confidence: high / medium / low

---

## Available Evidence

### Explicit canon evidence

List any official notes that bear on this question.

| Note ID | Relevant Content |
|---------|-----------------|
| `rule_example.md` | |
| `char_example.md` | |
| `event_example.md` | |

### Implicit evidence

Logical inferences from established canon that point toward an answer.

- If X is true, then Y follows, which suggests Z.
- The timeline implies A came before B.

### Conflicting signals

Any evidence that points in opposite directions.

---

## Options Under Consideration

### Option A

**Statement:** [Describe option A]

**Advantages:**
-

**Disadvantages:**
-

**Narrative impact:**
-

---

### Option B

**Statement:** [Describe option B]

**Advantages:**
-

**Disadvantages:**
-

**Narrative impact:**
-

---

### Option C (if applicable)

**Statement:** [Describe option C]

**Advantages:**
-

**Disadvantages:**
-

**Narrative impact:**
-

---

## Recommended Option

Which option currently looks most viable and why?

Option: A / B / C / undecided

Reason:

---

## Constraints on the Answer

### Hard constraints

What must remain true regardless of how this question is answered?

- Must not contradict `rule_{name}.md`
- Must not contradict the timeline established in `event_{name}.md`

### Soft constraints

What would be strongly preferred in the answer?

- Ideally consistent with the protagonist's arc in Arc 2
- Ideally allows the reveal in ep_050 to remain intact

---

## Required Actions Before Resolution

- [ ] Review `rule_{name}.md` for relevant constraints
- [ ] Check `ep_{NNN}` timeline for consistency implications
- [ ] Consult Story Architect or Plot Designer if structural impact
- [ ] Ask Canon Auditor if new canon candidate emerges

---

## Escalation Trigger

If this question cannot be resolved by the author alone, escalate to:

- [ ] Story Architect — if structural impact
- [ ] Canon Governance Manager — if new rule or canon entity must be created
- [ ] Plot Designer — if event sequence must change
- [ ] Character Arc Designer — if character arc is affected

---

## Resolution

Once resolved, fill in this section.

### Answer

What was decided?

### Reasoning

Why was this the answer?

### Canon impact

What notes must be created or updated as a result?

| Action | Note ID | Change |
|--------|---------|--------|
| Create | | |
| Update | | |
| Deprecate | | |

### Resulting new canon candidate

If the answer introduces new canon, tag it for review:

- [ ] `new_canon_candidate` tag added
- [ ] Canon Auditor notified
- [ ] Note promotion path started

---

## Changelog

- {date}: Question identified by {agent/author}
- {date}: Options added
- {date}: Resolved — chosen option: {A/B/C}
