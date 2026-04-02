# Harness Specification — 2-Layer Harness Architecture
## 너라는 운율 | novelwriter v1

---

## 개요

하네스는 **공통 하네스 1개 + 영역별 하네스 3개** = 총 4개로 구성됩니다.

```
┌─────────────────────────────────────────────────┐
│           공통 하네스 (Global Harness)             │
│     전체 시스템 공통 규칙 / 프로젝트 범위 / 게이트    │
└────────────────────────────────────────────────┘
          │               │               │
          ▼               ▼               ▼
┌──────────────┐  ┌──────────────┐  ┌──────────────┐
│  설계 하네스  │  │  집필 하네스  │  │  감리 하네스  │
│ (Design)     │  │ (Writing)    │  │ (Audit)      │
└──────────────┘  └──────────────┘  └──────────────┘
```

**설계 원칙**:
- 공통 하네스는 모든 에이전트 실행 전·후에 적용
- 영역 하네스는 해당 군 에이전트 실행 전·후에 추가 적용
- 하네스는 에이전트를 차단하거나 경고를 발생시키되, 직접 수정하지 않음

---

## 1. 공통 하네스 (Global Harness)

### 1-1. 역할

전체 시스템에 공통으로 적용되는 규칙.
어떤 군(설계/집필/감리)의 에이전트를 실행하든 반드시 통과해야 합니다.

### 1-2. 공통 하네스 규칙

#### 프로젝트 범위 체크

```
실행 전:
[ ] 작업 대상이 현재 프로젝트(nry)에 속하는가?
    → 아님: 작업 범위 오류, 총괄 PM에 에스컬레이션

[ ] 참조하는 설정 노트가 현재 프로젝트(project_id: nry)의 것인가?
    → 아님: 교차 프로젝트 오염 경고
```

#### Canon Status 필터

```
실행 전:
[ ] 참조하는 설정의 canon_status는?
    official     → 하드 게이트 판정에 사용 가능
    provisional  → soft fail 근거로만 사용
    draft        → 참고 가능, 판정 근거 불가
    deprecated   → 참조 금지 (자동 차단)
    retconned    → 참조 금지 (자동 차단)

[ ] deprecated / retconned 설정이 참조되었는가?
    → 있음: 즉시 차단 + "사용 금지 설정 참조" 경고 발행
```

#### 저장 포맷 통일

```
실행 후:
[ ] 출력이 해당 에이전트의 JSON Schema를 준수하는가?
    → 아님: schema_validator 실행 + 오류 항목 명시

[ ] 필수 필드가 모두 있는가?
    (agent, summary, confidence 등)
    → 없음: 출력 거부 + 필드 누락 목록 반환
```

#### 이슈 원장 갱신

```
실행 후:
[ ] 이번 실행에서 새 이슈가 발생했는가?
    → 있음: issue_ledger_write 자동 실행
    → 이슈 ID 자동 채번 (형식: ISS-{화번호}-{순번})

[ ] 기존 이슈가 해결되었는가?
    → 있음: 해당 이슈 status를 "resolved"로 갱신
```

#### 버전 / 로그 관리

```
실행 후:
[ ] 이번 실행 로그가 기록되었는가?
    → 항목: 실행 에이전트, 시각, 입력 요약, 출력 요약, 이슈 수
```

### 1-3. 공통 하네스 출력 포맷

```json
{
  "harness": "global",
  "project_id": "nry",
  "run_id": "run_20260402_001",
  "agent_run": "Canon Auditor",
  "pre_check": {
    "project_scope_ok": true,
    "canon_status_filter": {
      "deprecated_blocked": 0,
      "retconned_blocked": 0
    }
  },
  "post_check": {
    "schema_valid": true,
    "required_fields_present": true,
    "issues_logged": 2,
    "issues_resolved": 0
  },
  "log_entry": {
    "timestamp": "2026-04-02T10:30:00",
    "input_summary": "ep_041 원고",
    "output_summary": "이슈 2건 (major 1, minor 1)"
  }
}
```

---

## 2. 설계 하네스 (Design Harness)

### 2-1. 역할

