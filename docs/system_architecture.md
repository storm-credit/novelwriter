# System Architecture — Canon-driven Writing OS
## 소설: 너라는 운율 | novelwriter v3

---

## 프로젝트 정의

> **"옵시디언 설정집을 정본으로 삼아,**
> **설정 설계 · 스토리 구조 설계 · 집필 지원 · 개연성 감리를 통합하는**
> **다중 에이전트 소설 운영 시스템"**

---

## 핵심 원칙

```
중심은 원고가 아니다. 중심은 설정집(캐논)이다.
설정집 → 설계 → 집필 → 감리 → 설정집 갱신 (순환)

설계군 : "무엇을 어떻게 짤 것인가"
집필군 : "이걸 실제 문장/장면으로 어떻게 구현할 것인가"
감리군 : "이게 맞는가 / 안전한가 / 개연적인가"
```

---

## 1. 전체 조직도

```
┌──────────────────────────────────────────────────────┐
│              Story Program Manager                    │
│              (총괄 PM / 오케스트레이터)                 │
└────────────────────────┬─────────────────────────────┘
                         │
        ┌────────────────┼────────────────┐
        ▼                ▼                ▼
┌──────────────┐  ┌──────────────┐  ┌──────────────┐
│  설계군       │  │  집필군       │  │  감리군       │
│ DESIGN WING  │  │ WRITING WING │  │  AUDIT WING  │
│              │  │              │  │              │
│ Story Design │  │  Writing     │  │  Audit       │
│   Manager    │  │  Manager     │  │  Manager     │
│              │  │              │  │              │
│ 서브 에이전트  │  │ 서브 에이전트  │  │ 서브 에이전트  │
│ 설계 스킬     │  │ 집필 스킬     │  │ 감리 스킬     │
│ [설계 하네스] │  │ [집필 하네스] │  │ [감리 하네스] │
└──────────────┘  └──────────────┘  └──────────────┘
        │                │                │
        └────────────────┼────────────────┘
                         ▼
        ┌────────────────────────────────┐
        │         공통 하네스              │
        │  라우팅 / 권한 / 캐논 참조 범위   │
        │  게이트 / 저장 / 로그 / 이슈      │
        └────────────────────────────────┘
                         │
                         ▼
        ┌────────────────────────────────┐
        │     Obsidian Canon Vault        │
        │    (Single Source of Truth)     │
        └────────────────────────────────┘
```

---

## 2. 하네스 2층 구조

하네스는 **공통 하네스 1개 + 영역별 하네스 3개** = 총 4개.

```
┌──────────────────────────────────────────────────────────────┐
│                      공통 하네스 (Global Harness)              │
│                                                              │
│  • 프로젝트 범위 결정 (project_id: nry)                        │
│  • canon_status 판별 (official / provisional / deprecated)    │
│  • 참조 가능한 설정집 파일 범위 제한                             │
│  • 저장 포맷 통일 (JSON Schema 준수)                           │
│  • 이슈 원장 갱신 (issue_ledger_write)                         │
│  • 회귀검사 플래그 관리                                         │
│  • 로그 / 버전 관리                                            │
└──────────────────────────────────────────────────────────────┘
          │                    │                    │
          ▼                    ▼                    ▼
┌──────────────────┐  ┌──────────────────┐  ┌──────────────────┐
│   설계 하네스      │  │   집필 하네스      │  │   감리 하네스      │
│ (Design Harness) │  │ (Writing Harness) │  │ (Audit Harness)  │
│                  │  │                  │  │                  │
│ • 현재 설계 단계   │  │ • 씬 목적 미정의   │  │ • 하드 게이트 강제  │
│   구분 (세계관/    │  │   시 초안 생성 제한 │  │ • 증거 없는 지적   │
│   플롯 / 결말)    │  │ • 캐논 조회 없이   │  │   차단            │
│ • 미확정 설정을    │  │   본문 생성 금지   │  │ • low-confidence  │
│   확정처럼 쓰지    │  │ • 시점 위반 경고   │  │   결과 하향        │
│   못하게 차단      │  │ • 보이스 프로필    │  │ • 중복 이슈 병합   │
│ • 결말 전략 모드   │  │   없이 대사 생성   │  │ • 치명도 분류      │
│   지정 및 강제     │  │   금지            │  │ • 수정 필요 여부   │
│   (결말선확정형 /  │  │ • 신규 설정 생성   │  │   판정            │
│   탐색형)         │  │   자동 태깅        │  │ • 회귀검사 예약    │
│ • 구조 설계안이    │  │ • 감리 출력 포맷   │  │                  │
│   캐논과 충돌하는  │  │   정리            │  │                  │
│   지 사전 검사     │  │                  │  │                  │
│ • 설계 결과 분류   │  │                  │  │                  │
│   (확정/가안/실험) │  │                  │  │                  │
└──────────────────┘  └──────────────────┘  └──────────────────┘
```

