# Obsidian-to-Agent Mapping Specification v1
## novelwriter | Canon Vault ↔ Agent JSON Bridge

---

## 1. Purpose

This specification defines how an Obsidian canon vault maps into the unified agent JSON system.

Goals:
- Convert Obsidian notes into structured retrieval objects
- Map note metadata into agent-readable fields
- Define which note types are used by which agents
- Standardize section parsing for body text
- Support safe canon-first design, writing, and audit workflows

**The bridge:**
```
Obsidian Vault → Retrieval Layer → Agent Runtime → Harness / Issue Ledger
```

---

## 2. Mapping Philosophy

Each Obsidian note has two layers:

### Layer A: Frontmatter
The structured metadata layer.

Use for:
- routing and filtering
- scope validation
- canon priority and status
- project classification
- entity type detection

### Layer B: Body Sections
The semantic content layer.

Use for:
- character motives
- relationship details
- rule exceptions
- geography details
- timeline explanations
- thematic interpretation
- continuity constraints

**Rule:**
- **Frontmatter drives filtering and trust**
- **Body sections drive interpretation and reasoning**

---

## 3. Core Frontmatter → JSON Mapping Table

| Obsidian Frontmatter | Unified JSON Field | Purpose |
|---------------------|-------------------|---------|
| `id` | `canon_refs[]`, `unit_id`, `related_entities[]` | Canonical identity |
| `title` | `summary`, display fields | Human-readable label |
| `entity_type` | Routing logic, `outputs.entity_type` | Determines agent usage |
| `project_id` | `project_id` | Project scoping |
| `canon_status` | Scope filtering, trust rules | official vs draft handling |
| `scope` | `scope[]` | Retrieval permission |
| `source_priority` | Conflict resolution | Tie-break between canon notes |
| `status` | `outputs.status`, validation context | Entity active/dead/sealed/etc |
| `aliases` | Alias resolver, entity normalization | Alternate names |
| `summary` | `summary` | Compact retrieval summary |
| `era` | `outputs.era`, timeline filtering | Era-based retrieval |
| `timeline_start` | Timeline agent inputs | Chronology checks |
| `timeline_end` | Timeline agent inputs | Chronology checks |
| `region` | Location routing | Geography-aware checks |
| `parent_entity` | Hierarchy mapping | Parent-child structure |
| `related_entities` | Retrieval expansion | Contextual lookup |
| `governing_rules` | Canon/rule audit inputs | Rule-linked checks |
| `continuity_risk` | Risk prioritization | Severity weighting |
| `visibility` | Retrieval restriction | Spoiler/internal filtering |
| `last_reviewed` | Freshness / trust support | Canon maintenance |
| `tags` | Retrieval hints | Semantic filtering |

---

## 4. Normalized Retrieval Object

When a note is loaded from Obsidian, convert it into a normalized retrieval object before sending to agents.

```json
{
  "note_id": "char_윤서준",
  "title": "윤서준",
  "entity_type": "character",
  "project_id": "nry",
  "canon_status": "official",
  "scope": "project_only",
  "source_priority": 1,
  "status": "active",
  "aliases": ["서준"],
  "summary": "22세 경영학과 2학년. 타인의 목소리에서 운율을 듣는 능력 보유.",
  "era": "현대",
  "timeline_start": null,
  "timeline_end": null,
  "region": "서울",
  "parent_entity": null,
  "related_entities": [
    "char_지아린",
    "char_최이든",
    "char_정시온",
    "rule_rhyme_system"
  ],
  "governing_rules": [
    "rule_rhyme_system"
  ],
  "continuity_risk": "critical",
  "visibility": "internal",
  "last_reviewed": "2026-04-02",
  "tags": ["canon", "character", "protagonist"],
  "sections": {
    "Core Identity": "...",
    "Internal Motivation": "...",
    "Voice / Speech Pattern": "...",
    "Relationships": "...",
    "Knowledge Boundaries": "...",
    "Character Arc": "...",
    "Continuity Constraints": "..."
  },
  "source_path": "03-캐릭터/윤서준.md",
  "derived": {
    "normalized_names": ["윤서준", "서준"],
    "is_high_trust": true,
    "is_active_canon": true,
    "canon_weight": 1.0,
    "retrieval_zone": "project",
    "hard_constraints": [],
    "soft_constraints": []
  }
}
```

---

## 5. Section Parsing Standard

Standardized body section headers per entity type make agent reasoning more reliable.

**Without standardized sections:** Agents retrieve noisier, less targeted content.
**With standardized sections:** Agents can query specific sections like `character.voice_profile` or `rule.exceptions`.

---

## 6. Entity-Type Section Standards

### 6-1. Character Note