설계군 에이전트(D-01~D-06) 실행 시 추가로 적용되는 규칙.
**창작 자유는 주되, 미정/실험/확정을 섞지 않게 통제합니다.**

### 2-2. 설계 하네스 규칙

#### 설계 단계 검증

```
실행 전:
[ ] 현재 설계 단계가 명확히 지정되었는가?
    (세계관 설계 / 플롯 설계 / 캐릭터 설계 / 결말 설계)
    → 미지정: 설계 단계 지정 요청

[ ] 이 설계가 이미 확정된 내용을 변경하려 하는가?
    → 있음: "확정 설정 변경 시도" 경고
    → Canon Governance Manager 승인 필요
```

#### 미확정 설정 보호

```
실행 중:
[ ] draft 상태의 설정을 official처럼 사용하는가?
    → 있음: "미확정 설정 오용" 경고 + 해당 내용 [미정] 태그 강제 부착

[ ] 캐논에 없는 내용이 설계에 포함되었는가?
    → 있음: new_canon_candidate 태그 자동 부착
```

#### 설계 결과 분류 강제

```
실행 후:
[ ] 설계 결과가 확정/가안/실험 중 하나로 분류되었는가?
    → 미분류: 분류 선택 강제

[ ] 실험안이 확정안 파일에 포함되어 있는가?
    → 있음: 분리 저장 강제
```

#### 캐논 충돌 사전 검사

```
실행 후:
[ ] 설계안이 기존 official 설정과 충돌하는가?
    → 있음: 충돌 내용 명시 + 해결 옵션 제시
    → 충돌 미해결 상태로 확정안 승격 불가
```

### 2-3. 설계 하네스 상태 전이

```
[설계 요청]
     ↓
[설계 단계 확인]
     ↓
[canon_lookup] ──→ deprecated 참조? ──→ [차단]
     ↓ No
[서브 에이전트 실행]
     ↓
[캐논 충돌 검사]
     ├── 충돌 없음 ──→ [결과 분류] ──→ [확정/가안/실험]
     └── 충돌 있음 ──→ [충돌 명시] ──→ [작가 판단 대기]
```

### 2-4. 설계 하네스 출력 포맷

```json
{
  "harness": "design",
  "design_stage": "플롯 설계",
  "pre_check": {
    "stage_defined": true,
    "confirmed_content_change_attempt": false
  },
  "during_check": {
    "draft_used_as_official": false,
    "new_canon_candidates": [
      { "content": "운율 소실 1단계: 47화 전후", "risk": "medium" }
    ]
  },
  "post_check": {
    "result_classified": true,
    "classification": "provisional",
    "canon_conflicts": [],
    "experimental_isolated": true
  }
}
```

---

## 3. 집필 하네스 (Writing Harness)

### 3-1. 역할

집필군 에이전트(W-01~W-07) 실행 시 추가로 적용되는 규칙.
**잘 쓰게 하는 것보다, 잘못 쓰지 않게 하는 통제 장치.**

### 3-2. 집필 하네스 규칙

#### 초안 생성 사전 조건

```
초안 생성 전 (모두 통과해야 실행 가능):
[ ] 씬 목적(scene_goal)이 정의되어 있는가?
    → 미정의: Scene Designer 호출 강제, 초안 생성 대기

[ ] canon_lookup이 실행되었는가?
    → 미실행: 캐논 조회 후 재시작

[ ] 대사 생성 시 캐릭터 보이스 프로필이 있는가?
    → 없음: voice_profile_lookup 실행 강제
```

#### 초안 생성 중 감시

```
초안 생성 중:
[ ] 캐릭터가 현재 Arc 단계에 맞지 않는 행동을 하는가?
    → 있음: "Arc 불일치" 경고 (중단하지 않고 태그만)

[ ] 운율 시스템 관련 새로운 규칙이 임의로 생성되었는가?
    → 있음: 즉시 중단 + Canon Auditor 호출
```

#### 초안 생성 후 검사