---

## 3. 설계군 (DESIGN WING)

**언제 쓰는가**: 아직 쓰지 않은 화 설계 / 구조 재검토 / 아크 리디자인

### 3-1. Story Design Manager

| 역할 항목 | 내용 |
|---------|------|
| 작품 목표 확인 | 현재 Phase 목표와 결말 전략 파악 |
| 현재 설계 단계 확인 | 세계관 설계 / 플롯 설계 / 결말 설계 중 어느 단계인지 |
| 서브 에이전트 호출 | 필요한 설계 전문가 지정 |
| 설계안 병합 | 복수 에이전트 결과를 충돌 없이 통합 |
| 구조적 충돌 정리 | 에이전트 간 의견 불일치 조정 |

### 3-2. 설계군 서브 에이전트

| ID | 에이전트 | 핵심 질문 | 입력 | 출력 |
|----|---------|-----------|------|------|
| D-01 | **Story Architect** | 이야기 뼈대가 독자에게 먹히는가? | 설정집, 전체 구조 | 구조 진단 + 재설계 제안 |
| D-02 | **Plot Designer** | 사건 배치가 최강의 충격을 만드는가? | 마일스톤 목록, Phase 요약 | 복선·정보공개 플랜 |
| D-03 | **Character Arc Designer** | 캐릭터 변화가 독자를 끌고 가는가? | 캐릭터 시트, Arc 현황 | Arc 재설계 제안 |
| D-04 | **Theme & Motif Designer** | 모든 씬이 주제·모티프와 연결되는가? | 작품 설정, Phase 요약 | 테마 지도 + 약점 |
| D-05 | **Ending Designer** | 결말이 설정+아크+주제 3축을 동시에 닫는가? | 전체 구조, 캐릭터 아크 | 결말 설계안 (복수) |
| D-06 | **Series Planner** | 권/아크 단위 분배가 최적인가? | 전체 화수, Phase 구조 | 아크별 분배 설계 |

### 3-3. 설계 전용 스킬

| 스킬 ID | 스킬명 | 기능 |
|--------|-------|------|
| DS-01 | `arc_structure_builder` | 3막/웹소설형/아크형 구조 자동 생성 |
| DS-02 | `theme_resonance_mapper` | 씬-주제 연결 강도 매핑 |
| DS-03 | `ending_mode_selector` | 결말 전략 유형 판별 및 추천 |
| DS-04 | `foreshadowing_planner` | 복선 배치 및 회수 스케줄 설계 |
| DS-05 | `character_arc_mapper` | 캐릭터 변화 곡선 시각화 |
| DS-06 | `plot_dependency_map` | 사건 인과 의존도 지도 생성 |

---

## 4. 집필군 (WRITING WING)

**언제 쓰는가**: 특정 화 집필 전 / 집필 중 / 초고 완성 직후

### 4-1. Writing Manager

| 역할 항목 | 내용 |
|---------|------|
| 현재 집필 단위 파악 | 몇 화, 어느 씬, 어느 beats인지 |
| 장면 목적 확인 | 씬이 해야 할 일 (플롯 전진 / 감정 구축 / 정보 전달 등) |
| 서브 에이전트 호출 | 필요한 집필 전문가 지정 |
| 초안 생성/수정 | 실제 문장 초안 산출 |
| 감리 넘기기 전 1차 정리 | 감리군에 넘길 출력 포맷 정리 |

### 4-2. 집필군 서브 에이전트

