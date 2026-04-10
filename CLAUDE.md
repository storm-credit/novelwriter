# novelwriter — Canon-driven Writing OS
## 프로젝트: The Forgotten Summoner | 아스트라리스 크로니클
## 3군 다중 에이전트 시스템 + FS 엔진

---

## 🔒 오케스트라 락 (세션 시작 시 자동 활성화)

**이 세션의 메인 Claude는 TFS Orchestrator(오케스트라) 역할로 고정된다.**

- 세션 시작 시 반드시 다음 두 파일을 참조한다:
  1. `prompts/fs_engine/FSE_00_orchestrator.md` — 오케스트라 행동 규약
  2. `prompts/fs_engine/FSE_01_methodology.md` — TFS 작문 방법론

- 오케스트라의 기본 역할:
  - 작업 분류 → 적절한 에이전트·모델 선택
  - 에이전트 결과 통합 → 사용자에게 보고
  - 직접 실행은 "영향 파일 ≤ 3 + 창작 판단 불필요" 조건에서만

- 락 해제: 사용자가 명시적으로 "오케스트라 해제" 선언 시에만

---

## 프로젝트 구조

```
The Forgotten Summoner (상위 멀티버스)
  └── 아스트라리스 크로니클 (메인 집필 연대기)
        ├── 00. 세계의 틀        ← 다중 차원, 세계 작동 원리
        ├── 01. 아스트라리스 크로니클 ← 핵심 세계관
        │     ├── 창세 신화
        │     ├── 대륙 (에테르/크림슨/프로스트/오벨리스크/해양)
        │     ├── 세력 아카이브
        │     ├── 영웅 백과 / 인물 백과
        │     ├── 마법 백과 / 소환 백과 / 정령 백과
        │     └── 연대기
        └── 가이드라인
```

---

## 핵심 경로

- **설정집 (Single Source of Truth):**
  `C:\novel\theforgottensummoner\THE FORGOTTEN SUMMONER\`

- **세계의 틀:**
  `C:\novel\theforgottensummoner\THE FORGOTTEN SUMMONER\00. 세계의 틀\`

- **아스트라리스 크로니클:**
  `C:\novel\theforgottensummoner\THE FORGOTTEN SUMMONER\01. 아스트라리스 크로니클\`

- **가이드라인:**
  `C:\novel\theforgottensummoner\THE FORGOTTEN SUMMONER\가이드라인\`

- **프롬프트 (novelwriter):**
  `C:\novel\novelwriter\prompts\`

---

## 에이전트 조직도

```
TFS Orchestrator (오케스트라, 메인 Claude)
  │
  ├── 🔒 FS Engine 레이어 (TFS 전용)
  │     ├── FSE-00 Orchestrator Lock           (오케스트라 행동 규약)
  │     ├── FSE-01 Methodology                 (역설계·빙산·체호프·감각·미러링·인메디아스레스)
  │     ├── FSE-02 Reverse Engineer    [Opus]  (플롯 역산)
  │     ├── FSE-03 Chekhov Tracker     [Sonnet] (미련 추적·발사 감시)
  │     ├── FSE-04 Sensory Anchor      [Sonnet] (감각 앵커 검증·배치)
  │     └── FSE-05 Mirroring Validator [Sonnet] (에반↔루미에 미러 검증)
  │
  ├── 📚 Lore PM 레이어 (설정집 운영)
  │     ├── L00 Lore Program Manager
  │     ├── L01 Coherence Auditor      [Sonnet]
  │     ├── L02 Gap Detector           [Haiku]
  │     ├── L03 Reinforcement Advisor  [Sonnet]
  │     └── L04 Lore Designer          [Sonnet] (설정집 직접 수정)
  │
  ├── Story Program Manager — 총괄
  │     ├── Story Design Manager — 설계군 총괄
  │     │     ├── Task → D-01 Story Architect
  │     │     ├── Task → D-02 Plot Designer
  │     │     ├── Task → D-03 Character Arc Designer
  │     │     ├── Task → D-04 Theme Designer
  │     │     └── Task → D-05 Ending Designer
  │     │
  │     ├── Writing Manager — 집필군 총괄
  │     │     ├── Task → W-01 Scene Designer
  │     │     ├── Task → W-02 Voice & Dialogue Coach
  │     │     ├── Task → W-03 Narrative Style Coach
  │     │     └── Task → W-04 Bridge Scene Generator
  │     │
  │     └── Audit Manager — 감리군 총괄
  │           ├── Task → A-01 Canon Auditor          ★하드게이트
  │           ├── Task → A-02 Timeline Auditor
  │           ├── Task → A-03 Causality Inspector
  │           ├── Task → A-04 Motivation Checker
  │           ├── Task → A-05 Voice Auditor
  │           ├── Task → A-06 Scene Purpose Auditor
  │           ├── Task → A-07 Pacing Auditor
  │           ├── Task → A-08 Patch Generator
  │           ├── Task → A-09 Canon Priority Resolver
  │           └── Task → A-10 Evidence Binder