```
초안 생성 후:
[ ] 시점(POV) 위반이 있는가?
    → 있음: pov_constraint_checker 실행, 위반 위치 명시

[ ] 신규 설정이 캐논 검증 없이 포함되었는가?
    → 있음: new_canon_candidate 태그 + Canon Governance Manager 통보

[ ] 연속 설명(exposition)이 500자를 초과하는가?
    → 있음: exposition_density_checker 결과 + 조정 권장

[ ] 감정 상태가 브리지 없이 급격히 변했는가?
    → 있음: Bridge Scene Generator 호출 권장 (강제 아님)
```

### 3-3. 집필 하네스 상태 전이

```
[집필 요청]
     ↓
[씬 목적 확인] ──→ 미정의? ──→ [Scene Designer 호출] ──→ [대기]
     ↓ OK
[캐논 조회] ──→ deprecated? ──→ [차단]
     ↓ OK
[보이스 프로필 확인] ──→ 없음? ──→ [lookup 실행]
     ↓ OK
[초안 생성]
     ↓
[POV 체크] ──→ 위반? ──→ [위반 위치 태그]
     ↓
[신규 설정 체크] ──→ 있음? ──→ [태그 + 통보]
     ↓
[Exposition 밀도 체크]
     ↓
[감리군 전달 포맷 생성]
```

### 3-4. 집필 하네스 출력 포맷

```json
{
  "harness": "writing",
  "episode": 41,
  "pre_check": {
    "scene_goal_defined": true,
    "canon_lookup_done": true,
    "voice_profile_available": true
  },
  "during_check": {
    "arc_mismatch_warning": false,
    "rhyme_system_new_rule_attempt": false
  },
  "post_check": {
    "pov_violation": false,
    "pov_violation_locations": [],
    "new_canon_candidates": [],
    "exposition_over_500": false,
    "bridge_recommended": false
  },
  "audit_ready": true
}
```

---

## 4. 감리 하네스 (Audit Harness)

### 4-1. 역할

감리군 에이전트(A-01~A-10) 실행 시 추가로 적용되는 규칙.
**품질관리와 차단 장치. 증거 없는 지적은 존재할 수 없다.**

### 4-2. 감리 하네스 규칙

#### 이슈 발행 사전 조건

```
이슈 발행 전:
[ ] 이슈에 증거가 있는가?
    증거 = 설정집 노트 ID + 인용 + 화·씬 위치
    → 없음: 이슈 기각 또는 "evidence_missing" 상태로 보류

[ ] confidence 점수가 있는가?
    → 없음: 자동으로 0.5 부여 (불확실 처리)
    → 0.5 미만: severity 한 단계 하향 강제
    → 0.3 미만: 이슈 기각
```

#### 하드 게이트 강제

```
판정 중:
[ ] 하드 게이트 위반이 있는가?
    (운율 법칙 / 마일스톤 순서 / 핵심 전환 브리지 누락 / Arc 역행 / 보이스 완전 이탈)
    → 있음:
      blocked_for_publish = true
      이후 소프트 게이트 에이전트 실행 중단
      Audit Manager에 즉시 보고
      Writing Manager에 리워크 요청 자동 발행
```

#### 이슈 중복 제거

```
병합 전:
[ ] 동일 문제가 복수 에이전트에서 발생했는가?
    → 있음: issue_deduper 실행
    → 가장 상세한 이슈를 기준으로 병합
    → 병합된 이슈 수 기록
```

#### 치명도 분류 강제

```
최종화 전:
[ ] 모든 이슈에 치명도가 분류되었는가?
    (critical / major / minor / info)
    → 미분류: 분류 강제 요청

[ ] critical 이슈가 있는데 blocked_for_publish = false인가?
    → 오류: blocked_for_publish 강제 갱신
```

#### 회귀검사 관리

```
리워크 완료 후:
[ ] 수정된 이슈의 회귀검사가 예약되었는가?
    → 없음: 회귀검사 자동 예약

[ ] 회귀검사 실행 시 수정 이전 이슈가 다시 발생했는가?
    → 있음: "회귀 이슈" 별도 분류
```

### 4-3. 감리 하네스 상태 전이

