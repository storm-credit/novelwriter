# File Naming Convention & Note Lifecycle Rules
## novelwriter v1 | Obsidian Canon Vault Operations

---

## 1. Purpose

This document defines:
- Standardized file naming for all vault note types
- Folder structure for the vault
- Note lifecycle rules (draft → provisional → official → deprecated/retconned)
- Transition rules between lifecycle states
- Audit eligibility per lifecycle state

---

## 2. File Naming Convention

### 2-1. General Rules

```
Format:  {type_prefix}_{identifier}.md
Pattern: lowercase, underscores only, no spaces, no special characters
Length:  under 60 characters recommended
```

**Type prefix determines note family and routes agent retrieval.**

### 2-2. Canon Entity Notes

| Entity Type | Prefix | Example |
|-------------|--------|---------|
| Character | `char_` | `char_윤서준.md` |
| Faction | `faction_` | `faction_crimson_empire.md` |
| Location | `loc_` | `loc_서울_대학가.md` |
| Rule / System | `rule_` | `rule_rhyme_system.md` |
| Timeline Event | `event_` | `event_운율_소실_완료.md` |
| Object / Artifact | `obj_` | `obj_이어폰.md` |
| Concept | `concept_` | `concept_운율_단계.md` |

### 2-3. Story Structure Notes

| Structure Type | Prefix | Example |
|----------------|--------|---------|
| Project Overview | `project_` | `project_nry.md` |
| Volume | `vol_` | `vol_nry_01.md` |
| Arc / Phase | `arc_` | `arc_nry_phase03.md` |
| Chapter / Episode | `ep_` | `ep_041.md` |
| Scene | `scene_` | `scene_041_03.md` |

### 2-4. System / Process Notes

| Note Type | Prefix | Example |
|-----------|--------|---------|
| Issue Record | `iss_` | `iss_041_001.md` |
| Retcon Record | `retcon_` | `retcon_운율_소실_순서.md` |
| Canon Standard | `standard_` | `standard_frontmatter_v2.md` |
| Prompt Spec | `spec_` | `spec_canon_auditor.md` |
| Sandbox / Draft | `draft_` | `draft_ending_alt_01.md` |
| Open Questions | `q_` | `q_운율_소실_시점.md` |

### 2-5. Draft Files (Prose)

```
Format: drafts/{ep_id}_{scene_id}_v{N}.md
Example: drafts/ep041_scene03_v1.md
         drafts/ep041_scene03_v2.md
```

Draft prose files live in a `drafts/` folder, not in the main vault note structure.

### 2-6. nry-Specific Identifier Examples

```
char_윤서준.md              ← protagonist
char_지아린.md              ← love interest
rule_rhyme_system.md       ← core mechanic
arc_nry_phase02.md         ← arc: 연애 황금기
ep_041.md                  ← episode 41
scene_041_02.md            ← episode 41, scene 2
iss_041_001.md             ← issue record
event_운율_소실_1단계.md    ← key story event
```

---

## 3. Folder Structure

### 3-1. Recommended Vault Layout

```
{project_vault}/
│
├── 00_project/
│   ├── project_{project_id}.md          ← Project Overview
│   ├── q_{project_id}_open_questions.md
│   └── standard_frontmatter_v2.md
│
├── 01_canon/
│   ├── characters/
│   │   ├── protagonists/
│   │   │   └── char_{name}.md
│   │   ├── supporting/
│   │   │   └── char_{name}.md
│   │   └── minor/
│   │       └── char_{name}.md
│   ├── factions/
│   │   └── faction_{name}.md
│   ├── locations/
│   │   └── loc_{name}.md
│   ├── rules/
│   │   └── rule_{name}.md
│   └── events/
│       └── event_{name}.md
│
├── 02_structure/
│   ├── volumes/
│   │   └── vol_{project_id}_{n}.md
│   ├── arcs/
│   │   └── arc_{project_id}_{name}.md
│   ├── episodes/
│   │   ├── ep_{NNN}.md
│   │   └── ...
│   └── scenes/
│       ├── scene_{NNN}_{NN}.md
│       └── ...
│
├── 03_issues/
│   ├── open/
│   │   └── iss_{ep}_{NNN}.md
│   ├── resolved/
│   │   └── iss_{ep}_{NNN}.md
│   └── deferred/
│       └── iss_{ep}_{NNN}.md
│
├── 04_sandbox/
│   ├── draft_{name}.md
│   └── q_{name}.md
│
└── drafts/
    ├── ep_{NNN}_scene_{NN}_v{N}.md
    └── ...
```