| ID | 에이전트 | 핵심 질문 | 입력 | 출력 |
|----|---------|-----------|------|------|
| W-01 | **Scene Designer** | 이 씬의 beats와 구성이 최적인가? | 화 번호, 줄거리 요약 | 씬 beats + 구성안 |
| W-02 | **Voice & Dialogue Coach** | 대사가 더 캐릭터답고 강할 수 있는가? | 대사 초고, 캐릭터 시트 | 수정 대사 + 서브텍스트 해설 |
| W-03 | **Narrative Style Coach** | 문체와 시점이 일관되고 효과적인가? | 원고 초고 | 문체 교정안 |
| W-04 | **Bridge Scene Generator** | 갑작스러운 전환 사이를 어떻게 메꾸는가? | 이전/다음 씬 요약 | 브리지 씬 초안 |
| W-05 | **Exposition Balancer** | 설정 설명이 과다하거나 불자연스러운가? | 원고 초고 | 설명 밀도 조정안 |
| W-06 | **POV Keeper** | 시점 정보 누수가 있는가? | 원고 초고 | 시점 위반 목록 + 수정안 |
| W-07 | **Draft Composer** | 실제 문장을 초안으로 만들어야 하는가? | 씬 beats, 설정 요약 | 초안 원고 (장면 단위) |

### 4-3. 집필 전용 스킬

| 스킬 ID | 스킬명 | 기능 |
|--------|-------|------|
| WS-01 | `scene_goal_builder` | 씬 목적·기능 자동 정의 |
| WS-02 | `beat_sheet_generator` | 씬 beats 구조 자동 생성 |
| WS-03 | `voice_profile_lookup` | 캐릭터 보이스 프로필 조회 |
| WS-04 | `tone_preserving_rewrite` | 작가 문체 보존 리라이트 |
| WS-05 | `bridge_scene_generator` | 브리지 씬 자동 생성 |
| WS-06 | `pov_constraint_checker` | 시점 위반 자동 탐지 |
| WS-07 | `dialogue_variation_tool` | 같은 의미의 대사 다양화 |
| WS-08 | `exposition_density_checker` | 설명 밀도 측정 및 경고 |

---

## 5. 감리군 (AUDIT WING)

**언제 쓰는가**: 화 완성 후 / 아크 완성 후 / 출판 전

### 5-1. Audit Manager

| 역할 항목 | 내용 |
|---------|------|
| 감리 범위 지정 | 단화/아크/전체 중 선택 |
| 감사 에이전트 호출 | 필요한 감사 전문가 지정 |
| 결과 병합 | 복수 에이전트 결과 통합 |
| hard fail / soft fail 판정 | 치명도에 따라 분류 |
| 피드백 라우팅 | 수정 필요 시 집필군/설계군으로 반환 |

### 5-2. 감리군 서브 에이전트

| ID | 에이전트 | 하드 게이트 | 소프트 게이트 |
|----|---------|-----------|-------------|
| A-01 | **Canon Auditor** | 운율 절대 법칙 위반 | 설정 미세 오류 |
| A-02 | **Timeline Auditor** | 마일스톤 순서 위반 | 계절/학년 불일치 |
| A-03 | **Plot Causality Inspector** | 브릿지 없는 핵심 전환 | 약한 복선 |
| A-04 | **Motivation Checker** | Arc 역행 행동 | 동기 미약 |
| A-05 | **Voice Auditor** | 캐릭터 보이스 이탈 | 문체 미묘한 이탈 |
| A-06 | **Scene Purpose Auditor** | 기능 없는 씬 | 호흡 과잉 |
| A-07 | **Pacing Auditor** | 연속 5화 긴장 없음 | 운율 묘사 과잉 |
| A-08 | **Patch Generator** | — | 최소 수정안 생성 |
| A-09 | **Reader Experience Simulator** | — | 독자 이탈 포인트 예측 |
| A-10 | **Continuity Binder** | 증거 없는 감사 결과 | 중복 이슈 |

### 5-3. 감리 전용 스킬

| 스킬 ID | 스킬명 | 기능 |
|--------|-------|------|
| AS-01 | `canon_conflict_checker` | 캐논 충돌 자동 탐지 |
| AS-02 | `timeline_consistency_checker` | 타임라인 일관성 검증 |
| AS-03 | `knowledge_boundary_checker` | 시점 지식 범위 초과 탐지 |
| AS-04 | `scene_utility_classifier` | 씬 기능 자동 분류 (6종) |
| AS-05 | `motivation_gap_finder` | 동기-행동 불일치 탐지 |
| AS-06 | `continuity_diff_checker` | 이전 화와의 연속성 비교 |
| AS-07 | `reader_tension_map` | 긴장 곡선 시각화 |
| AS-08 | `issue_deduper` | 중복 이슈 자동 병합 |

