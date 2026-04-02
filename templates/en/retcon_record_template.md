---
id: retcon_{name}
title: Retcon — {brief description}
entity_type: retcon_record
project_id: chronicle_example
canon_status: official
scope: project_only
source_priority: 1
status: active

retcon_type: narrative_change
severity: major
discovered_date: 2026-04-02
approved_date:
approved_by: author
last_reviewed: 2026-04-02
reviewed_by: author

original_note_id: {original note id}
replacement_note_id: {new note id}
retcon_reason: {brief reason}

related_entities:
  - {original note id}
  - {replacement note id}
  - {affected episode id}

tags:
  - retcon
  - canon_change
---

# Retcon — {brief description}

## Purpose

This note documents a deliberate retroactive change to previously established canon.

It exists to:
- preserve the history of what was true before
- explain why the change was made
- list what must be revised as a result
- ensure the change does not create downstream contradictions

---

## Retcon Classification

| Field | Value |
|-------|-------|
| Retcon type | `narrative_change` / `rule_clarification` / `timeline_correction` / `character_revision` / `world_expansion` |
| Severity | `critical` / `major` / `minor` |
| Change scope | `single_note` / `episode_range` / `arc` / `series` |
| Triggered by | `author_decision` / `continuity_failure` / `structural_redesign` / `canon_conflict` |
| Hard gate impact? | Yes / No |

---

## Previous Canon

### What was true before

State the original canon that is now being replaced. Be specific and precise.

> Example: As of ep_001 through ep_040, Seal III could be used independently of Seal II, with no prerequisite activation required.

### Where it appeared

List all notes and episodes that relied on the old canon.

| Source | Location | Relevant Content |
|--------|----------|-----------------|
| `rule_seal_binding_limit.md` | Conditions section | Seal III had no prerequisite |
| `ep_023.md` | Scene 2 | Lyra activates Seal III directly |
| `ep_031.md` | Scene 4 | Antagonist acknowledges independent Seal III |

---

## New Canon

### What is now true

State the replacement canon clearly and precisely.

> Example: Seal III now requires prior activation of Seal II. This is a fundamental architectural constraint of the binding system, not an exception.

### Source of truth going forward

- **New governing note:** `rule_seal_binding_limit_v2.md`
- **Effective from:** ep_041 onward
- **Retroactive interpretation:** [Is this change to be read backward into earlier episodes, or does it apply from ep_041 forward only?]

---

## Why the Change Was Made

### Primary Reason

Explain the narrative, structural, or systemic reason the change was necessary.

- [ ] Narrative: Old canon created a plot hole or contradiction
- [ ] Structural: Redesign required a fundamental rule adjustment
- [ ] Character: Character arc required a different constraint
- [ ] World: World logic forced a clarification
- [ ] Author decision: Intentional improvement to the story

### Secondary Reasons

Optional additional context.

---

## Affected Notes

### Official notes that directly contradict the new canon

These must be updated, deprecated, or retconned.

| Note ID | Title | Change Required | Action |
|---------|-------|-----------------|--------|
| `rule_seal_binding_limit.md` | Seal Binding Limit (old) | Contradicts new prerequisite rule | Retcon / Deprecate |
| `char_lyra_voss.md` | Lyra Voss | Abilities section references independent Seal III | Update |

### Provisional notes that may be affected

These must be reviewed.

| Note ID | Title | Risk | Action |
|---------|-------|------|--------|
| | | | |

### Structural notes that must be checked

| Note ID | Title | Risk | Action |
|---------|-------|------|--------|
| | | | |

---

## Required Revisions

### Immediate revision targets

Episodes or scenes that contain explicit contradictions with the new canon.

| Episode / Scene | Contradiction | Required Change |
|-----------------|---------------|-----------------|
| `ep_023 scene_023_02` | Lyra uses Seal III without Seal II | Rewrite — add prior Seal II activation or bridge scene |
| `ep_031 scene_031_04` | Antagonist confirms Seal III works independently | Rewrite or reframe as antagonist's incorrect belief |

### Audit targets after revision

Which audit types should be rerun after revisions are complete?

- [ ] Canon Auditor
- [ ] Timeline Auditor
- [ ] Motivation Auditor
- [ ] Structure Auditor

---

## Continuity Risk Assessment

### How visible is this retcon to the reader?

- High — very visible, directly contradicts what appears in the text
- Medium — detectable on close reading but not disruptive
- Low — mostly internal design consistency fix, reader unlikely to notice

### Risk of downstream chain effects

List any cascading risks.

- If Seal III requires Seal II, does this change the protagonist's arc timeline?
- Does the antagonist's strategy need to be revised if they knew this constraint?
- Does this affect any alliances or powers dependent on the old rule?

---

## Revision Completion Tracking

Use this to track progress across affected notes.

| Target | Status | Date | Notes |
|--------|--------|------|-------|
| `rule_seal_binding_limit.md` | pending / in progress / complete | | |
| `char_lyra_voss.md` | pending / in progress / complete | | |
| `ep_023.md` | pending / in progress / complete | | |
| `ep_031.md` | pending / in progress / complete | | |

---

## Sign-Off

### Canon Governance decision

- **Retcon approved:** Yes / No
- **Approved by:** {author / manager}
- **Date of approval:** {date}
- **Remaining risks accepted:** Yes / No

---

## Changelog

- {date}: Retcon identified by {agent/author}
- {date}: Retcon record created
- {date}: Author approved retcon
- {date}: Revisions complete across all affected notes