### 3-2. nry Current Layout (Mapped)

```
C:\novel\igotothepast\lore\
│
├── 01-작품개요/      → 00_project/ 에 해당
├── 02-세계관/        → 01_canon/rules/ 에 해당
├── 03-캐릭터/        → 01_canon/characters/ 에 해당
└── 04-스토리/        → 02_structure/ 에 해당
```

---

## 4. Note Lifecycle States

모든 노트는 다섯 가지 상태 중 하나를 가집니다.

```
draft → provisional → official
                   → deprecated
                   → retconned
```

### 4-1. 상태 정의

| 상태 | 의미 | 감리 사용 가능 | 에이전트 참조 |
|------|------|-------------|------------|
| `draft` | 아직 검토 중, 변경 가능 | ❌ | 참고용만 |
| `provisional` | 내부 일관성 있음, 캐논 검증 대기 | ⬜ soft fail 근거만 | 주의하며 참조 |
| `official` | 확정 캐논 | ✅ hard gate 기준 | 최우선 참조 |
| `deprecated` | 더 이상 유효하지 않음, 교체됨 | 🚫 | 참조 금지 |
| `retconned` | 소급 취소됨, 후속 설정으로 대체 | 🚫 | 참조 금지 |

---

## 5. Lifecycle Transition Rules

### 5-1. draft → provisional

**조건:**
- 내부 논리 일관성 확인 완료
- 기존 official 노트와 명백한 충돌 없음
- 작가가 "집필 참고용으로 쓸 수 있음" 판단

**처리:**
```yaml
canon_status: draft → provisional
last_reviewed: {date}
reviewed_by: author
```

**에이전트 변화:**
- soft fail 근거로 사용 가능해짐
- hard gate 판정에는 여전히 사용 불가

---

### 5-2. provisional → official

**조건:**
- 원고에서 실제로 사용됨 (집필 완료)
- Canon Auditor 감사 통과 (충돌 없음)
- 작가 최종 승인

**처리:**
```yaml
canon_status: provisional → official
source_priority: {최종 우선순위 확정}
last_reviewed: {date}
reviewed_by: author
```

**에이전트 변화:**
- hard gate 판정 기준으로 사용 가능해짐
- 이 노트를 참조하던 모든 provisional 노트에 대해 재검토 트리거

---

### 5-3. official → deprecated

**조건:**
- 더 구체적이거나 최신의 official 노트로 교체됨
- 내용이 무효화됐지만 retcon은 아닌 경우

**처리:**
```yaml
canon_status: official → deprecated
deprecated_by: {교체 노트 ID}
deprecated_date: {date}
```

**에이전트 변화:**
- 모든 참조 즉시 차단
- 후속 노트로 참조 자동 리다이렉트 권장

---

### 5-4. official → retconned

**조건:**
- 이미 쓴 원고를 소급하여 설정 변경
- 이전 내용이 新 설정에 의해 무효화됨
- Retcon Record 노트(`retcon_*.md`) 반드시 생성

**처리:**
```yaml
canon_status: official → retconned
retconned_by: {새 설정 노트 ID}
retcon_date: {date}
retcon_reason: {간략한 이유}
```

**필수 추가 작업:**
1. `retcon_{name}.md` 생성 (소급 변경 이유, 영향 범위, 수정 필요 화 목록)
2. 영향받은 에피소드 목록 작성
3. Canon Auditor 회귀검사 예약

**에이전트 변화:**
- 모든 참조 즉시 차단
- 영향받은 화 자동 감리 재실행 요청

---

### 5-5. 금지된 전환

```
draft → official        ❌ (provisional 단계 반드시 거쳐야 함)
deprecated → official   ❌ (deprecated는 새 노트로만 대체)
retconned → official    ❌ (retcon은 새 노트로만 대체)
official → draft        ❌ (공식 노트를 draft로 되돌리기 금지)
```

---

## 6. 에이전트별 lifecycle 적용 규칙

### 설계군 (Design Division)

```
사용 가능: official + provisional
  official  → 설계 제약으로 반드시 준수
  provisional → 참고 가능, 하지만 최종 설계에 반영 전 검증 필요

사용 금지: draft + deprecated + retconned
  draft      → 참고용으로만, 설계 결과에 포함 시 [미정] 태그 필수
  deprecated → 완전 차단
  retconned  → 완전 차단
```