```
## Core Identity
## External Role
## Internal Motivation
## False Belief
## Desire / Need
## Wound / Origin Pressure
## Voice / Speech Pattern
## Relationships
## Secrets
## Knowledge Boundaries
## Moral Line / Breaking Point
## Character Arc
## Continuity Constraints
## First Appearance
## Key Scenes
## Open Questions
## Notes for Future Use
```

**Section → Agent mapping:**

| Section | JSON Destination | Primary Consumer |
|---------|-----------------|-----------------|
| Core Identity | `outputs.start_state`, summary | Story Architect, Draft Composer |
| External Role | Structure context | Plot Designer, Scene Designer |
| Internal Motivation | Motivation input | Char Arc Designer, Motivation Auditor |
| False Belief | Arc logic | Character Arc Designer |
| Desire / Need | Pressure & transformation | Char Arc Designer, Motivation Auditor |
| Voice / Speech Pattern | `voice_profile_used[]` | Dialogue Coach, Voice Auditor |
| Relationships | Relational context | Scene Designer, Reader Experience Sim |
| Secrets | Hidden info map | Plot Designer, Causality Auditor |
| Knowledge Boundaries | Knowledge checks | POV Keeper, Knowledge Boundary Checker |
| Character Arc | Arc continuity | Story Architect, Structure Auditor |
| Continuity Constraints | Hard canon checks | Canon Auditor, Audit Harness |
| First Appearance | Timeline anchor | Timeline Auditor |
| Key Scenes | Retrieval hints | Story Architect, Scene Utility Auditor |

---

### 6-2. Faction Note

```
## Identity
## Ideology
## Leadership
## Internal Structure
## Territory
## Resources
## Military / Operational Capacity
## Allies
## Enemies
## Internal Fractures
## Public Image
## Hidden Agenda
## Related Events
## Continuity Constraints
## Open Questions
## Notes for Future Use
```

**Section → Agent mapping:**

| Section | Primary Consumer |
|---------|-----------------|
| Ideology | Theme Designer, Conflict Designer |
| Internal Structure | Plot Designer, Scene Designer |
| Territory | Timeline Auditor, Geography checks |
| Resources | Causality Auditor |
| Internal Fractures | Plot Designer (subplot hooks) |
| Continuity Constraints | Canon Auditor |

---

### 6-3. Location Note

```
## Overview
## Geography
## Political Role
## Strategic Importance
## Districts / Zones
## Travel Constraints
## Access Conditions
## Public Atmosphere
## Hidden Truths
## Related Events
## Continuity Constraints
## Open Questions
## Notes for Future Use
```

**Section → Agent mapping:**

| Section | Primary Consumer |
|---------|-----------------|
| Travel Constraints | Timeline Auditor (`travel_checks[]`) |
| Access Conditions | Scene Designer, Canon Auditor |
| Geography | Story Architect, Timeline Auditor |
| Continuity Constraints | Canon Auditor |

---

### 6-4. Rule / System Note

```
## Rule Statement
## Conditions
## Exceptions
## Known Violations
## Costs
## Narrative Implications
## Affected Entities
## Observable Signs
## Misunderstandings
## Continuity Constraints
## Open Questions
## Notes for Future Use
```

**Section → Agent mapping:**

| Section | Primary Consumer |
|---------|-----------------|
| Rule Statement | Canon Auditor (hard gate) |
| Conditions | Draft Composer, Plot Designer |
| Exceptions | Canon Auditor, Audit Harness |
| Known Violations | Canon Governance Manager |
| Costs | Plot Designer, Motivation Auditor |
| Narrative Implications | Story Architect, Theme Designer |
| Continuity Constraints | Audit Harness |

---

### 6-5. Timeline Event Note

```
## Summary
## Causes
## Phases
## Major Participants
## Outcome
## Lasting Consequences
## Public Narrative
## Hidden Truth
## Related Chapters / Scenes
## Continuity Constraints
## Open Questions
## Notes for Future Use
```

**Section → Agent mapping:**

| Section | Primary Consumer |
|---------|-----------------|
| Causes | Causality Auditor |
| Phases | Timeline Auditor |
| Major Participants | Plot Designer |
| Outcome | Story Architect |
| Lasting Consequences | Theme Designer, Plot Designer |
| Public Narrative vs Hidden Truth | Plot Designer (reveal planning) |
| Continuity Constraints | Canon Auditor |

---

## 7. Agent-by-Agent Canon Consumption Rules

### Story Architect
**Must read:** project overview, main character notes, major faction notes, world rule notes, theme notes
**Uses:** frontmatter for routing, body for thematic/structural reasoning

