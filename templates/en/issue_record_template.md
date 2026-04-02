---
id: iss_{ep}_{NNN}
title: Issue — {brief description}
entity_type: issue_record
project_id: chronicle_example
canon_status: official
scope: project_only
source_priority: 2
status: open

issue_type: canon_contradiction
severity: major
domain: audit
episode_ref: ep_{NNN}
scene_ref: scene_{NNN}_{NN}
discovered_by: canon_auditor
discovered_date: 2026-04-02
last_reviewed: 2026-04-02
reviewed_by: author

related_entities:
  - char_example
  - rule_example
  - ep_example

resolution_status: open
resolved_date:
resolved_by:
fix_note_id:

tags:
  - issue
  - canon_contradiction
---

# Issue — {brief description}

## Issue Statement

One-sentence description of what is wrong and where.

> Example: In ep_041, Lyra uses Seal III despite Rule note `rule_seal_binding_limit` stating Seal III requires prior activation of Seal II, which has not occurred.

---

## Classification

| Field | Value |
|-------|-------|
| Issue type | `canon_contradiction` / `motivation_gap` / `timeline_break` / `causality_failure` / `voice_deviation` / `structural_weakness` / `continuity_error` |
| Severity | `critical` / `major` / `minor` / `info` |
| Domain | `canon` / `timeline` / `motivation` / `structure` / `voice` / `pacing` |
| Hard gate trigger? | Yes / No |
| Blocking? | Yes / No |

---

## Evidence

### Primary Evidence

Direct quote or reference from the draft that demonstrates the issue.

```
[draft excerpt or scene reference]
```

Source: `scene_{NNN}_{NN}`, line ~{N}

---

### Conflicting Canon

Which official note(s) does this contradict?

| Note ID | Field / Section | Canon Value |
|---------|----------------|-------------|
| `rule_example` | Activation Conditions | Seal III requires prior Seal II activation |
| `char_example` | Abilities — Current State | Seal II not yet activated at this point |

---

### Supporting Facts

Facts established by canon that are directly relevant to this issue.

- Fact 1: [citation from official note]
- Fact 2: [citation from official note]
- Fact 3: [citation from official note]

---

### Inferences Made

Judgments made by the auditor that are not directly stated but are logically derived.

- Inference 1: If X is true, then Y should follow.
- Inference 2: The timeline implies Z.

Confidence: high / medium / low

---

## Impact Assessment

### Immediate Impact

What does this issue break right now in the current episode or scene?

### Downstream Impact

What future episodes, events, or character arcs could be affected if this is not fixed?

- [ ] Episode {NNN}: [reason]
- [ ] Arc {name}: [reason]
- [ ] Character {name}: [reason]

---

## Fix Recommendations

### Option A — Minimal Fix

What is the smallest change that resolves this issue?

Scope: [word count / scene count / note count]
Risk: low / medium / high

### Option B — Structural Fix

If a deeper change is needed, what would it involve?

Scope: [word count / scene count / note count]
Risk: low / medium / high

### Option C — Accept and Document

Is there a narrative justification that allows this to stand as-is?

Condition: [what must be true for this to be acceptable]

---

## Recommended Action

```
[ ] Fix in current draft before continuing
[ ] Fix in revision pass
[ ] Create bridge scene
[ ] Update canon note
[ ] Create new canon candidate
[ ] Defer — low impact
[ ] Accept with documentation
[ ] Escalate to author
```

---

## Regression Targets

If this issue is fixed, which notes or episodes need re-audit?

- [ ] `ep_{NNN}` — reason
- [ ] `char_{name}` — reason
- [ ] `rule_{name}` — reason

---

## Resolution Log

Once resolved, record the outcome here.

### Resolution Summary

What was done to fix this issue?

### Fix Applied To

- `scene_{NNN}_{NN}` — change made
- `rule_{name}` — update made

### Verification

How was the fix confirmed to be correct?

- [ ] Canon re-audit passed
- [ ] Motivation re-check passed
- [ ] Downstream episodes checked

---

## Changelog

- {date}: Issue created by {agent/author}
- {date}: Status changed to proposed_fix
- {date}: Fix applied, status changed to resolved