```
[감리 요청]
     ↓
[감리 범위 지정]
     ↓
[에이전트 순차 실행]
     ↓
[이슈 수신]
     ├── 증거 없음? ──→ [기각 / evidence_missing]
     ├── confidence < 0.3? ──→ [기각]
     └── 통과 ──→ [이슈 등록]
     ↓
[하드 게이트 판정]
     ├── 위반 있음 ──→ [blocked_for_publish = true] ──→ [중단]
     └── 없음 ──→ [소프트 게이트 계속]
     ↓
[이슈 중복 제거]
     ↓
[치명도 분류]
     ↓
[최종 판정 발행]
     ↓
[리워크 요청 발행 / 회귀검사 예약]
```

### 4-4. 감리 하네스 출력 포맷

```json
{
  "harness": "audit",
  "audit_scope": "ep_041",
  "pre_check": {
    "all_issues_have_evidence": true,
    "low_confidence_downgraded": 1,
    "issues_rejected": 0
  },
  "hard_gate_check": {
    "violations": [],
    "blocked_for_publish": false
  },
  "post_check": {
    "duplicates_merged": 1,
    "severity_classified": true,
    "issue_counts": {
      "critical": 0,
      "major": 1,
      "minor": 2,
      "info": 1
    }
  },
  "rework": {
    "requests_issued": 1,
    "regression_checks_scheduled": 1
  }
}
```

---

## 5. 4개 하네스 비교표

| 항목 | 공통 하네스 | 설계 하네스 | 집필 하네스 | 감리 하네스 |
|------|----------|----------|----------|----------|
| **적용 대상** | 전체 에이전트 | 설계군 에이전트 | 집필군 에이전트 | 감리군 에이전트 |
| **핵심 통제** | 프로젝트 범위 / canon_status | 설계 단계 / 미확정 설정 보호 | 초안 생성 조건 / POV | 하드 게이트 / 증거 요구 |
| **차단 조건** | deprecated 참조 / 스키마 오류 | 확정 내용 무단 변경 / 충돌 설계 | 씬 목적 미정의 / 운율 신규 규칙 | 하드 게이트 위반 / 증거 없는 이슈 |
| **경고 조건** | 교차 프로젝트 오염 | draft 설정 오용 | Arc 불일치 / 설명 과다 | low confidence / 중복 이슈 |
| **자동 실행** | issue_ledger_write / schema_validator | new_canon_candidate 태그 | pov_constraint_checker | issue_deduper / citation_builder |
| **핵심 원칙** | "전체 규칙 통일" | "창작 자유 + 혼동 방지" | "잘못 쓰지 않게" | "증거 기반 판정" |

---

## 6. 하네스 적용 타임라인 (전체 흐름)

```
[작업 시작]
     ↓
[공통 하네스] ←── 프로젝트 범위 / canon_status 필터
     ↓
     ├── 설계 작업? ──→ [설계 하네스] ──→ [설계 에이전트 실행]
     │                         ↓
     │               [설계 하네스 사후 체크]
     │
     ├── 집필 작업? ──→ [집필 하네스] ──→ [집필 에이전트 실행]
     │                         ↓
     │               [집필 하네스 사후 체크]
     │
     └── 감리 작업? ──→ [감리 하네스] ──→ [감리 에이전트 실행]
                               ↓
                     [감리 하네스 사후 체크]
     ↓
[공통 하네스] ←── 이슈 원장 갱신 / 로그 기록 / 스키마 검증
     ↓
[작업 완료]
```

---

## 7. 구현 우선순위

```
V1 (프롬프트 레벨): ✅ 완료
  → 각 매니저 프롬프트에 하네스 체크리스트 포함
  → 에이전트 프롬프트에 Hard Rules로 반영

V2 (Python 모듈):
  → global_harness.py    — 공통 하네스 클래스
  → design_harness.py    — 설계 하네스 클래스
  → writing_harness.py   — 집필 하네스 클래스
  → audit_harness.py     — 감리 하네스 클래스
  → harness_runner.py    — 2층 하네스 실행기

V3 (MCP 연동):
  → MCP Filesystem 서버와 canon_lookup 연결
  → issue_ledger_write → Obsidian vault 직접 갱신
```

---

*버전: v1.0 | 생성일: 2026-04-02 | 소설: 너라는 운율*
