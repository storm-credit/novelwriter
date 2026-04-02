# novelwriter — Canon-driven Writing OS
## 프로젝트: The Forgotten Summoner | 아스트라리스 크로니클
## 3군 다중 에이전트 시스템

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
Story Program Manager (PM) — 총괄
  ├── Story Design Manager — 설계군 총괄
  │     ├── Task → D-01 Story Architect        (세계 구조 설계)
  │     ├── Task → D-02 Plot Designer          (사건 배치·복선)
  │     ├── Task → D-03 Character Arc Designer (인물 변화곡선)
  │     ├── Task → D-04 Theme Designer         (주제·모티프)
  │     └── Task → D-05 Ending Designer        (결말 전략)
  │
  ├── Writing Manager — 집필군 총괄
  │     ├── Task → W-01 Scene Designer         (씬 beats 설계)
  │     ├── Task → W-02 Voice & Dialogue Coach (대사·서브텍스트)
  │     ├── Task → W-03 Narrative Style Coach  (문체·시점)
  │     └── Task → W-04 Bridge Scene Generator (연결 씬)
  │
  └── Audit Manager — 감리군 총괄
        ├── Task → A-01 Canon Auditor          (설정 법칙 감사 ★하드게이트)
        ├── Task → A-02 Timeline Auditor       (시간·연대기)
        ├── Task → A-03 Causality Inspector    (인과관계)
        ├── Task → A-04 Motivation Checker     (동기·Arc)
        ├── Task → A-05 Voice Auditor          (캐릭터 보이스)
        ├── Task → A-06 Scene Purpose Auditor  (씬 기능)
        ├── Task → A-07 Pacing Auditor         (페이싱)
        ├── Task → A-08 Patch Generator        (수정안)
        ├── Task → A-09 Canon Priority Resolver(설정 우선순위)
        └── Task → A-10 Evidence Binder        (증거 연결)
```

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
