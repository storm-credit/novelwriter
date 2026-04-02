# Obsidian Vault 구조 표준 — Canon Standard v2
## 현재: 너라는 운율 (단일 프로젝트) → 멀티프로젝트 확장 설계

---

## 1. 설계 목표

- 단일 프로젝트에서 시작, 멀티 크로니클로 무중단 확장 가능
- 에이전트가 오염 없이 범위 지정 조회 가능
- 공식/잠정/초안/deprecated 명확히 물리적 분리
- 미래 MCP Filesystem 서버가 폴더 경로로 scope 자동 추론 가능

---

## 2. 현재 상태 (nry 단일 프로젝트)

```
C:/novel/igotothepast/lore/          ← Obsidian vault 루트
  00-대시보드/                        → 00_meta/ 로 이전 권장
  01-작품개요/                        → nry/01_overview/ 로 이전 권장
  02-세계관/                          → nry/06_rules_and_systems/ 로 이전 권장
  03-캐릭터/                          → nry/03_characters/ 로 이전 권장
  04-스토리/                          → nry/02_story_structure/ 로 이전 권장
  05-수업용단편집/                     → 90_sandbox/ 로 이전 권장
  06-운율묘사/                        → nry/00_meta_style_guide/ 로 이전 권장
  07-집필가이드/                       → nry/00_meta_style_guide/ 로 이전 권장
  08-AI프롬프트/                       → 00_meta/prompt_specs/ 로 이전 권장
  10-집필/                            → nry/drafts/ 로 이전 권장
  11-미디어/                          → nry/media/ 로 이전 권장
```

> ⚠️ 현재 구조를 즉시 재배열하면 Obsidian 내부 링크([[노트명]])가 깨질 수 있습니다.
> 폴더 이전 전에 Obsidian의 "Update links" 기능을 사용하거나,
> 먼저 frontmatter `id`를 통한 ID 기반 참조로 전환한 후 이전하세요.

---

## 3. 목표 볼트 구조 (멀티프로젝트 완전체)

```
Obsidian Vault/
│
├── 00_meta/                              ← 시스템 전체 표준 (에이전트 우선 조회)
│   ├── canon_standards/
│   │   ├── obsidian_note_schema.md       ← 프론트매터 표준 (사람 읽기용)
│   │   ├── entity_type_vocabulary.md     ← 통제 어휘
│   │   └── governance_rules.md           ← 거버넌스 규칙
│   ├── schemas/                          ← JSON 스키마 참조
│   ├── workflows/                        ← 감사 워크플로우
│   ├── prompt_specs/                     ← AI 프롬프트 사양
│   └── issue_policies/                   ← 이슈 처리 정책
│
├── 01_shared_multiverse/                 ← scope: shared_world 노트만
│   ├── 01_cosmic_rules/                  ← source_priority: 0
│   ├── 02_shared_entities/
│   ├── 03_shared_timeline/
│   ├── 04_shared_locations/
│   └── 05_cross_project_constraints/
│
├── 10_nry/                               ← 너라는 운율 project_id: nry
│   ├── 00_overview/
│   │   ├── 작품_설정.md                  # entity_type: chronicle
│   │   └── 운율_시스템.md                # entity_type: magic_system  ★핵심
│   │
│   ├── 01_characters/
│   │   ├── protagonists/
│   │   │   ├── 윤서준.md                 # entity_type: character, continuity_risk: critical
│   │   │   └── 지아린.md                 # entity_type: character, continuity_risk: critical
│   │   └── supporting/
│   │       ├── 최이든.md
│   │       ├── 강도현.md
│   │       ├── 배소나.md
│   │       ├── 이태율.md
│   │       ├── 정시온.md
│   │       ├── 송유빈.md
│   │       ├── 김은지.md
│   │       └── 문다율.md
│   │
│   ├── 02_story_structure/
│   │   ├── 전체_구조.md                  # entity_type: chronicle
│   │   ├── phases/
│   │   │   ├── Phase-1_1-25화.md         # entity_type: arc
│   │   │   ├── Phase-2_26-50화.md
│   │   │   ├── Phase-3_51-75화.md
│   │   │   ├── Phase-4_76-95화.md
│   │   │   └── Phase-5_96-120화.md
│   │   ├── chapter_summaries/            # entity_type: chapter
│   │   ├── foreshadowing/                # entity_type: foreshadowing_seed
│   │   └── milestones/                   # entity_type: timeline_event
│   │
│   ├── 03_rules_and_systems/
│   │   ├── 운율_시스템_핵심.md            # entity_type: magic_system, priority: 1
│   │   ├── 운율_절대법칙.md               # entity_type: cosmic_rule, priority: 0(nry)
│   │   └── 운율_소실_궤적.md              # entity_type: power_rule
│   │
│   ├── 04_locations/
│   │   ├── 명성대학교.md                  # entity_type: academy
│   │   └── 장소_설정집.md
│   │
│   ├── 05_timeline/
│   │   ├── 마일스톤_타임라인.md
│   │   └── events/
│   │       ├── event_16세_불협화음.md     # entity_type: timeline_event
│   │       └── event_분수쇼_고백.md
│   │
│   ├── 06_objects/
│   │   └── 빈_이어폰.md                  # entity_type: artifact
│   │
│   ├── 07_open_issues/                   ← 감사 이슈 원장
│   │   ├── CA-001_자기운율청취.md         # entity_type: issue_record
│   │   └── ...
│   │
│   ├── 08_retcons/                       ← 공식 개정 기록
│   │
│   └── 09_deprecated/                    ← 구버전 설정 (감사 제외)
│
├── 20_project_b/                         ← 미래 두 번째 프로젝트
│   └── ...
│
├── 90_sandbox/                           ← 비권위적 실험 공간
│   ├── experiments/
│   ├── drafts/
│   └── raw_notes/
│
└── 99_archive/                           ← 역사적 자료만
    ├── retired_notes/
    └── old_versions/
```