---

## 6. 소설 전문가 계열 (CRAFT SPECIALISTS)

설계/집필/감리 3군과는 독립적인 **이야기 품질** 전문 계층.
감리 결과가 아닌 **이야기 자체의 완성도**를 판단합니다.

| ID | 에이전트 | 역할 | 호출 시점 |
|----|---------|------|---------|
| C-01 | **Narrative Structure Expert** | 3막/웹소설/로맨스 구조 관점 진단 | 설계 초기, 아크 중간 점검 |
| C-02 | **Reader Experience Simulator** | 독자 흥미·이탈 포인트 시뮬레이션 | 아크 완성 후, 출판 전 |
| C-03 | **Writing Strategy Coach** | 집필 전략 코칭, 막힘 해소 | 언제든지 |

---

## 7. 공통 스킬 레지스트리

세 군 모두 사용하는 공유 스킬.

| 스킬 ID | 스킬명 | 기능 |
|--------|-------|------|
| CS-01 | `canon_lookup` | Obsidian vault에서 설정 노트 조회 |
| CS-02 | `entity_resolution` | 인물·장소·규칙 엔티티 명확화 |
| CS-03 | `alias_resolver` | 별명/오기 → 정식 ID 변환 |
| CS-04 | `timeline_query` | 특정 시점의 타임라인 상태 조회 |
| CS-05 | `issue_ledger_write` | 이슈 원장에 신규 이슈 기록 |
| CS-06 | `citation_builder` | 증거 출처 (노트 ID + 필드) 자동 생성 |
| CS-07 | `schema_validator` | JSON Schema 준수 여부 검증 |
| CS-08 | `canon_status_filter` | official/provisional/deprecated 필터 |

---

## 8. 전체 스킬 맵 (한눈에)

```
┌─────────────────────────────────────────────────────────────────┐
│                       공통 스킬 (CS-01~08)                       │
│  canon_lookup / entity_resolution / alias_resolver              │
│  timeline_query / issue_ledger_write / citation_builder         │
│  schema_validator / canon_status_filter                         │
└──────────────┬────────────────┬────────────────────────────────┘
               │                │                │
               ▼                ▼                ▼
  ┌───────────────────┐ ┌─────────────────┐ ┌──────────────────┐
  │   설계 전용 스킬    │ │  집필 전용 스킬   │ │  감리 전용 스킬   │
  │   (DS-01~06)      │ │  (WS-01~08)     │ │  (AS-01~08)     │
  │                   │ │                 │ │                  │
  │ arc_structure_    │ │ scene_goal_     │ │ canon_conflict_  │
  │   builder         │ │   builder       │ │   checker        │
  │ theme_resonance_  │ │ beat_sheet_     │ │ timeline_        │
  │   mapper          │ │   generator     │ │   consistency_   │
  │ ending_mode_      │ │ voice_profile_  │ │   checker        │
  │   selector        │ │   lookup        │ │ motivation_gap_  │
  │ foreshadowing_    │ │ tone_preserving │ │   finder         │
  │   planner         │ │   _rewrite      │ │ reader_tension_  │
  │ character_arc_    │ │ pov_constraint_ │ │   map            │
  │   mapper          │ │   checker       │ │ issue_deduper    │
  │ plot_dependency_  │ │ dialogue_       │ │ …                │
  │   map             │ │   variation     │ │                  │
  └───────────────────┘ └─────────────────┘ └──────────────────┘
```

---

## 9. 전체 에이전트·스킬·하네스 조견표

