# Output Schema Registry — Unified JSON Schema v1
## novelwriter | Canon-Driven Design / Writing / Audit System

---

## 1. 설계 목표

이 스키마의 목적:
- 설계군 / 집필군 / 감리군 출력 통일
- 하네스가 자동 판정 가능
- 이슈 장부(issue ledger)로 바로 적재 가능
- 회귀검사 대상 자동 추적 가능
- 캐논 근거와 추론 분리
- 확정 / 가안 / 경고 / 실패 상태를 구조적으로 표현

**핵심 원칙: 모든 에이전트는 자유서술이 아니라 구조화된 객체를 반환한다.**

---

## 2. 최상위 공통 스키마 (모든 에이전트 필수)

```json
{
  "schema_version": "1.0",
  "agent": "",
  "division": "design | writing | audit | harness | manager",
  "task_type": "",
  "project_id": "",
  "scope": [],
  "unit_id": "",
  "status": "proposal | pass | soft_fail | fail | blocked | needs_review",
  "confidence": 0.0,
  "summary": "",
  "canon_refs": [],
  "inputs_used": [],
  "outputs": {},
  "issues": [],
  "risks": [],
  "assumptions": [],
  "next_actions": [],
  "regression_targets": [],
  "metadata": {}
}
```

### 공통 필드 정의

| 필드 | 타입 | 설명 |
|-----|------|------|
| `schema_version` | string | 스키마 버전 (현재 `"1.0"`) |
| `agent` | string | 에이전트 이름 |
| `division` | enum | `design | writing | audit | harness | manager` |
| `task_type` | string | 작업 유형 (`arc_design`, `scene_draft`, `canon_check` 등) |
| `project_id` | string | 프로젝트 식별자 (`nry` 등) |
| `scope` | array | 허용된 캐논 범위 (`["project_only"]`) |
| `unit_id` | string | 현재 작업 단위 (`arc_02`, `ep041`, `scene_12_03`) |
| `status` | enum | 반환 상태 |
| `confidence` | float 0–1 | 결과 신뢰도 |
| `summary` | string | 한 줄 요약 (작가가 읽는 용) |
| `canon_refs` | array | 참조한 캐논 노트 목록 |
| `inputs_used` | array | 실제 사용한 입력 자료 목록 |
| `outputs` | object | 에이전트별 본문 결과 |
| `issues` | array | 발견한 문제 목록 |
| `risks` | array | 아직 문제가 아니지만 위험한 부분 |
| `assumptions` | array | 추론 기반 가정 (명시 필수) |
| `next_actions` | array | 다음 추천 행동 |
| `regression_targets` | array | 수정 후 재검사 필요 대상 |
| `metadata` | object | 로그용 부가 정보 |

### status 값 정의

| 값 | 사용 | 의미 |
|----|------|------|
| `proposal` | 설계·집필 | 제안 또는 초안 단계 |
| `pass` | 감리 | 문제 없음 |
| `soft_fail` | 감리 | 경고 수준, 수정 권장 |
| `fail` | 감리 | 수정 필요 |
| `blocked` | 감리 | 하드 게이트 실패, 진행 차단 |
| `needs_review` | 전체 | 사람 검토 필요 |

---

## 3. Issue Object 공통 스키마

모든 감리/하네스/매니저가 사용하는 이슈 객체.

```json
{
  "issue_id": "",
  "domain": "canon | timeline | causality | motivation | structure | voice | pacing | scene_utility | theme | other",
  "severity": "low | medium | high | critical",
  "status": "open | proposed_fix | resolved | deferred",
  "title": "",
  "summary": "",
  "evidence": [
    {
      "source_type": "scene | note | episode | chapter",
      "source_id": "",
      "excerpt_ref": ""
    }
  ],
  "canon_refs": [],
  "facts": [],
  "inferences": [],
  "impact": "",
  "fix_recommendations": [],
  "owner": "",
  "requires_human_review": false
}
```

