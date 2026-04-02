# Vault Governance Specification v1
## Folder Structure, File Naming, and Note Lifecycle Rules
## novelwriter | Obsidian Canon Vault

---

## 1. Purpose

This specification defines how your Obsidian vault is governed at the file-system level.

Covers:
- Folder structure rules
- File naming rules
- Note ID rules
- Lifecycle state rules (draft → official → deprecated)
- Promotion / demotion rules
- Archive / deprecation rules
- Draft safety boundaries
- Retcon handling rules

Goals:
- Canon stays trustworthy
- Agents retrieve the right notes
- Exploratory work remains flexible
- Official notes remain stable
- The vault scales across multiple chronicles and projects

---

## 2. Governance Principles

| Principle | Rule |
|-----------|------|
| Canon must be stable | Official notes should not change casually |
| Drafts must be safe to explore | Draft material must be impossible to confuse with official canon |
| File identity must be persistent | A note's `id` is stable even if its title changes |
| Physical separation supports logical separation | Sandbox, archive, and official canon are separated by folder AND metadata |
| Promotion must be explicit | A draft does not become official just because it is useful |

---

## 3. Top-Level Folder Structure

```
Obsidian Vault/
│
├── 00_meta/                          ← System-level governance only
│   ├── canon_standards/
│   ├── schemas/
│   ├── workflow_rules/
│   ├── prompt_specs/
│   └── lifecycle_rules/
│
├── 01_shared_multiverse/             ← Cross-project canon only
│   ├── 01_overview/
│   ├── 02_rules_and_systems/
│   ├── 03_shared_entities/
│   ├── 04_shared_locations/
│   ├── 05_shared_timeline/
│   ├── 06_constraints/
│   ├── 07_open_questions/
│   ├── 08_retcons/
│   └── 09_deprecated/
│
├── 10_chronicle_nry/                 ← nry 프로젝트 (너라는 운율)
│   ├── 01_overview/
│   ├── 02_story_structure/
│   │   ├── project/
│   │   ├── volumes/
│   │   ├── arcs/
│   │   ├── chapters/
│   │   └── scenes/
│   ├── 03_characters/
│   │   ├── protagonists/
│   │   ├── supporting/
│   │   └── minor/
│   ├── 04_factions/
│   ├── 05_locations/
│   ├── 06_rules_and_systems/
│   ├── 07_timeline/
│   │   ├── eras/
│   │   └── events/
│   ├── 08_objects/
│   ├── 09_relationships/
│   ├── 10_open_issues/
│   ├── 11_retcons/
│   ├── 12_drafts/
│   ├── 13_sandbox/
│   ├── 14_deprecated/
│   └── 15_archive/
│
├── 20_chronicle_next/               ← 다음 프로젝트 (확장 시)
│
├── 90_lab/                          ← 시스템 실험용
│   ├── experiments/
│   └── prompt_trials/
│
└── 99_archive_global/               ← 전체 아카이브
    └── retired_projects/
```

### Folder Purpose Rules

| Folder | Purpose | Agent Authority |
|--------|---------|----------------|
| `00_meta/` | System governance only | Process logic only, not story truth |
| `01_shared_multiverse/` | Cross-project canon | shared_world scope만 |
| `10_chronicle_*/` main folders | Active canon | Full authority |
| `12_drafts/` | Unapproved but serious notes | No audit authority |
| `13_sandbox/` | Free exploration | Zero agent authority |
| `14_deprecated/` | Old, replaced notes | Historical reference only |
| `15_archive/` | Frozen historical storage | Never active retrieval |

---

## 4. File Naming Convention

### General Rule

```
Format:  {prefix}_{stable_identifier}.md
Pattern: lowercase, underscores only, no spaces, no special characters
Length:  under 60 characters recommended
```

### Prefix Table