---

## 4. 폴더별 에이전트 조회 규칙

| 폴더 | 에이전트 신뢰 수준 | 하드 게이트 사용 |
|------|------------------|----------------|
| `00_meta/` | 시스템 표준 | ✅ |
| `01_shared_multiverse/` | 공유 캐논 | ✅ |
| `10_nry/00_overview/` | 핵심 캐논 | ✅ |
| `10_nry/01_characters/` | 공식 캐릭터 | ✅ |
| `10_nry/03_rules_and_systems/` | 공식 규칙 | ✅ |
| `10_nry/07_open_issues/` | 이슈 원장 | 참조만 |
| `10_nry/08_retcons/` | 개정 기록 | 참조만 |
| `10_nry/09_deprecated/` | 구버전 | ❌ 감사 제외 |
| `90_sandbox/` | 실험 자료 | ❌ 감사 제외 |
| `99_archive/` | 역사 자료 | ❌ 정상 감사 제외 |

---

## 5. 단계별 이전 로드맵 (현재 → 목표)

### Phase 0 (현재 완료): Frontmatter 추가
- ✅ 핵심 파일에 `canon_status`, `source_priority` 추가

### Phase 1 (다음 단계): 확장 필드 추가
- `id`, `project_id`, `scope`, `summary`, `continuity_risk`, `governing_rules` 추가
- 기존 링크 유지한 채로 frontmatter만 업데이트

### Phase 2: 폴더 구조 이전
- Obsidian "Update links" 기능 활용
- 한 폴더씩 순차 이전

### Phase 3: 멀티프로젝트 확장 시
- `01_shared_multiverse/` 신설
- 두 번째 프로젝트 `20_project_b/` 추가

---

## 6. 에이전트 조회 순서 (Retrieval Order)

에이전트가 canon을 조회할 때 반드시 이 순서를 따릅니다:

```
1. 현재 project_id 노트 (project_only scope)
2. shared_world 노트 (공유 규칙)
3. 직접 related_entities
4. timeline 관련 노트 (era/timeline_event)
5. governing_rules 노트
6. open_issues 원장 (알려진 이슈 맥락)
7. 그 다음 광의적 시맨틱 검색
```

이 순서를 따르면 관련 없는 캐논에 의한 오염을 방지합니다.

---

*버전: v2.0 | 생성일: 2026-04-02 | 소설: 너라는 운율*