| 필드 | 필수 | 설명 |
|-----|------|------|
| `issue_id` | ✅ | 형식: `ISS-{화번호}-{순번}` 또는 `{AGENT_ABBR}-{NNN}` |
| `domain` | ✅ | 문제 분야 |
| `severity` | ✅ | `low | medium | high | critical` |
| `status` | ✅ | `open | proposed_fix | resolved | deferred` |
| `title` | ✅ | 한 줄 요약 |
| `evidence` | ✅ (감리) | 원고 근거 (source_id + 위치) |
| `canon_refs` | ✅ (감리) | 설정집 노트 경로 |
| `facts` | ✅ | 확인 가능한 사실만 |
| `inferences` | ✅ | 추론은 반드시 분리 |
| `fix_recommendations` | ⬜ 권장 | 수정 방향 |
| `confidence` | ✅ | 0.0–1.0 |
| `requires_human_review` | ✅ | 사람 판단 필요 여부 |

---

## 4. Fix Recommendation 스키마

```json
{
  "fix_id": "",
  "size": "line | paragraph | beat | scene | chapter | arc",
  "cost": "low | medium | high",
  "type": "rewrite | insert | delete | reorder | clarify | retcon_candidate",
  "proposal": "",
  "preserves_canon": true,
  "risk": "",
  "requires_reaudit": true
}
```

---

## 5. 설계군 전용 outputs 스키마

### 5-1. Story Architect

```json
{
  "structure_mode": "ending_first | character_driven | plot_driven | hybrid",
  "structure_model": "3_act | 4_act | serial_arc | mystery_ladder | custom",
  "core_conflicts": [],
  "turning_points": [],
  "arc_map": [],
  "theme_alignment": "",
  "open_dependencies": []
}
```

**전체 예시:**
```json
{
  "schema_version": "1.0",
  "agent": "Story Architect",
  "division": "design",
  "task_type": "arc_design",
  "project_id": "nry",
  "scope": ["project_only"],
  "unit_id": "phase_03",
  "status": "proposal",
  "confidence": 0.88,
  "summary": "Phase III는 이별 아크의 시작이며, 감정 위기가 플롯 위기와 연동됨.",
  "canon_refs": ["char_윤서준.md", "char_지아린.md", "rule_rhyme_system.md"],
  "inputs_used": ["phase_02_summary", "theme_notes", "arc_current"],
  "outputs": {
    "structure_mode": "ending_first",
    "structure_model": "serial_arc",
    "core_conflicts": ["capability_vs_understanding", "distance_vs_connection"],
    "turning_points": ["운율 소실 1단계 감지", "첫 번째 큰 싸움", "운율 완전 소실", "이별"],
    "arc_map": ["황금기 붕괴", "균열", "소실", "이별"],
    "theme_alignment": "듣는 것≠이해하는 것 — 운율 소실로 테마 위기 도달",
    "open_dependencies": ["운율 소실 1단계 시작 시점 미확정"]
  },
  "issues": [],
  "risks": ["56-70화 감정만 연속되어 독자 피로 위험"],
  "assumptions": ["47화 전후 운율 소실 시작 가정"],
  "next_actions": ["Plot Designer에게 51-70화 사건 배치 요청"],
  "regression_targets": [],
  "metadata": {}
}
```

---

### 5-2. Character Arc Designer

```json
{
  "character_id": "",
  "start_state": "",
  "false_belief": "",
  "core_wound": "",
  "desire": "",
  "need": "",
  "midpoint_pressure": "",
  "transformation_path": [],
  "end_state": "",
  "required_bridge_scenes": []
}
```

---

### 5-3. Plot Designer

```json
{
  "event_chain": [
    {
      "event_id": "",
      "description": "",
      "cause": "",
      "effect": "",
      "node_type": "setup | midpoint | payoff | transition | reversal | reveal"
    }
  ],
  "foreshadowing_map": [
    {
      "payoff_id": "",
      "payoff_description": "",
      "plant_points": []
    }
  ],
  "weak_transitions": [],
  "convenience_risk_flags": []
}
```

---

### 5-4. Ending Designer

