---
id: issue_{{도메인약어}}_{{번호}}
title: {{이슈 제목}}
entity_type: issue_record
project_id: nry
canon_status: official
scope: project_only
source_priority: 1
status: active
severity: critical | high | medium | low
issue_domain: canon | timeline | plot_causality | motivation | voice | scene_purpose | pacing
related_entities:
  - {{관련_캐릭터_id}}
related_story_units:
  - ep_XXX
  - ep_YYY
continuity_risk: {{severity와 일치}}
last_reviewed: {{YYYY-MM-DD}}
tags:
  - issue
  - continuity
  - {{도메인태그}}
---

## Problem

**이슈 한 줄 설명**:

**발견 에이전트**: {{Canon Auditor / Timeline Auditor / ...}}
**발견 화**: ep_XXX
**이슈 ID**: {{CA-001 / TL-003 / ...}}
**하드 게이트 위반**: Yes / No — {{게이트 타입}}

---

## Evidence

### 원고 근거
> **{{화 번호}}화 {{씬}} 인용**:
> "{{원문 인용 (최대 300자)}}"

### 설정집 근거
> **[[설정집 노트명]] §{{섹션}}**:
> "{{설정집 원문}}"

---

## Why It Matters

이 이슈가 서사 품질에 미치는 영향:
-

---

## Candidate Fixes

| 크기 | 비용 | 제안 내용 | 인간 승인 필요 |
|------|------|----------|--------------|
| line_edit | trivial | | No |
| scene_patch | low | | No |
| chapter_patch | medium | | Yes |

---

## Decision

**채택된 수정 방향**:

**결정 근거**:

**결정 날짜**: YYYY-MM-DD

---

## Resolution History

| 날짜 | 상태 | 내용 |
|------|------|------|
| YYYY-MM-DD | open | 이슈 최초 탐지 |
| | patched | |
| | resolved | |

---

**📂 관련 문서**
- [[관련 캐릭터]]
- [[운율 시스템]]
