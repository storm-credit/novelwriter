# novelwriter — Canon-driven Writing OS
## 소설: 너라는 운율 (120화 / 84만자)

> **"옵시디언 설정집을 정본으로 삼아,**
> **설정 설계 · 스토리 구조 설계 · 집필 지원 · 개연성 감리를 통합하는**
> **다중 에이전트 소설 운영 시스템"**

---

## 🗺️ 프로젝트 구조

```
novelwriter/
│
├── README.md
│
├── docs/
│   ├── system_architecture.md       ← 3군 전체 조직도 + 스킬 맵 ★핵심
│   ├── harness_spec.md              ← 2층 하네스 스펙 (공통+3개) ★핵심
│   ├── output_schema_registry.md    ← 전 에이전트 JSON 출력 통일 스키마 ★핵심
│   ├── obsidian_agent_mapping.md    ← Obsidian note ↔ Agent JSON 매핑 ★핵심
│   ├── agent_responsibility_matrix.md
│   ├── harness_state_machine.md
│   ├── entity_type_vocabulary.md
│   └── vault_structure.md
│
├── schemas/
│   ├── obsidian_note.schema.json    ← Obsidian frontmatter 표준 v2
│   ├── story_unit.schema.json
│   ├── issue.schema.json
│   ├── canon_entity.schema.json
│   ├── patch_proposal.schema.json
│   └── manager_verdict.schema.json
│
├── prompts/
│   │
│   ├── design/                      ← A. 설계 계열 (DESIGN WING)
│   │   ├── D01_story_architect.md   ★ 전체 구조 설계·진단
│   │   ├── D02_plot_designer.md     ★ 사건 배치·복선·정보 공개
│   │   ├── D03_character_arc_designer.md ★ 캐릭터 변화 곡선 설계
│   │   ├── D04_theme_designer.md    ★ 주제·모티프 설계
│   │   └── D05_ending_designer.md  ★ 결말·집필전략 설계
│   │
│   ├── writing/                     ← B. 집필 계열 (WRITING WING)
│   │   ├── W01_scene_designer.md   ★ 화별 씬 beats 설계
│   │   ├── W02_voice_dialogue_coach.md ★ 대사·서브텍스트 코칭
│   │   ├── W03_narrative_style_coach.md ★ 문체·시점 코칭
│   │   └── W04_bridge_scene_generator.md ★ 연결 씬 설계
│   │
│   ├── audit/                       ← C. 감리 계열 (AUDIT WING)
│   │   ├── 01_canon_auditor.md      ★ 운율 규칙 감사
│   │   ├── 02_timeline_auditor.md   ★ 시간·마일스톤
│   │   ├── 03_plot_causality_inspector.md ★ 인과관계
│   │   ├── 04_motivation_checker.md ★ 동기·Arc
│   │   ├── 05_voice_auditor.md      ★ 캐릭터 보이스
│   │   ├── 06_scene_purpose_auditor.md ★ 씬 기능
│   │   ├── 07_pacing_auditor.md     ★ 페이싱
│   │   ├── 08_patch_generator.md    ★ 최소 수정안
│   │   ├── 09_canon_priority_resolver.md
│   │   └── 10_evidence_binder.md
│   │
│   ├── craft/                       ← D. 소설 전문가 계열
│   │   ├── C01_narrative_structure_expert.md ★ 구조론 진단
│   │   ├── C02_reader_experience_simulator.md ★ 독자 경험
│   │   └── C03_writing_strategy_coach.md ★ 집필 전략
│   │
│   └── managers/                    ← E. 매니저 계층
│       ├── story_program_manager.md  ★ 총괄 PM
│       ├── story_design_manager.md   ★ 설계군 매니저
│       ├── writing_manager.md        ★ 집필군 매니저
│       ├── audit_manager.md          ★ 감리군 매니저
│       ├── canon_governance_manager.md
│       └── evidence_memory_manager.md
│
├── templates/                       ← Obsidian 노트 템플릿
│   ├── character_template.md        ← 한국어 (nry용)
│   ├── rule_system_template.md
│   ├── location_template.md
│   ├── timeline_event_template.md
│   ├── issue_record_template.md
│   └── en/                          ← 영어 범용 템플릿
│       ├── character_template.md
│       ├── faction_template.md
│       ├── location_template.md
│       ├── rule_system_template.md
│       ├── timeline_event_template.md
│       ├── project_overview_template.md ★ 구조 계열
│       ├── arc_template.md
│       ├── chapter_template.md
│       ├── scene_template.md
│       ├── volume_template.md
│       ├── issue_record_template.md    ★ 프로세스 계열
│       ├── retcon_record_template.md
│       ├── open_question_template.md
│       └── relationship_note_template.md
│
├── harness/                         ← (구현 예정)
├── reports/
└── tests/
```