```json
{
  "ending_mode": "tragic | bittersweet | mythic | open | cyclical | serial_continuation",
  "emotional_closure": "",
  "plot_closure": "",
  "canon_axis_resolved": true,
  "arc_axis_resolved": true,
  "theme_axis_resolved": true,
  "threads_to_resolve": [],
  "threads_to_leave_open": [],
  "setup_requirements": [],
  "danger_points": []
}
```

---

## 6. 집필군 전용 outputs 스키마

### 6-1. Scene Designer

```json
{
  "scene_goal": "",
  "scene_role": "plot | character | relationship | tension | reveal | setup | payoff",
  "beats": [
    {
      "beat": "opening | conflict | turning | closing",
      "description": "",
      "approximate_length": ""
    }
  ],
  "emotional_shift": { "start": "", "end": "" },
  "tension_shift": { "start": "low | medium | high", "end": "low | medium | high" },
  "information_movement": { "reader_learns": "", "character_learns": "" },
  "canon_sensitive_elements": [],
  "required_followup": []
}
```

---

### 6-2. Draft Composer

```json
{
  "draft_ref": "drafts/ep041_scene03_v1.md",
  "pov": "",
  "voice_profile_used": [],
  "canon_constraints_applied": [],
  "new_canon_candidates": [
    {
      "content": "",
      "location": "",
      "risk": "low | medium | high"
    }
  ],
  "uncertain_lines": []
}
```

> 참고: `draft_text`는 별도 파일로 저장하고 여기엔 경로(`draft_ref`)만 기입.

---

### 6-3. Dialogue Coach

```json
{
  "dialogue_targets": [],
  "voice_notes": [],
  "revised_lines": [
    {
      "character": "",
      "original_line": "",
      "issue": "voice_mismatch | exposition | rhythm_repetition | subtext_absent",
      "revised_line": "",
      "note": ""
    }
  ],
  "risk_lines": [],
  "alternatives": []
}
```

---

### 6-4. Bridge Scene Generator

```json
{
  "gap_type": "emotional | causal | logistical | informational | relational | motivational",
  "bridge_size": "line | paragraph | beat | scene | chapter",
  "bridge_function": "",
  "bridge_draft_ref": "",
  "canon_constraints": [],
  "risk_if_omitted": "",
  "alternative_no_bridge": {
    "possible": false,
    "method": ""
  }
}
```

---

## 7. 감리군 전용 outputs 스키마

### 7-1. Canon Auditor

```json
{
  "verdict_type": "direct_contradiction | ambiguity | unsupported_assumption | pass",
  "checked_entities": [],
  "conflict_count": 0,
  "critical_conflicts": [],
  "soft_conflicts": [],
  "resolution_paths": []
}
```

---

### 7-2. Timeline Auditor

```json
{
  "timeline_verdict": "pass | weak | fail",
  "time_anchors_used": [],
  "travel_checks": [],
  "sequence_issues": [],
  "elapsed_time_gaps": [],
  "minimal_adjustments": []
}
```

---

### 7-3. Motivation Auditor

```json
{
  "character_id": "",
  "motivation_verdict": "earned | weak | broken",
  "desire_line": "",
  "pressure_line": "",
  "trigger_gap_type": "none | internal | relational | event | ideological",
  "missing_bridges": [],
  "recommended_fix_mode": "monologue | dialogue | event | bridge_scene"
}
```

---

### 7-4. Structure Auditor

```json
{
  "framework_used": "3_act | 4_act | serial_arc | progression_fantasy | mystery_ladder | custom",
  "structure_verdict": "coherent | uneven | weak | broken",
  "weak_points": [],
  "escalation_gaps": [],
  "closure_gaps": [],
  "story_craft_scores": {
    "narrative_drive": 0,
    "character_investment": 0,
    "structural_clarity": 0,
    "theme_integration": 0,
    "pacing_variety": 0
  },
  "recommended_adjustments": []
}
```

---

### 7-5. Scene Utility Auditor

```json
{
  "utility_verdict": "high | medium | low | none",
  "functions_served": [],
  "redundancy_level": "none | light | medium | heavy",
  "compression_possible": true,
  "verdict": "keep | revise | compress | merge | remove"
}
```

---

### 7-6. Reader Experience Simulator

