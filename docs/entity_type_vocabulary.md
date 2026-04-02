# Entity Type 통제 어휘 — Canon Standard v2
## 소설: 너라는 운율 | project_id: nry

> 모든 설정집 노트의 `entity_type` 필드는 반드시 이 목록에서 선택해야 합니다.
> 목록에 없는 값은 사용 불가. 새 타입이 필요하면 이 문서를 먼저 업데이트하세요.

---

## 1. 서사 구조 (Story Structure)

| entity_type | 설명 | nry 적용 예 |
|-------------|------|-------------|
| `series` | 여러 작품을 묶는 시리즈 | — |
| `chronicle` | 단일 대작 크로니클 | 너라는 운율 전체 |
| `volume` | 권 단위 | — |
| `arc` | 아크 단위 | — |
| `chapter` | 챕터 | Ch.1~Ch.24 |
| `scene` | 씬 | 개별 장면 |
| `subplot` | 서브플롯 | 도현-아린 연적 라인 |
| `theme` | 주제/테마 | "듣는 것과 이해하는 것은 다르다" |
| `foreshadowing_seed` | 복선 씨앗 | 이어폰 = 자기 격리의 상징 |
| `payoff_node` | 복선 회수 지점 | 120화 이어폰 없이 목소리만 믿음 |

---

## 2. 캐릭터 (Characters)

| entity_type | 설명 | nry 적용 예 |
|-------------|------|-------------|
| `character` | 단일 인물 | 윤서준, 지아린, 최이든 등 |
| `character_group` | 인물 집단 | 밴드 동아리 멤버들 |
| `bloodline` | 혈통/가문 | — |
| `title_role` | 직함/역할 (인물 아님) | — |
| `identity_mask` | 외적 페르소나 (진짜 정체 아님) | 서준의 "무관심한 수도승" 페르소나 |

---

## 3. 파벌/기관 (Factions & Institutions)

| entity_type | 설명 | nry 적용 예 |
|-------------|------|-------------|
| `faction` | 조직/집단 | — |
| `kingdom` | 왕국 | — |
| `empire` | 제국 | — |
| `guild` | 길드 | — |
| `religion` | 종교 | — |
| `order` | 결사/기사단 | — |
| `house` | 가문 | — |
| `company` | 회사 | — |
| `academy` | 학교/학원 | 명성대학교 |
| `military_unit` | 군사 조직 | — |

---

## 4. 장소 (Locations)

| entity_type | 설명 | nry 적용 예 |
|-------------|------|-------------|
| `world` | 세계 전체 | — |
| `continent` | 대륙 | — |
| `region` | 지역 | — |
| `kingdom_region` | 국가 내 행정 구역 | — |
| `city` | 도시 | — |
| `district` | 구역/동네 | — |
| `landmark` | 랜드마크 | 명성대 분수대, 중앙광장 |
| `dungeon` | 던전 | — |
| `ruin` | 폐허 | — |
| `fortress` | 요새 | — |
| `route` | 이동 경로 | — |

---

## 5. 시간/역사 (Time & History)

| entity_type | 설명 | nry 적용 예 |
|-------------|------|-------------|
| `era` | 시대/시기 | 대학 입학 전, Phase-1 봄학기 |
| `timeline_event` | 개별 사건 | 16세 불협화음 사건, 분수쇼 고백 |
| `war` | 전쟁 | — |
| `treaty` | 조약 | — |
| `catastrophe` | 재앙/재난 | — |
| `migration` | 이동/이주 | — |
| `dynastic_change` | 왕조 교체 | — |

---

## 6. 규칙/시스템 (Rules & Systems)

| entity_type | 설명 | nry 적용 예 |
|-------------|------|-------------|
| `magic_system` | 마법 시스템 전체 | 운율(Rhyme) 시스템 |
| `power_rule` | 개별 능력 규칙 | 운율 감지 범위 3-5m |
| `summoning_rule` | 소환 규칙 | — |
| `technology_rule` | 기술 규칙 | — |
| `cosmic_rule` | 세계 근본 규칙 | 자기 운율 청취 불가 절대 법칙 |
| `taboo` | 금기 | — |
| `ritual` | 의례 | — |
| `resource_rule` | 자원 규칙 | — |

---

## 7. 사물 (Objects)

| entity_type | 설명 | nry 적용 예 |
|-------------|------|-------------|
| `artifact` | 마법/특별 물건 | 서준의 빈 이어폰 (상징적 아티팩트) |
| `weapon` | 무기 | — |
| `relic` | 유물 | — |
| `document_item` | 문서/책 (스토리 내 사물) | — |
| `seal` | 봉인 | — |
| `device` | 장치 | — |

---

## 8. 지식/메타 (Knowledge & Meta)

| entity_type | 설명 | nry 적용 예 |
|-------------|------|-------------|
| `canon_rule` | 캐논 거버넌스 규칙 | — |
| `continuity_constraint` | 연속성 제약 | 운율 소실 5단계 순서 제약 |
| `author_note` | 작가 메모 | 집필 가이드 |
| `retcon_record` | 개정 기록 | — |
| `issue_record` | 미해결 이슈 | CA-001, TL-003 등 |

---

## 9. 레거시 타입 (기존 호환)

> 기존 lore 파일에서 사용 중인 타입. 점진적으로 위 표준 타입으로 이전 권장.

| 레거시 타입 | 권장 대체 타입 |
|------------|--------------|
| `setting` | `worldbuilding` 또는 `author_note` |
| `worldbuilding` | 그대로 사용 가능 (확장 enum에 포함) |
| `story` | `arc` 또는 `chapter` 또는 `subplot` |
| `reference` | `reference_only` scope와 함께 사용 |
| `guide` | `author_note` |

---

## nry 프로젝트 현재 사용 타입 목록

```yaml
# 핵심 사용 중
- character          # 10개 캐릭터
- worldbuilding      # 운율 시스템, 장소
- magic_system       # 운율 시스템 전체
- cosmic_rule        # 절대 법칙
- power_rule         # 운율 개별 규칙
- timeline_event     # 마일스톤 이벤트
- landmark           # 명성대 장소들
- arc                # Phase-1 ~ Phase-5
- chapter            # Ch.1 ~ Ch.24
- foreshadowing_seed # 복선 목록
- payoff_node        # 복선 회수
- issue_record       # 감사 이슈
- author_note        # 집필 가이드
- artifact           # 빈 이어폰
```

---

*버전: v2.0 | 생성일: 2026-04-02 | 소설: 너라는 운율*
