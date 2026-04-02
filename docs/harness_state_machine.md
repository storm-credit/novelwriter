# Harness State Machine — novelwriter
## 소설: 너라는 운율

> 하네스는 에이전트 파이프라인의 "교통경찰"입니다.
> 어떤 에이전트도 하네스의 승인 없이 다음 단계로 진행할 수 없습니다.
> 모든 게이트는 증거 기반으로만 통과/차단이 결정됩니다.

---

## 전체 파이프라인 흐름

```
[INTAKE] ──► [ROUTING] ──► [PHASE_1_AUDIT] ──► [MERGE] ──► [GATE_CHECK]
                                                                   │
                          ┌────────────────────────────────────────┘
                          ▼
                    [HARD_GATE?]
                    /           \
                 FAIL           PASS
                  │               │
             [BLOCK]         [REPAIR]
                  │               │
           [HUMAN_ESCALATE]  [REGRESSION]
                                  │
                           [PROMOTE/ARCHIVE]
```

---

## 상태 정의 (States)

### Phase 0: INTAKE
**목적**: 원고 수신·버전 해싱·컨텍스트 로딩

```
상태명: INTAKE
입력:
  - episode_number: int          # 감사할 화 번호
  - file_path: str               # 원고 파일 경로
  - audit_scope: str             # "episode" | "chapter" | "phase"
  - incremental: bool            # 변경분만 감사할지 여부

처리:
  1. 원고 파일 읽기 및 버전 해시 생성 (SHA-256)
  2. 이전 버전과 diff 계산 (incremental=true 시 변경 범위만 추출)
  3. 의존 컨텍스트 로딩:
     - 이전 3화 요약
     - 해당 Phase 줄거리
     - 마일스톤 체크리스트
     - 이슈 원장 (기존 open 이슈)
  4. story_unit 레코드 생성/업데이트

출력: INTAKE_COMPLETE | INTAKE_FAILED

INTAKE_FAILED 조건:
  - 파일 없음
  - 버전 해시 충돌 (이미 동일 버전 감사됨)
  - 필수 컨텍스트 파일 누락
```

---

### Phase 1: ROUTING
**목적**: 어떤 manager/agent를 활성화할지 결정

```
상태명: ROUTING
입력: INTAKE_COMPLETE 결과

처리:
  1. 화 번호를 기준으로 해당 Phase, Chapter, 마일스톤 확인
  2. 변경 범위 분석 (운율 씬 포함 여부 → Canon Manager 필수 활성화)
  3. Manager 활성화 목록 결정:

  항상 활성화 (ALL):
    - Lore & Canon Manager (운율 시스템 체크 필수)
    - Character Integrity Manager

  조건부 활성화:
    - Plot & Causality Manager → 마일스톤 화이거나 주요 전환점 포함 시
    - Narrative Craft Manager → 7,000자 기준 ±20% 이탈 또는 클리프행어 화 시
    - Revision & Patch Manager → 이전 감사에서 open 이슈 존재 시

  특수 룰:
    - 운율 소실 관련 씬 (51화~) → Canon Manager PRIORITY 상향
    - 마일스톤 화 → 모든 Manager 활성화
    - Phase 첫 화 (1화, 26화, 51화, 76화, 96화) → 모든 Manager 활성화

출력: ROUTING_PLAN { active_managers: [], priority_flags: [] }
```

---

### Phase 2: PHASE_1_AUDIT
**목적**: 병렬 1차 감사 실행 (증거 수집만, 대규모 수정 없음)

```
상태명: PHASE_1_AUDIT
입력: ROUTING_PLAN

처리 (병렬 실행):
  ┌─────────────────────────────────────────────────┐
  │ Lore & Canon Manager                            │
  │   ├── Canon Auditor          [필수]              │
  │   └── Timeline Auditor       [필수]              │
  ├─────────────────────────────────────────────────┤
  │ Character Integrity Manager                     │
  │   ├── Motivation Checker     [필수]              │
  │   └── Voice Auditor          [필수]              │
  ├─────────────────────────────────────────────────┤
  │ Plot & Causality Manager     [조건부]            │
  │   └── Plot Causality Inspector                  │
  ├─────────────────────────────────────────────────┤
  │ Narrative Craft Manager      [조건부]            │
  │   ├── Scene Purpose Auditor                     │
  │   └── Pacing Auditor                            │
  └─────────────────────────────────────────────────┘

각 에이전트 출력: issue_report[] (JSON Schema 준수 필수)
타임아웃: 에이전트당 최대 60초

출력: AUDIT_RESULTS { issues_by_domain: {}, raw_reports: [] }
```

