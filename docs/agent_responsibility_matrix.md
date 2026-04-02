# Agent Responsibility Matrix — novelwriter
## 소설: 너라는 운율 (120화 / 84만자)
> 이 문서는 에이전트별 역할, 권한 경계, 입출력, 금지 행동을 정의합니다.
> 모든 에이전트는 이 매트릭스를 준수해야 하며, 범위를 벗어난 판단은 금지됩니다.

---

## 계층 구조 요약

```
Story Program Manager (총괄)
│
├── Canon Governance Manager        ← NEW: Obsidian vault 신뢰성 관리
│   ├── Canon Priority Resolver ★  ← NEW: 충돌 노트 우선순위 결정
│   └── Evidence Binder ★          ← NEW: 증거 품질 검증
│
├── Lore & Canon Manager
│   ├── Canon Auditor ★
│   └── Timeline Auditor ★
├── Plot & Causality Manager
│   └── Plot Causality Inspector ★
├── Character Integrity Manager
│   ├── Motivation Checker ★
│   └── Voice Auditor ★
├── Narrative Craft Manager
│   ├── Scene Purpose Auditor ★
│   └── Pacing Auditor ★
├── Revision & Patch Manager
│   └── Minimal Patch Generator ★
└── Evidence & Memory Manager
    (모든 에이전트의 evidence 수집/저장)

★ = V1 핵심 specialist
⚠️ Canon Governance Manager는 모든 canon 조회 이전에 반드시 실행
```

---

## Obsidian = Single Source of Truth

```
읽기 순서 (모든 에이전트 준수):
  원고 읽기 → 캐논 조회 → 충돌 탐지 → 이슈 설명 → 최소 수정 제안

절대 규칙:
  - 원고는 최종 진실이 아님
  - 모델의 추론은 최종 진실이 아님
  - canon_status: official 노트만 최종 진실
  - deprecated / retconned 노트를 캐논 근거로 사용 금지
```

---

## 에이전트별 책임 정의

### 0. Story Program Manager

| 항목 | 내용 |
|------|------|
| **역할** | 전체 감사 파이프라인의 오케스트레이터 |
| **입력** | 원고 화(episode), 화 번호, 감사 범위 지시 |
| **출력** | 최종 종합 리포트 + 액션 지시 (pass/patch/rewrite/escalate) |
| **권한** | 모든 manager 호출 / 우선순위 결정 / 게이트 최종 판정 |
| **금지** | 직접 원고 수정 / 설정집 직접 수정 / 전문 검사를 우회 |
| **특수 규칙** | 충돌하는 manager 판정이 있을 경우 증거 기반 중재 필수 |

---

### 1. Canon Auditor

| 항목 | 내용 |
|------|------|
| **소속 Manager** | Lore & Canon Manager |
| **역할** | 원고와 설정집(lore) 간 모순 탐지 |
| **담당 도메인** | 운율 시스템 규칙, 캐릭터 속성, 세계관 설정, 고유명사 |
| **입력** | 원고 화 텍스트, `canon_entities` DB, `운율 시스템.md`, 캐릭터 시트 |
| **출력** | `issue_report[]` (type: canon_violation) |
| **검사 항목** | ① 운율 능력 규칙 위반 ② 캐릭터 외형/나이/소속 불일치 ③ 운율 소실 궤적 순서 위반 ④ 범위(3-5m) 규칙 위반 ⑤ 전화/영상 운율 감지 불가 규칙 위반 |
| **금지** | 설정집에 없는 정보를 사실로 단정 / 운율 규칙을 임의 해석 |
| **우선 캐논** | `/lore/02-세계관/운율 시스템.md` > 각 캐릭터 시트 > 원고 내 명시적 언급 순 |

**핵심 캐논 참조 목록 (반드시 체크)**
- 서준은 자신의 운율을 들을 수 없다 (절대 법칙)
- 전화·영상·녹음으로는 운율 감지 불가
- 파장 범위 반경 3-5m
- 운율 소실 5단계 순서: 아린 → 주변인 → 과거 환청 → 완전 소멸
- 지아린의 닫힘 = 완전한 무음 (불협화음이 아닌 무음)
- 자기기만 상태의 거짓말은 운율도 속는다

---

### 2. Timeline Auditor

| 항목 | 내용 |
|------|------|
| **소속 Manager** | Lore & Canon Manager |
| **역할** | 시간 흐름·날짜·기간·계절·사건 순서 검증 |
| **입력** | 원고 텍스트, `timeline_events` DB, Phase 요약 줄거리 |
| **출력** | `issue_report[]` (type: timeline_violation) |
| **검사 항목** | ① 계절/날씨 일관성 (3월 봄학기 시작 등) ② Phase 내 사건 순서 ③ 마일스톤 순서 (5화→24화→40화→60화→67화→80화→90화→93화→101화→116화→120화) ④ 6개월 후 시간 점프(Phase IV) 일관성 ⑤ 등장인물 나이·학년 일관성 |
| **금지** | 날짜 정보가 명시되지 않은 경우 임의 추정 후 오류 판정 |