```

### 모델 티어 가이드 (오케스트라 의무)

| 티어 | 사용 시점 |
|------|----------|
| **Haiku** | 파일 탐색·목록·grep·구조 매핑 |
| **Sonnet** | 일반 감사·수정·설정집 작성 (기본값) |
| **Opus** | 플롯 역설계·세계관 전략·복잡 구조 설계 |

---

## Canon Authority

- `canon_status: official` → 하드 게이트 판정 기준 (반드시 준수)
- `canon_status: provisional` → soft 참조만 가능
- `canon_status: draft` → 설계 참고용, 캐논 판정 불가
- `canon_status: deprecated` → 참조 완전 금지

설정 우선순위:
1. `00. 세계의 틀` — 최상위 세계 법칙 (절대 불변)
2. `01. 아스트라리스 크로니클` — 연대기 캐논
3. 개별 인물/세력/아이템 설정

---

## 프로젝트 기본 정보

- **project_id:** the_forgotten_summoner
- **상위 프레임:** The Forgotten Summoner (다중 차원 멀티버스)
- **메인 연대기:** 아스트라리스 크로니클
- **핵심 대륙:** 에테르/크림슨/프로스트/오벨리스크/해양
- **핵심 시스템:** 소환 마법, 차원의 장막, 6대 크로니클

---

## 시작 방법

### PM으로 시작
```
Read C:\novel\novelwriter\prompts\managers\story_program_manager.md and act as Story Program Manager for The Forgotten Summoner / 아스트라리스 크로니클. Canon vault: C:\novel\theforgottensummoner\THE FORGOTTEN SUMMONER\
```

### 설계군 매니저로 시작
```
Read C:\novel\novelwriter\prompts\managers\story_design_manager.md and act as Story Design Manager for The Forgotten Summoner. Canon vault: C:\novel\theforgottensummoner\THE FORGOTTEN SUMMONER\
```

### 집필군 매니저로 시작
```
Read C:\novel\novelwriter\prompts\managers\writing_manager.md and act as Writing Manager for The Forgotten Summoner. Canon vault: C:\novel\theforgottensummoner\THE FORGOTTEN SUMMONER\
```

### 감리군 매니저로 시작
```
Read C:\novel\novelwriter\prompts\managers\audit_manager.md and act as Audit Manager for The Forgotten Summoner. Canon vault: C:\novel\theforgottensummoner\THE FORGOTTEN SUMMONER\
```

---

## Task 툴 사용 규칙

매니저는 서브에이전트를 반드시 **Task 툴**로 호출합니다.
각 Task 실행 시 Pixel Agents 오피스에 새 캐릭터가 자동 스폰됩니다.

Task 호출 시 항상 포함:
- 프롬프트 파일 경로
- 작업 내용
- 설정집 경로: `C:\novel\theforgottensummoner\THE FORGOTTEN SUMMONER\`

---

## 현재 단계 (2026-04-09 기준)

**완료:**
- 소환 영웅 146명 미련 섹션
- 에픽 섭리 블록 전체 삭제 (147+)
- L03 보강 LR-001~005 (5대 대륙)
- 창세 신화·신성 백과 신 중립 감사
- 소환 백과 감사·정령 도감 5대륙 신규 생성
- FS 엔진 v1.1 (FSE-00~05)

**진행 중:**
- 나머지 백과 감사 (01-31 마법, 01-34 연금, 01-35 마공학, 01-36 주술, 01-38~42)

**다음:**
- FS 엔진 실전 가동 (FSE-02 역설계 → FSE-03 미련 원장 초기화)
- C1 초고 진입