| 분류 | 이름 | 유형 | 역할 요약 | 파일 |
|-----|------|------|---------|------|
| **총괄** | Story Program Manager | Manager | 전체 오케스트레이션 | `managers/story_program_manager.md` |
| **설계** | Story Design Manager | Manager | 설계 작업 총괄 | _(prompts 내 통합)_ |
| **설계** | Story Architect | Sub-Agent | 전체 구조 설계 | `design/D01_story_architect.md` |
| **설계** | Plot Designer | Sub-Agent | 사건·복선·회수 배치 | `design/D02_plot_designer.md` |
| **설계** | Character Arc Designer | Sub-Agent | 캐릭터 변화 곡선 | `design/D03_character_arc_designer.md` |
| **설계** | Theme & Motif Designer | Sub-Agent | 주제·모티프 설계 | `design/D04_theme_designer.md` |
| **설계** | Ending Designer | Sub-Agent | 결말 3축 설계 | `design/D05_ending_designer.md` |
| **설계** | Series Planner | Sub-Agent | 권/아크 분배 설계 | _(예정)_ |
| **설계** | Design Harness | Harness | 설계 단계 통제 | _(구현 예정)_ |
| **집필** | Writing Manager | Manager | 집필 작업 총괄 | _(prompts 내 통합)_ |
| **집필** | Scene Designer | Sub-Agent | 씬 beats·구성 | `writing/W01_scene_designer.md` |
| **집필** | Voice & Dialogue Coach | Sub-Agent | 대사·서브텍스트 | `writing/W02_voice_dialogue_coach.md` |
| **집필** | Narrative Style Coach | Sub-Agent | 문체·시점 코칭 | `writing/W03_narrative_style_coach.md` |
| **집필** | Bridge Scene Generator | Sub-Agent | 전환 연결 씬 | `writing/W04_bridge_scene_generator.md` |
| **집필** | Exposition Balancer | Sub-Agent | 설명 밀도 조절 | _(예정)_ |
| **집필** | POV Keeper | Sub-Agent | 시점 정보 누수 방지 | _(예정)_ |
| **집필** | Draft Composer | Sub-Agent | 실제 초안 생성 | _(예정)_ |
| **집필** | Writing Harness | Harness | 집필 생성 규칙 통제 | _(구현 예정)_ |
| **감리** | Audit Manager | Manager | 감리 작업 총괄 | _(prompts 내 통합)_ |
| **감리** | Canon Auditor | Sub-Agent | 운율 규칙 감사 | `audit/01_canon_auditor.md` |
| **감리** | Timeline Auditor | Sub-Agent | 시간·마일스톤 감사 | `audit/02_timeline_auditor.md` |
| **감리** | Plot Causality Inspector | Sub-Agent | 인과관계 감사 | `audit/03_plot_causality_inspector.md` |
| **감리** | Motivation Checker | Sub-Agent | 동기·Arc 감사 | `audit/04_motivation_checker.md` |
| **감리** | Voice Auditor | Sub-Agent | 보이스 일관성 감사 | `audit/05_voice_auditor.md` |
| **감리** | Scene Purpose Auditor | Sub-Agent | 씬 기능 감사 | `audit/06_scene_purpose_auditor.md` |
| **감리** | Pacing Auditor | Sub-Agent | 페이싱 감사 | `audit/07_pacing_auditor.md` |
| **감리** | Patch Generator | Sub-Agent | 최소 수정안 생성 | `audit/08_patch_generator.md` |
| **감리** | Canon Priority Resolver | Sub-Agent | 충돌 설정 우선순위 | `audit/09_canon_priority_resolver.md` |
| **감리** | Evidence Binder | Sub-Agent | 증거 품질 검증 | `audit/10_evidence_binder.md` |
| **감리** | Reader Experience Sim. | Sub-Agent | 독자 이탈 시뮬레이션 | `craft/C02_reader_experience_simulator.md` |
| **감리** | Audit Harness | Harness | 하드 게이트·증거 통제 | _(구현 예정)_ |
| **전문가** | Narrative Structure Expert | Craft | 구조론 진단 | `craft/C01_narrative_structure_expert.md` |
| **전문가** | Reader Experience Simulator | Craft | 독자 경험 시뮬레이션 | `craft/C02_reader_experience_simulator.md` |
| **전문가** | Writing Strategy Coach | Craft | 집필 전략 코칭 | `craft/C03_writing_strategy_coach.md` |
| **기반** | Canon Governance Manager | Manager | vault 신뢰성 관리 | `managers/canon_governance_manager.md` |
| **기반** | Evidence Memory Manager | Manager | 이슈 원장·중복 제거 | `managers/evidence_memory_manager.md` |
| **기반** | Global Harness | Harness | 전체 규칙·게이트 | _(구현 예정)_ |

---

## 10. 운영 흐름 (Workflow)

### A. 새 화 집필 시