**시간 앵커 포인트**
- 1화: 3월 첫째 주 월요일, 오전 8:50
- 서준 22세, 경영학과 2학년
- 아린 20세, 국문학과 1학년 (21학번)
- Phase IV 시작: 이별 후 6개월 경과

---

### 3. Plot Causality Inspector

| 항목 | 내용 |
|------|------|
| **소속 Manager** | Plot & Causality Manager |
| **역할** | 씬 간 인과관계, 동기→결과 연결고리 검증 |
| **입력** | 원고 텍스트, 이전 화 요약, 스토리 줄거리 파일 |
| **출력** | `issue_report[]` (type: causality_break) |
| **검사 항목** | ① A사건 → B결과 인과 타당성 ② 복선 → 회수 페어 추적 ③ 갑작스러운 전환에 브릿지 존재 여부 ④ 우연한 해결(데우스 엑스 마키나) 탐지 ⑤ 동기 없는 행동 변화 |
| **금지** | 작가 의도를 추정하여 무조건 정당화 / 복선 없는 요소를 "나중에 나올 것"으로 면죄 |

---

### 4. Motivation Checker

| 항목 | 내용 |
|------|------|
| **소속 Manager** | Character Integrity Manager |
| **역할** | 캐릭터의 행동이 해당 시점의 동기·심리 상태와 일치하는지 검증 |
| **입력** | 원고 텍스트, 캐릭터 시트, 해당 화의 캐릭터 아크 단계 |
| **출력** | `issue_report[]` (type: motivation_break) |
| **검사 항목** | ① 서준의 Arc 단계 (단절→파동→균열→상실→완전한 울림) 일관성 ② 아린의 Arc (호기심→끌림→사랑→의심→포기→정리) 일관성 ③ 트라우마(16세 사건) 반응 일관성 ④ 각 캐릭터 동기 역전 시 브릿지 존재 여부 |
| **금지** | Phase나 Arc 단계를 고려하지 않은 단편적 판단 |

**캐릭터 Arc 체크리스트**
```
서준 Arc:  단절(1-10화) → 파동(11-24화) → 균열(25-50화) → 상실(51-75화) → 울림(76-120화)
아린 Arc:  호기심(1-15화) → 끌림(16-25화) → 사랑(26-55화) → 의심(56-70화) → 정리(71-95화)
```

---

### 5. Voice Auditor

| 항목 | 내용 |
|------|------|
| **소속 Manager** | Character Integrity Manager |
| **역할** | 대사·내면 묘사의 캐릭터 보이스 일관성 검증 |
| **입력** | 원고 텍스트, 캐릭터 시트, 대표 대사 샘플 |
| **출력** | `issue_report[]` (type: voice_inconsistency) |
| **검사 항목** | ① 서준: 단답·존댓말 유지·감정 직접 표현 회피 일관성 ② 아린: 솔직함·감정 표현·거짓말 못 함 일관성 ③ 이든: 경쾌한 재즈 성격 반영 ④ 각 캐릭터 고유 어휘·문체 이탈 여부 ⑤ 현대적·메타적 표현 이탈 여부 |
| **판정 기준** | 동일 Arc 단계 내 다른 화의 동일 캐릭터 대사와 비교 |
| **금지** | 성격 발전에 의한 정당한 변화를 오류로 판정 |

---

### 6. Scene Purpose Auditor

| 항목 | 내용 |
|------|------|
| **소속 Manager** | Narrative Craft Manager |
| **역할** | 씬의 서사적 기능 검증 (최소 1개 이상 충족 필수) |
| **입력** | 원고 텍스트, 씬 목록 |
| **출력** | `issue_report[]` (type: scene_purpose_fail) |
| **기능 체크리스트** | ① 플롯 진행 ② 캐릭터 심화 ③ 긴장감 증가 ④ 정보 공개 ⑤ 관계 변화 ⑥ 복선 설치/회수 |
| **FAIL 조건** | 6개 기능 중 어느 것도 충족하지 못하는 장식적 씬 |
| **특수 예외** | 감성적 호흡 씬(분위기 조성)은 "캐릭터 심화" 또는 "긴장감 조절"로 인정 가능 - 단 연속 2개 이상 배치 금지 |

---

### 7. Pacing Auditor

| 항목 | 내용 |
|------|------|
| **소속 Manager** | Narrative Craft Manager |
| **역할** | 화 내·화 간 페이싱, 긴장 리듬, 서사 속도 검증 |
| **입력** | 원고 텍스트 + 전후 3화 요약 |
| **출력** | `issue_report[]` (type: pacing_issue) |
| **검사 항목** | ① 서술 밀도 vs 대화 밀도 균형 ② 긴장감 없는 연속 화 수 (3화 이상 연속 이완 = soft_fail) ③ 클리프행어 품질 ④ 7,000자 기준 호흡점 배치 ⑤ 운율 묘사 과잉/부족 |
| **소프트 게이트** | 연속 3화 이상 긴장 이완 → 경고 |
| **금지** | Phase별 의도된 호흡 구간을 페이싱 오류로 판정 (설계 의도 확인 먼저) |

---

### 8. Minimal Patch Generator