| Prefix | Note Type | Example |
|--------|-----------|---------|
| `project_` | Project overview | `project_nry.md` |
| `vol_` | Volume | `vol_nry_01.md` |
| `arc_` | Arc / Phase | `arc_nry_phase03.md` |
| `ep_` | Episode / Chapter | `ep_041.md` |
| `scene_` | Scene | `scene_041_03.md` |
| `char_` | Character | `char_윤서준.md` |
| `faction_` | Faction | `faction_crimson_empire.md` |
| `loc_` | Location | `loc_서울_대학가.md` |
| `rule_` | Rule / System | `rule_rhyme_system.md` |
| `event_` | Timeline Event | `event_운율_소실_1단계.md` |
| `obj_` | Object / Artifact | `obj_이어폰.md` |
| `rel_` | Relationship | `rel_서준_아린.md` |
| `iss_` | Issue Record | `iss_041_001.md` |
| `retcon_` | Retcon Record | `retcon_운율_소실_순서.md` |
| `q_` | Open Question | `q_운율_소실_시점.md` |
| `meta_` | Meta / Process note | `meta_canon_standards.md` |

### Naming Rules

```
Rule A: Lowercase only
Rule B: Underscores, not spaces
Rule C: Stable semantic names (no "final_v2_really.md" patterns)
Rule D: Do NOT encode canon_status in the filename — that belongs in frontmatter
Rule E: For episodes/scenes, include order number when useful
        ep_041.md, scene_041_03.md
```

---

## 5. Note ID Rules

The `id` in frontmatter is more important than the filename.

| Rule | Detail |
|------|--------|
| **Unique** | No two notes share an id |
| **Stable** | id does not change when title changes |
| **Never reused** | Even after deprecation/deletion |
| **Machine-readable** | Lowercase, underscores, no spaces |
| **Location-independent** | id works regardless of folder |

```yaml
# Examples
id: char_윤서준
id: rule_rhyme_system
id: arc_nry_phase03
id: ep_041
id: scene_041_03
```

**Title/folder may change. ID stays.**

---

## 6. Note Lifecycle States

```
              ┌──────────┐
              │  draft   │
              └─────┬────┘
                    │ promote (checked)
              ┌─────▼──────┐
              │ provisional │
              └─────┬──────┘
                    │ promote (approved)
              ┌─────▼────┐
              │ official  │
              └─────┬────┘
           ┌────────┴────────┐
           │                 │
    ┌──────▼──────┐   ┌──────▼──────┐
    │ deprecated  │   │  retconned  │
    └──────┬──────┘   └──────┬──────┘
           │                 │
           └────────┬────────┘
                    ▼
              ┌──────────┐
              │ archived │
              └──────────┘
```

### State Definitions

| State | Meaning | Hard Gate? | Soft Gate? | Folder |
|-------|---------|-----------|-----------|--------|
| `draft` | Under development | ❌ | ❌ | `12_drafts/` |
| `provisional` | Usable, awaiting validation | ❌ | ✅ | project folder or `12_drafts/` |
| `official` | Confirmed canon | ✅ | ✅ | project main folders |
| `deprecated` | Replaced, no longer governing | 🚫 | 🚫 | `14_deprecated/` |
| `retconned` | Explicitly superseded | 🚫 | 🚫 | `11_retcons/` + `14_deprecated/` |
| `archived` | Frozen, not active | 🚫 | 🚫 | `15_archive/` |

---

## 7. Promotion Rules

### draft → provisional

**Conditions:**
- Stable form, metadata complete
- Minimum section structure present
- No direct conflict with official notes

```yaml
canon_status: provisional
last_reviewed: {date}
reviewed_by: author
```

**Agent impact:** soft gate reference now allowed.

---

### provisional → official

**Conditions:**
- Intentionally adopted as canon
- Conflicts resolved
- Related notes updated
- Explicit author approval

```yaml
canon_status: official
source_priority: {final value}
last_reviewed: {date}
reviewed_by: author
```

**Agent impact:** hard gate authority now active.
**Required action:** trigger re-review of all linked provisional notes.

---

### official → deprecated