```json
{
  "attention_curve": [
    {
      "position": "10% | 25% | 50% | 75% | end",
      "interest_level": 0,
      "information_density": "too_much | right | too_little",
      "emotional_engagement": "low | building | peak | spent",
      "likely_reader_question": ""
    }
  ],
  "dropout_risk_zones": [],
  "emotional_peak_predictions": [],
  "information_absorption_issues": [],
  "recommendations": []
}
```

---

## 8. 하네스 전용 스키마

### 8-1. Global Harness

```json
{
  "project_validation": "pass | fail",
  "active_scope": [],
  "excluded_canon_classes": [],
  "schema_validation": "pass | fail",
  "routed_issues": [],
  "regression_flags": [],
  "blockers": []
}
```

### 8-2. Design Harness

```json
{
  "confirmed_elements": [],
  "provisional_elements": [],
  "unsafe_canon_overwrites": [],
  "unresolved_dependencies": [],
  "design_state": "safe | caution | blocked"
}
```

### 8-3. Writing Harness

```json
{
  "scene_readiness": "ready | not_ready",
  "canon_retrieval_confirmed": true,
  "pov_confirmed": true,
  "voice_profile_confirmed": true,
  "invention_flags": [],
  "audit_readiness": "ready | not_ready"
}
```

### 8-4. Audit Harness

```json
{
  "fail_classification": "pass | soft_fail | fail | blocked",
  "accepted_findings": [],
  "discarded_findings": [],
  "duplicate_merged": [],
  "regression_schedule": [],
  "return_route": "design | writing | manager | human_review"
}
```

---

## 9. 매니저 전용 스키마

```json
{
  "task_classification": "",
  "assigned_agents": [],
  "merged_summary": "",
  "priority_issues": [],
  "route_decision": "design | writing | audit | human_review | archive",
  "required_inputs_next": [],
  "blocked_by": []
}
```

---

## 10. 상태값 표준 참조

### 전역 status
`proposal | pass | soft_fail | fail | blocked | needs_review`

### Issue severity
`low | medium | high | critical`

### Issue status
`open | proposed_fix | resolved | deferred`

### Verdict (감리)
`pass | soft_fail | hard_fail`

### 설계 classification
`confirmed | provisional | experimental`

---

## 11. 필수 필드 검증 규칙

| 에이전트 유형 | 필수 필드 |
|------------|---------|
| **모든 에이전트** | `schema_version`, `agent`, `division`, `project_id`, `unit_id`, `status`, `confidence`, `summary` |
| **감리 에이전트** | + `issues[]`, `hard_gate_triggered` |
| **이슈 오브젝트** | `issue_id`, `domain`, `severity`, `status`, `title`, `evidence[]`, `canon_refs[]`, `facts[]`, `inferences[]`, `confidence` |
| **설계 에이전트** | + `target_scope`, `unresolved_dependencies`, `canon_conflicts` |
| **집필 에이전트** | + `pov`, `canon_lookup_done`, `new_canon_candidates[]` |
| **하네스** | `harness`, `pre_check`, `post_check` |

---

## 12. V1 핵심 규칙

1. 모든 감리 결과는 `issues[]` 사용
2. 모든 추론은 `assumptions[]` 또는 `inferences[]`로 분리
3. 모든 수정안은 `fix_recommendations[]`로 구조화
4. 모든 캐논 참조는 `canon_refs[]`에 기록
5. 하네스는 자유서술 금지, 판정만 수행
6. 매니저는 직접 긴 본문을 쓰지 않고 라우팅 중심

---

## 13. 구현 단계

| Phase | 내용 | 상태 |
|-------|------|------|
| Phase 1 | 공통 최상위 스키마 + issue object + fix recommendation | ✅ 설계 완료 |
| Phase 2 | 설계/집필/감리군 output 세분화 | ✅ 설계 완료 |
| Phase 3 | 하네스 자동 판정 구현 | ⬜ 구현 예정 |
| Phase 4 | issue ledger 자동 적재 + regression 자동 예약 | ⬜ 구현 예정 |

---

*버전: v1.0 | 갱신일: 2026-04-02 | 소설: 너라는 운율*