| 항목 | 내용 |
|------|------|
| **소속 Manager** | Revision & Patch Manager |
| **역할** | 발견된 이슈에 대한 최소 비용 수정안 생성 |
| **입력** | `issue_report`, 원고 텍스트, 설정집, 캐릭터 보이스 샘플 |
| **출력** | `patch_proposal` (before/after diff + risk_note) |
| **수정 단계 분류** | note(1줄 메모) / line_edit(1-5줄) / scene_patch(6-30줄) / chapter_patch(1화 재작성) / arc_rewrite(다중화 재구성) |
| **원칙** | ① 최소 개입 ② 작가 문체 보존 ③ 운율 묘사 스타일 유지 ④ 새 설정 창조 금지 ⑤ 이미 수정된 이슈 중복 수정 금지 |
| **금지** | arc_rewrite 단독 제안 (반드시 인간 승인 필요 표시) / 운율 규칙을 임의 변경하는 픽스 |

---

### 9. Canon Governance Manager

| 항목 | 내용 |
|------|------|
| **역할** | Obsidian vault의 신뢰성 관리 — 어떤 노트가 공식 캐논인지 판정 |
| **입력** | 접근된 모든 lore 노트 + 프론트매터 메타데이터 |
| **출력** | 승인된 canon 소스 목록, 충돌 이슈(CG-XXX), alias 정규화 결과 |
| **권한** | deprecated/retconned 노트 감사 제외 결정 / 충돌 노트 에스컬레이션 |
| **금지** | 노트 내용 직접 수정 / 작가 의도 임의 판단 / 내용 기반 우선순위 결정 |
| **실행 시점** | ⚠️ 모든 canon 조회 이전에 반드시 먼저 실행 |

**canon_status 판정 기준**:
- `official` → 하드 게이트 판정에 사용
- `provisional` → soft_fail 근거만
- `draft` → 참고용만
- `deprecated` / `retconned` → 감사 완전 제외

---

### 10. Canon Priority Resolver

| 항목 | 내용 |
|------|------|
| **소속 Manager** | Canon Governance Manager |
| **역할** | 충돌하는 설정집 노트들의 우선순위를 메타데이터 기반으로 결정 |
| **입력** | 동일 개체에 대한 복수 노트 + 프론트매터 |
| **출력** | `winner`, `loser`, 권장 액션 |
| **결정 기준** | canon_status → source_priority → last_reviewed → 문서 계층 순 |
| **금지** | "이쪽이 더 말이 된다"는 내용 판단으로 우선순위 결정 |

---

### 11. Evidence Binder

| 항목 | 내용 |
|------|------|
| **소속 Manager** | Canon Governance Manager (및 Evidence & Memory Manager) |
| **역할** | 모든 에이전트의 이슈 클레임에 정확한 증거 바인딩 및 품질 검증 |
| **입력** | 모든 에이전트의 raw issue_report[], 원고 텍스트, lore 소스 |
| **출력** | approved/downgraded/discarded 이슈 분류 + inference 교정 |
| **승인 기준** | 원문 인용 확인 + 사실/추론 분리 + canon_status 검증 |
| **금지** | 증거 없는 이슈 통과 허용 / deprecated 노트 인용 이슈 승인 |

---

### 12. Evidence & Memory Manager

| 항목 | 내용 |
|------|------|
| **역할** | 모든 에이전트의 클레임에 증거 바인딩, 이슈 원장 관리 |
| **입력** | 모든 에이전트의 raw output |
| **출력** | `evidence_bound_report`, `issue_ledger` 업데이트 |
| **책임** | ① 모든 이슈에 원문 인용 바인딩 ② 중복 이슈 탐지 및 병합 ③ 해결된 이슈 아카이브 ④ 반복 패턴 추적 |
| **금지** | 증거 없는 클레임 승인 / 인용 없는 이슈 리포트 통과 |

---

## 에이전트 간 충돌 해결 규칙

1. **동일 이슈, 다른 심각도**: 높은 심각도 채택 + 근거 명시
2. **서로 모순되는 판정**: Story PM이 증거 기반 중재
3. **설정집 vs 원고 충돌**: 설정집 우선 (단, 명백한 설정집 오류는 human escalation)
4. **추론 vs 사실 충돌**: 인용 가능한 사실 우선, 추론은 inference 태그 필수

---

## 운율 시스템 전용 체크리스트 (Cross-Agent)

모든 에이전트가 운율 관련 씬에서 공통 체크해야 할 항목:

- [ ] 서준이 자신의 운율을 직접 듣는 씬 → **즉시 Canon Hard Fail**
- [ ] 전화/영상 통화 중 운율 묘사 → **즉시 Canon Hard Fail**
- [ ] 운율 범위 3-5m 초과 → **Canon Fail**
- [ ] 운율 소실 단계가 역순 진행 → **Canon Fail**
- [ ] 지아린 닫힘 시 불협화음 묘사 → **Canon Fail** (무음이 정확)
- [ ] 완벽한 자기기만 상태에서 운율 탐지 성공 → **Canon Fail**

---

*버전: v1.0 | 생성일: 2026-04-02 | 소설: 너라는 운율*