**When:**
- Replaced by a more specific or newer official note
- Content invalidated but not due to retcon

```yaml
canon_status: deprecated
deprecated_by: {replacement note id}
deprecated_date: {date}
```

**Required action:** move to `14_deprecated/`, update all active references.

---

### official → retconned

**When:**
- Deliberate retroactive canon change
- Old truth actively replaced by new truth

```yaml
canon_status: retconned
retconned_by: {new note id}
retcon_date: {date}
retcon_reason: {brief reason}
```

**Required actions:**
1. Create `retcon_{name}.md` (reason, affected notes, revision list)
2. Move to `11_retcons/` and `14_deprecated/`
3. Schedule Canon Auditor regression check on affected episodes

---

## 8. Demotion Rules

| Transition | When Allowed |
|-----------|-------------|
| `provisional → draft` | Concept unstable again, design branch abandoned |
| `official → provisional` | Rare — conflict discovered before wide adoption, major redesign underway |
| `official → draft` | ❌ Forbidden |
| `deprecated → official` | ❌ Forbidden (create new note instead) |
| `retconned → official` | ❌ Forbidden (create new note instead) |

---

## 9. Forbidden Patterns

```
❌ draft → official           (skip provisional)
❌ deprecated → official      (use new note)
❌ retconned → official       (use new note)
❌ official → draft           (use deprecated or retconned instead)
❌ "final_v2_really.md"       (versioning in filename)
❌ title as id                (titles change, ids must not)
❌ sandbox used in audit      (zero agent authority)
```

---

## 10. Retcon Record Required Structure

```markdown
---
id: retcon_{name}
title: Retcon — {description}
entity_type: retcon_record
project_id: {id}
canon_status: official
scope: project_only
source_priority: 1
status: active
related_entities:
  - {original note id}
  - {replacement note id}
tags:
  - retcon
  - canon_change
---

## Previous Canon
## New Canon
## Why the Change Was Made
## Affected Notes
## Required Revisions
## Risk Notes
## Changelog
```

---

## 11. Agent Retrieval Safety Filters

| Agent type | Includes | Excludes by default |
|-----------|----------|-------------------|
| Design agents | official + provisional | draft, deprecated, retconned, sandbox, archive |
| Writing agents | official (+ provisional with caution) | draft, deprecated, retconned, sandbox, archive |
| Audit agents | official only | All others |
| All agents | — | sandbox, archive, lab folders |

---

## 12. New Canon Candidate Flow

```
집필 중 new_canon_candidate 발생
    ↓
[small detail?]
  Yes → new_canon_candidate 태그만, 집필 계속
  No ↓
[rule/system 관련?]
  Yes → 집필 즉시 중단 → Canon Auditor → 승인 없이 진행 불가
  No ↓
new_canon_candidate 태그 + Canon Governance Manager 통보
    ↓
감리 완료 후 작가 결정:
├── 승인 → draft_{name}.md → provisional → official 경로 시작
└── 거부 → 해당 내용 삭제 또는 기존 설정으로 대체
```

---

## 13. Good vs. Bad Naming Examples

**Good:**
```
char_윤서준.md
rule_rhyme_system.md
arc_nry_phase03.md
ep_041.md
scene_041_02.md
iss_041_001.md
event_운율_소실_1단계.md
retcon_운율_소실_순서.md
```

**Bad:**
```
Lyra New.md
important rule edit.md
chapter final version.md
scene revised again v3 FINAL.md
cool idea maybe.md
```

---

## 14. Lifecycle Governance Checklist

Before a note is trusted by agents:

```
[ ] File is in the correct folder for its status
[ ] Frontmatter required fields are complete
[ ] id is stable and unique
[ ] canon_status is accurate
[ ] scope is correct
[ ] section headers are normalized for entity type
[ ] related_entities are linked
[ ] Note is NOT in sandbox or archive unless intentionally referenced
```

---

*버전: v1.0 | 생성일: 2026-04-02 | 소설: 너라는 운율*