### 집필군 (Writing Division)

```
사용 가능: official
  official  → 본문 생성의 유일한 근거

주의 사용: provisional
  provisional → 집필 참고 가능하지만
               → 집필 후 Canon Auditor 감사 필수
               → new_canon_candidate 태그 권장

사용 금지: draft + deprecated + retconned
```

### 감리군 (Audit Division)

```
hard gate 판정: official만 사용
soft gate 판정: official + provisional 사용

사용 금지: draft + deprecated + retconned
  → 이 상태의 노트가 감리 근거로 쓰이면 즉시 기각
```

---

## 7. New Canon Candidate 처리 흐름

집필 중 기존 설정에 없는 내용이 생길 때:

```
집필 중 new_canon_candidate 발생
         ↓
  [small detail?]
  예 → new_canon_candidate 태그만, 집필 계속
  아니오 ↓
  [rule/system 관련?]
  예 → 집필 즉시 중단 → Canon Auditor → 승인 없이 진행 불가
  아니오 ↓
  new_canon_candidate 태그 + Canon Governance Manager 통보
  집필 계속
         ↓
  감리 완료 후 작가 결정:
  ├── 승인 → draft_{name}.md 생성 → provisional 상태로 보관
  └── 거부 → 해당 내용 삭제 또는 기존 설정으로 대체
```

### New Canon → official 경로

```
new_canon_candidate 태그 부착 (집필 중)
         ↓
Canon Auditor 검토 (충돌 없음 확인)
         ↓
작가 승인
         ↓
draft_{name}.md 생성 (canon_status: draft)
         ↓
내부 논리 검증
         ↓
{type_prefix}_{name}.md 노트 생성 (canon_status: provisional)
         ↓
실제 원고 반영 + Canon Auditor 재감사
         ↓
canon_status: official 승격
```

---

## 8. Issue Record Lifecycle

이슈 레코드도 자체 lifecycle을 가집니다.

| 상태 | 의미 | 위치 |
|------|------|------|
| `open` | 발견됨, 미해결 | `03_issues/open/` |
| `proposed_fix` | 수정안 제안됨 | `03_issues/open/` |
| `resolved` | 수정 완료, 회귀검사 통과 | `03_issues/resolved/` |
| `deferred` | 나중에 처리 예정 | `03_issues/deferred/` |
| `wont_fix` | 의도적으로 유지 (작가 결정) | `03_issues/resolved/` |

### Lifecycle 전환

```
open → proposed_fix → resolved → (완료)
open → deferred → open (재활성화 가능)
open → wont_fix → (완료)
proposed_fix → open (수정안 기각 시)
```

---

## 9. Version Control 규칙

### 드래프트 파일 버전

```
ep041_scene03_v1.md   ← 초안
ep041_scene03_v2.md   ← 1차 수정 후
ep041_scene03_v3.md   ← 최종본

최신 버전 = 현재 감리 대상
이전 버전 = 비교 참조용 (삭제하지 않음)
```

### 노트 변경 시

Obsidian 프론트매터의 `last_reviewed` 갱신:
```yaml
last_reviewed: 2026-04-02
reviewed_by: author
```

대규모 변경 시에는 `changelog` 섹션을 노트 하단에 추가:
```markdown
## Changelog
- 2026-04-02: Arc 재설계로 인해 Phase III 아크 설명 수정
- 2026-03-15: 최초 생성
```

---

## 10. 빠른 참조표

### 노트 유형별 에이전트 우선순위

| 에이전트 | 1순위 | 2순위 | 3순위 |
|---------|------|------|------|
| Story Architect | Project Overview | Arc, Character | Rule/System |
| Plot Designer | Arc, Timeline Event | Faction, Character | Location |
| Character Arc Designer | Character | Arc, Relationship | Event |
| Scene Designer | Scene, Chapter | Character, Location | Rule/System |
| Draft Composer | Scene (design) | Character (POV) | Location, Rule |
| Canon Auditor | Rule/System, Character | Faction, Location | Timeline Event |
| Timeline Auditor | Timeline Event | Location (travel) | Character |
| Motivation Auditor | Character (motivation) | Scene, Event | Relationship |
| Structure Auditor | Project, Arc | Volume, Chapter | Issue history |

---

*버전: v1.0 | 생성일: 2026-04-02 | 소설: 너라는 운율*