---

### Phase 3: MERGE
**목적**: 도메인 간 결과 통합, 중복 제거, 우선순위 정렬

```
상태명: MERGE
입력: AUDIT_RESULTS

처리:
  1. Evidence & Memory Manager 실행:
     a. 모든 이슈에 원문 인용 바인딩 확인
     b. 증거 없는 이슈 → DISCARD (discarded_issues 목록에 기록)
     c. 이슈 원장과 대조 → 이미 알려진 이슈는 중복 병합
     d. 동일 씬·동일 내용 다른 에이전트 발견 → dedup + 합산 confidence

  2. 우선순위 정렬:
     critical > high > medium > low
     운율 시스템 관련 이슈 → 동급 내 우선 처리

  3. Manager별 종합 판정 생성 (manager_verdict)

출력: MERGED_REPORT {
  total_issues: int,
  by_severity: { critical, high, medium, low },
  discarded: int,
  manager_verdicts: manager_verdict[],
  has_hard_gate_violations: bool
}
```

---

### Phase 4: GATE_CHECK
**목적**: 하드 게이트 / 소프트 게이트 판정

```
상태명: GATE_CHECK
입력: MERGED_REPORT

하드 게이트 (FAIL = 즉시 BLOCK):
  ┌──────────────────┬────────────────────────────────────────────────┐
  │ Gate ID          │ 조건                                           │
  ├──────────────────┼────────────────────────────────────────────────┤
  │ CANON_GATE       │ 운율 시스템 절대 법칙 위반                      │
  │                  │ (자기청취/원격감지/범위초과/소실역순/닫힘오류)  │
  ├──────────────────┼────────────────────────────────────────────────┤
  │ TIMELINE_GATE    │ 마일스톤 순서 위반 / 불가능한 시간 압축         │
  ├──────────────────┼────────────────────────────────────────────────┤
  │ MOTIVATION_GATE  │ 주요 전환점에서 브릿지 없는 동기 역전           │
  ├──────────────────┼────────────────────────────────────────────────┤
  │ KNOWLEDGE_GATE   │ 캐릭터가 알 수 없는 정보 접근 (운율로 불가한   │
  │                  │ 정보 포함)                                      │
  ├──────────────────┼────────────────────────────────────────────────┤
  │ PAYOFF_GATE      │ 핵심 복선 없이 결정적 반전 배치                 │
  ├──────────────────┼────────────────────────────────────────────────┤
  │ POV_GATE         │ 시점 인물이 알 수 없는 정보 서술                │
  └──────────────────┴────────────────────────────────────────────────┘

소프트 게이트 (WARN = 경고, 블록 아님):
  - 연속 3화 이상 긴장감 이완
  - 7,000자 기준 30% 이상 이탈
  - 동일 캐릭터 대사 패턴 3회 이상 반복
  - 씬 목적 불명확 (soft_fail 수준)
  - 운율 묘사 밀도 불균형

판정 결과:
  - HARD_FAIL: 하나 이상의 하드 게이트 위반 → BLOCK
  - SOFT_FAIL: 소프트 게이트만 위반 → REPAIR (선택적)
  - PASS: 모든 게이트 통과 → PROMOTE
```

---

### Phase 5a: BLOCK
**목적**: 하드 게이트 위반 시 처리

```
상태명: BLOCK
입력: GATE_CHECK (HARD_FAIL)

처리:
  1. blocked_report 생성 (위반 게이트 + 이슈 + 증거 명시)
  2. human_escalation_required 플래그 설정
  3. 자동 패치 가능 여부 판단:
     - line_edit / scene_patch 범위 → Minimal Patch Generator 실행 (제안만)
     - chapter_patch 이상 → 인간 결정 필요
  4. 이슈 원장에 블록 이유 기록

출력: BLOCK_REPORT → HUMAN_QUEUE 또는 AUTO_PATCH_ATTEMPT
```

---

### Phase 5b: REPAIR
**목적**: 소프트 게이트 또는 자동 패치 가능 이슈 처리