---

## ⚙️ 3군 에이전트 조직도

### A. 설계 계열 — "어떻게 설계할까"

| ID | 에이전트 | 핵심 질문 |
|----|---------|-----------|
| D-01 | Story Architect | 이야기 뼈대가 독자에게 먹히는가? |
| D-02 | Plot Designer | 사건 배치가 최강의 충격을 만드는가? |
| D-03 | Character Arc Designer | 캐릭터 변화가 독자를 끌고 가는가? |
| D-04 | Theme & Motif Designer | 모든 씬이 주제·모티프와 연결되는가? |
| D-05 | Ending Designer | 결말이 3축(설정+아크+주제)을 동시에 닫는가? |

### B. 집필 계열 — "어떻게 쓸까"

| ID | 에이전트 | 핵심 질문 |
|----|---------|-----------|
| W-01 | Scene Designer | 이 씬의 beats와 구성이 최적인가? |
| W-02 | Voice & Dialogue Coach | 대사가 더 캐릭터답고 강할 수 있는가? |
| W-03 | Narrative Style Coach | 문체와 시점이 일관된가? |
| W-04 | Bridge Scene Generator | 갑작스러운 전환 사이를 어떻게 메꾸는가? |

### C. 감리 계열 — "쓴 것이 괜찮은가"

| ID | 에이전트 | 하드 게이트 |
|----|---------|-----------|
| A-01 | Canon Auditor | 운율 6대 절대 법칙 |
| A-02 | Timeline Auditor | 마일스톤 순서 |
| A-03 | Plot Causality Inspector | 인과관계 붕괴 |
| A-04 | Motivation Checker | Arc 역행 |
| A-05 | Voice Auditor | 보이스 이탈 |
| A-06 | Scene Purpose Auditor | 기능 없는 씬 |
| A-07 | Pacing Auditor | 긴장 리듬 붕괴 |
| A-08 | Patch Generator | 최소 수정안 |

### D. 소설 전문가 계열 — "이야기 자체가 좋은가"

| ID | 에이전트 | 핵심 관점 |
|----|---------|----------|
| C-01 | Narrative Structure Expert | 구조론·작법론 |
| C-02 | Reader Experience Simulator | 독자 흥미·이탈 예측 |
| C-03 | Writing Strategy Coach | 집필 전략·막힘 해소 |

---

## 🔴 Single Source of Truth

```
Obsidian canon vault > 원고 > 모델 추론

canon_status: official  → 하드 게이트 판정 사용 가능
canon_status: provisional → soft_fail 근거만
canon_status: deprecated  → 감사 완전 제외
```

---

## 📋 현재 완성 현황

| 구성요소 | 상태 |
|---------|------|
| 3군 조직도 | ✅ |
| 설계 계열 프롬프트 (D01~05) | ✅ |
| 집필 계열 프롬프트 (W01~04) | ✅ |
| 감리 계열 프롬프트 (A01~10) | ✅ |
| 소설전문가 프롬프트 (C01~03) | ✅ |
| Manager 프롬프트 (6개) | ✅ |
| 2층 하네스 스펙 문서 | ✅ |
| JSON 출력 스키마 통일본 | ✅ |
| Obsidian ↔ Agent 매핑 스펙 | ✅ |
| 영어 범용 프롬프트 팩 (26개) | ✅ |
| 영어 캐논 vault 템플릿 (5종) | ✅ |
| 영어 구조 템플릿 (5종) | ✅ |
| 영어 프로세스 템플릿 (4종) | ✅ |
| JSON Schemas (6개) | ✅ |
| Obsidian 템플릿 (5종) | ✅ |
| frontmatter 업데이트 (lore 13개 파일) | ✅ |
| MCP 서버 구현 | 예정 |
| 하네스 Python 코드 | 예정 |

---

## 🗺️ 다음 단계 로드맵

### 즉시 사용 가능 (지금)
- 설계 계열 → 41화~ 집필 설계에 프롬프트 직접 활용
- 감리 계열 → 1-40화 원고 감사

### 다음 구현
1. **MCP Filesystem 서버** — Obsidian vault 읽기/쓰기
2. **Vector Search MCP** — 의미 기반 설정집 검색
3. **하네스 Python 코드** — 파이프라인 자동 실행
4. **Issue Ledger** — Obsidian 내 이슈 원장 자동 생성

---

*버전: v3.2 | 갱신일: 2026-04-02 | GitHub: storm-credit/novelwriter*