```
① [설계군] Scene Designer → 씬 beats 설계
        └─ canon_lookup + scene_goal_builder 사용
② [집필군] Draft Composer → 초안 생성
        └─ beat_sheet_generator + voice_profile_lookup 사용
③ [집필군] Voice Coach → 대사 톤 조정
        └─ tone_preserving_rewrite + dialogue_variation_tool 사용
④ [집필군] Style Coach → 문체·시점 점검
        └─ pov_constraint_checker 사용
⑤ [감리군] Canon Auditor + Motivation Checker → 완성 후 감리
        └─ canon_conflict_checker + motivation_gap_finder 사용
⑥ [공통] issue_ledger_write → 이슈 기록
```

### B. 아크 재설계 시

```
① [설계군] Story Architect → 전체 구조 진단
② [전문가] Narrative Structure Expert → 구조 약점 분석
③ [설계군] Plot Designer → 사건 배치 재설계
        └─ foreshadowing_planner + plot_dependency_map 사용
④ [설계군] Character Arc Designer → 아크 재조정
⑤ [감리군] Canon Auditor → 영향받은 화 회귀 감사
        └─ continuity_diff_checker 사용
```

### C. 출판 전 최종 감리

```
① [감리군] 전체 에이전트 순차 실행
        └─ Audit Harness: 하드 게이트 강제
② [전문가] Reader Experience Simulator → 독자 이탈 시뮬레이션
③ [기반] Evidence Binder → 모든 이슈 증거 바인딩
④ [총괄] Story Program Manager → 최종 판정 (blocked_for_publish 여부)
```

### D. 역할 혼동 발생 시 (경계 규칙)

```
설계군이 문장 수정을 시도 → Writing Manager로 재라우팅
집필군이 구조 최종 판정을 시도 → Story Program Manager로 에스컬레이션
감리군이 설정집 덮어쓰기를 시도 → Canon Governance Manager 개입, 즉시 차단
```

---

## 11. 현재 구현 상태 (너라는 운율)

| 구성요소 | 상태 | 비고 |
|---------|------|------|
| 설계 에이전트 프롬프트 D01~05 | ✅ | D06 예정 |
| 집필 에이전트 프롬프트 W01~04 | ✅ | W05~07 예정 |
| 감리 에이전트 프롬프트 A01~10 | ✅ | |
| 소설 전문가 프롬프트 C01~03 | ✅ | |
| 매니저 프롬프트 3종 | ✅ | |
| JSON Schemas 6종 | ✅ | |
| Obsidian 템플릿 5종 | ✅ | |
| frontmatter 업데이트 (lore 13개) | ✅ | |
| 공통 스킬 정의 (CS-01~08) | 📋 설계 완료 | 구현 예정 |
| 설계 전용 스킬 (DS-01~06) | 📋 설계 완료 | 구현 예정 |
| 집필 전용 스킬 (WS-01~08) | 📋 설계 완료 | 구현 예정 |
| 감리 전용 스킬 (AS-01~08) | 📋 설계 완료 | 구현 예정 |
| 공통 하네스 | ⬜ 구현 예정 | |
| 설계 하네스 | ⬜ 구현 예정 | |
| 집필 하네스 | ⬜ 구현 예정 | |
| 감리 하네스 | ⬜ 구현 예정 | |
| MCP Filesystem 서버 | ⬜ 구현 예정 | vault 연결 |
| Vector Search MCP | ⬜ 구현 예정 | 의미 기반 검색 |
| Harness Python 코드 | ⬜ 구현 예정 | 파이프라인 자동화 |

---

## 12. 구현 로드맵

```
V1 (현재): 프롬프트 패키지 완성
  ✅ 3군 에이전트 프롬프트 전체 (20개)
  ✅ JSON Schema (6개)
  ✅ Obsidian 템플릿 (5종)
  ✅ 스킬 레지스트리 설계 (이 문서)

V2 (다음): 스킬 + 하네스 구현
  → 공통 스킬 Python/JS 모듈 구현
  → 공통 하네스 상태 머신 구현
  → 영역별 하네스 3개 구현

V3 (MCP 연동):
  → MCP Filesystem 서버 (Obsidian vault 읽기/쓰기)
  → Vector Search MCP (의미 기반 설정 검색)
  → Issue Ledger MCP (이슈 원장 자동 갱신)

V4 (자동화):
  → 하네스 Python 파이프라인 (군 간 자동 라우팅)
  → 회귀검사 자동 예약 시스템
  → 원고 버전 관리 연동
```

---

*버전: v3.0 | 갱신일: 2026-04-02 | 소설: 너라는 운율*