```
상태명: REPAIR
입력: GATE_CHECK (SOFT_FAIL 또는 AUTO_PATCH_ATTEMPT)

처리:
  1. Minimal Patch Generator 실행
  2. 이슈별 최소 비용 수정안 생성
  3. 각 수정안에 대해:
     - voice_preservation_check 실행
     - new_canon_introduced 확인 → true이면 인간 승인 필요 태그
  4. 대안 수정안 최대 2개 추가 생성

출력: PATCH_SET { patches: patch_proposal[] }
       → REGRESSION_CHECK
```

---

### Phase 6: REGRESSION_CHECK
**목적**: 수정안 적용 후 새로운 모순 생성 여부 확인

```
상태명: REGRESSION_CHECK
입력: PATCH_SET

처리:
  1. 수정 범위에 영향받는 에이전트만 재실행 (전체 재감사 아님)
  2. 새로 생성된 이슈 여부 확인
  3. 수정 전 이슈가 실제로 해결되었는지 확인

  재실행 필요 에이전트 결정 룰:
    - Canon 관련 수정 → Canon Auditor 재실행
    - 대사 수정 → Voice Auditor 재실행
    - 씬 구조 변경 → Scene Purpose Auditor + Pacing Auditor 재실행
    - 타임라인 변경 → Timeline Auditor 재실행

출력:
  - REGRESSION_PASS: 새 이슈 없음 → PROMOTE
  - REGRESSION_FAIL: 새 이슈 발생 → REPAIR (재진입) 또는 HUMAN_ESCALATE
  - 최대 재진입 횟수: 3회 (초과 시 HUMAN_ESCALATE)
```

---

### Phase 7: PROMOTE / ARCHIVE
**목적**: 감사 완료 처리

```
상태명: PROMOTE
입력: REGRESSION_PASS

처리:
  1. 원고 파일 상태 → "audited" 업데이트
  2. 최종 감사 리포트 저장 (reports/{episode_id}_{version_hash}.json)
  3. 해결된 이슈 → "resolved" 상태로 아카이브
  4. 잔여 open 이슈 → 이슈 원장 유지 (다음 화 감사 시 컨텍스트 제공)
  5. story_unit.audit_version 업데이트

출력: AUDIT_COMPLETE { episode_id, report_path, open_issues_count, resolved_count }
```

---

## 상태 전이 다이어그램

```
INTAKE ──(success)──► ROUTING ──► PHASE_1_AUDIT ──► MERGE ──► GATE_CHECK
   │                                                               │
   └──(failed)──► ERROR_REPORT                               ┌────┴────┐
                                                             │         │
                                                          HARD_FAIL  PASS/SOFT
                                                             │         │
                                                           BLOCK     REPAIR ◄─────┐
                                                             │         │           │
                                                      ┌──────┴──┐     └──► REGRESSION_CHECK
                                                      │         │               │         │
                                                   AUTO_PATCH  HUMAN      PASS       FAIL(≤3)
                                                      │                    │              │
                                                      └──────────► PROMOTE  └──► REPAIR (재진입)
                                                                      │
                                                                   ARCHIVE
```

---

## 예산 및 제한

| 항목 | 제한 |
|------|------|
| 에이전트당 최대 실행 시간 | 60초 |
| 전체 파이프라인 최대 시간 | 10분 |
| REPAIR 재진입 최대 횟수 | 3회 |
| 최대 패치 대안 수 | 3개 |
| 증거 없는 이슈 | 즉시 폐기 |
| 추론 기반 hard_fail | 금지 (confidence ≥ 0.8 필수) |

---

## 게이트별 한국어 요약

| 게이트 | 이름 | 핵심 질문 |
|--------|------|-----------|
| CANON_GATE | 캐논 게이트 | 운율 법칙·설정집과 모순이 있나? |
| TIMELINE_GATE | 타임라인 게이트 | 시간 흐름이 불가능하거나 마일스톤 순서가 틀렸나? |
| MOTIVATION_GATE | 동기 게이트 | 행동 변화에 납득할 만한 이유가 있나? |
| KNOWLEDGE_GATE | 지식 게이트 | 캐릭터가 알 수 없는 정보를 알고 행동하나? |
| PAYOFF_GATE | 보상 게이트 | 핵심 반전에 충분한 복선이 있나? |
| POV_GATE | 시점 게이트 | 시점 인물이 알 수 없는 정보가 서술되나? |

---

*버전: v1.0 | 생성일: 2026-04-02 | 소설: 너라는 운율*