### Plot Designer
**Must read:** timeline event notes, faction notes, secret/reveal notes, relevant character notes, rule notes
**Most important fields:** `related_entities`, `timeline_start/end`, `governing_rules`, event causes/outcomes

### Character Arc Designer
**Must read:** character note (especially Internal Motivation, False Belief, Desire/Need, Character Arc), relationship notes, major event notes

### Scene Designer
**Must read:** current arc summary, relevant character notes, location note, relevant rule note if power/action involved

### Draft Composer
**Must read:** approved scene design, POV character note, location note, relevant rule note, recent prior scene summary
**Must not:** invent unchecked canon, ignore knowledge boundaries

### Canon Auditor
**Must read:** all cited canon refs, related official notes, rule notes, directly linked entity notes
**Must ignore:** deprecated, retconned, sandbox notes (unless explicitly requested)

### Timeline Auditor
**Must read:** timeline event notes, location travel constraints, chapter/scene anchors
**Most important fields:** `timeline_start`, `timeline_end`, `region`, travel constraints

### Motivation Auditor
**Must read:** character internal motivation section, desire/need section, recent scene chain, relationship notes

### Structure Auditor
**Must read:** arc summaries, chapter summaries, theme notes, ending plan note, major character arcs

---

## 8. Canon Retrieval Priority Order

When any agent retrieves canon:

```
Stage 1: Direct note match
  → exact entity note
  → exact chapter / arc / event note

Stage 2: Related entity expansion
  → related_entities[]
  → parent_entity
  → governing_rules[]

Stage 3: Scope expansion
  → project-specific official notes
  → shared-world official notes (if scope allows)

Stage 4: Contextual notes
  → linked timeline events
  → related locations
  → relationship notes

Stage 5: Low-priority semantic expansion
  → only if required
  → never let broad retrieval override canonical note identity
```

This prevents canon contamination.

---

## 9. Derived Fields (Auto-Generated)

When parsing Obsidian notes, generate these derived fields:

| Derived Field | Meaning |
|--------------|---------|
| `normalized_names[]` | title + all aliases merged |
| `is_high_trust` | true if official + not deprecated |
| `is_active_canon` | usable in normal audit |
| `canon_weight` | derived from status + priority |
| `retrieval_zone` | project / shared / sandbox / archive |
| `hard_constraints[]` | extracted from Continuity Constraints section |
| `soft_constraints[]` | extracted from narrative guidance sections |

---

## 10. Issue ↔ Note Linkage Example

```json
{
  "issue_id": "CA-001",
  "domain": "canon",
  "severity": "high",
  "title": "운율 소실 순서 위반 — 아린 이전에 다른 인물 소실",
  "canon_refs": [
    "char_윤서준.md",
    "rule_rhyme_system.md#hard_constraints[0]"
  ],
  "evidence": [
    {
      "source_type": "scene",
      "source_id": "ep_047_scene_02",
      "excerpt_ref": "47화 2씬 3단락"
    }
  ],
  "facts": [
    "47화 2씬에서 이든의 운율이 먼저 소실됨",
    "운율 시스템 규칙: 소실은 반드시 아린부터 시작"
  ],
  "inferences": [
    "집필 당시 소실 순서 미확인 추정"
  ],
  "fix_recommendations": [
    {
      "fix_id": "fix_ca_001_a",
      "size": "scene",
      "cost": "medium",
      "type": "rewrite",
      "proposal": "47화 2씬의 소실 대상을 이든→아린으로 교체",
      "preserves_canon": true,
      "risk": "47화 플롯 흐름 점검 필요",
      "requires_reaudit": true
    }
  ]
}
```

---

## 11. Parsing Policy

| Rule | Description |
|------|-------------|
| Rule 1 | Frontmatter missing required keys → downgrade trust |
| Rule 2 | Inconsistent section headers → map best-effort, flag for normalization |
| Rule 3 | Two official notes conflict → compare `source_priority`, `last_reviewed`, scope |
| Rule 4 | Draft-status note → may inspire design, must not override canon in audit |
| Rule 5 | New idea during drafting → tag `new_canon_candidate`, not canon fact |

---

## 12. Implementation Order

| Phase | Action | Status |
|-------|--------|--------|
| Phase 1 | Standardize frontmatter for 5 entity types | ✅ |
| Phase 2 | Standardize body section headers for 5 entity types | ✅ |
| Phase 3 | Build note parser → normalized retrieval objects | ⬜ |
| Phase 4 | Connect retrieval to Story Architect, Scene Designer, Canon Auditor | ⬜ |
| Phase 5 | Add derived fields + issue ledger linkage | ⬜ |

---

*버전: v1.0 | 생성일: 2026-04-02 | 소설: 너라는 운율*
