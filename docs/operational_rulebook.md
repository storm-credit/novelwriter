# Operational Rulebook
## Agent Prompt Pack ↔ Obsidian Note Types
## novelwriter v1

---

## 1. Purpose

This rulebook defines how each agent interacts with Obsidian note types inside a canon-driven writing system.

It answers five operational questions:
1. Which notes should each agent read first?
2. Which notes are optional support context?
3. Which notes must never be treated as authoritative?
4. What kind of output should each agent produce?
5. Where should that output go next?

**The full loop:**
```
Canon notes → Structure notes → Drafting outputs → Audit outputs → Revision routing
```

---

## 2. Note Family Authority Rules

| Family | Purpose | Authority Level |
|--------|---------|----------------|
| **A. Canon Entity Notes** | Defines what exists and what is true | Highest (governs truth) |
| **B. Story Structure Notes** | Defines what is planned or being written | Medium (governs intent) |
| **C. System / Process Notes** | Supports governance and workflow | Low (governs workflow only) |

**Canon Entity Notes**: Character, Faction, Location, Rule/System, Timeline Event

**Story Structure Notes**: Project Overview, Volume, Arc, Chapter, Scene

**System / Process Notes**: Issue Record, Canon Standards, Prompt Specs, Workflow Rules, Draft/Sandbox Notes

### Authority Rules

```
Rule 1: Canon Entity Notes govern truth.
Rule 2: Story Structure Notes govern intent — do not override official canon.
Rule 3: System/Process Notes govern workflow, not world truth.
Rule 4: draft, sandbox, deprecated, retconned notes must NEVER override official notes.
Rule 5: If structure note conflicts with canon → canon wins unless explicitly
         marked new_canon_candidate or retcon_candidate.
```

---

## 3. Agent Operating Model

Every agent follows this sequence:

```
Step 1: Identify task context (design | writing | audit)
Step 2: Identify current unit (project | volume | arc | chapter | scene | entity)
Step 3: Retrieve required notes in strict priority order
Step 4: Produce structured output (schema-based, not freeform only)
Step 5: Route output forward
```

### Retrieval Priority Order

```
Priority 1: Direct note (the exact entity being worked on)
Priority 2: Related entities (related_entities[], parent_entity)
Priority 3: Governing rules (governing_rules[])
Priority 4: Timeline context (era, timeline_start/end, event notes)
Priority 5: Optional support context (adjacent notes, prior summaries)
```

---

## 4. Design Division Agent Rules

Design agents work primarily from:
- Project Overview, Volume, Arc
- Character, Faction, Rule/System, Timeline Event

**Must not treat as authoritative:**
- Sandbox notes, loose brainstorming, deprecated notes, raw draft scenes

---

### 4-1. Story Architect

| Item | Content |
|------|---------|
| **Required notes** | Project Overview, Volume, Arc, main Character notes, core Faction notes, core Rule/System notes |
| **Optional notes** | Theme notes, major timeline events, prior issue records, ending plan |
| **Responsibilities** | Define structural model, conflict movement, arc sequencing, unresolved dependencies |
| **Output destination** | Arc note updates, Volume plan updates, manager output object |
| **Must not do** | Write polished prose, declare draft ideas as canon fact, ignore hard constraints |

---

### 4-2. Plot Designer

| Item | Content |
|------|---------|
| **Required notes** | Arc note, Chapter note(s), Timeline Event notes, Faction notes, Character notes, Rule/System notes |
| **Optional notes** | Location notes, issue records, previous chapter summaries |
| **Responsibilities** | Event sequence, cause-effect chain, reveal timing, setup/payoff mapping, weak transition detection |
| **Output destination** | Arc note, Chapter note, scene planning queue |

---

### 4-3. Character Arc Designer

| Item | Content |
|------|---------|
| **Required notes** | Character note, Arc note, relevant relationship notes, relevant event notes |
| **Optional notes** | Chapter summaries, issue records related to motivation or voice |
| **Responsibilities** | Define transformation line, false belief/desire/need, pressure points, required bridge scenes |
| **Output destination** | Character note, Arc note, Chapter planning hints |

---

### 4-4. Ending Designer

| Item | Content |
|------|---------|
| **Required notes** | Project Overview, Volume/Arc notes, main Character notes, core conflict notes, theme notes |
| **Responsibilities** | Recommend ending mode, define closure requirements, identify setup dependencies |
| **Output destination** | Project Overview, Volume note, ending strategy object |

---

### 4-5. Theme Designer

| Item | Content |
|------|---------|
| **Required notes** | Project Overview, Arc notes, main Character notes, conflict notes, major event notes |
| **Responsibilities** | Define thematic spine, detect thematic drift, align symbols/motifs/conflict |
| **Output destination** | Project Overview, Arc note, theme support map |

---

## 5. Writing Division Agent Rules

Writing agents work primarily from:
- Scene, Chapter, Arc
- Character, Location, Rule/System

**Must not treat as authoritative:**
- Unresolved brainstorm fragments, unsupported structural assumptions, draft canon not yet accepted

---

### 5-1. Scene Designer

| Item | Content |
|------|---------|
| **Required notes** | Scene note, Chapter note, Arc note, relevant Character notes, relevant Location note, relevant Rule/System note (if power/action involved) |
| **Responsibilities** | Define scene purpose, beats, emotional and information shifts, canon-sensitive elements |
| **Output destination** | Scene note, Draft Composer input object |
| **Block condition** | If scene purpose is missing, drafting must not begin |

---

### 5-2. Draft Composer

| Item | Content |
|------|---------|
| **Required notes** | Approved Scene design object, Scene note, POV Character note, Location note, relevant Rule/System note, previous scene summary |
| **Optional notes** | Chapter note, dialogue voice notes, continuity issue records |
| **Responsibilities** | Produce prose draft, preserve POV/canon/emotional shift, flag invention candidates |
| **Output destination** | Draft file, Writing Harness, Audit queue |
| **Must not do** | Create hard canon silently, ignore knowledge boundaries, contradict official rules |

---

### 5-3. Dialogue Coach

| Item | Content |
|------|---------|
| **Required notes** | Character note(s), Scene note, draft excerpt, relationship sections |
| **Responsibilities** | Character-specific dialogue, reduce exposition delivery, improve subtext |
| **Output destination** | Revised dialogue block, draft patch object |

---

### 5-4. Narrative Style Coach

| Item | Content |
|------|---------|
| **Required notes** | Draft excerpt, Scene note, Chapter note, author style guidance if available |
| **Responsibilities** | Preserve tone/POV discipline, improve readability, tune descriptive density |
| **Output destination** | Revised passage, style notes, warning list |

---

### 5-5. Bridge Scene Generator

| Item | Content |
|------|---------|
| **Required notes** | Previous Scene note, next Scene note, relevant Character notes, event/timeline context, issue record that triggered the bridge request |
| **Responsibilities** | Classify missing gap, propose smallest bridge, preserve canon logic |
| **Output destination** | Scene note patch, Draft Composer queue, Audit rerun target |

---

## 6. Audit Division Agent Rules

Audit agents work primarily from:
- Draft output (scene or chapter)
- Scene/Chapter/Arc notes, Canon entity notes
- Issue records, Rule notes, Timeline event notes

**Must not treat as authoritative:**
- Sandbox material, pure brainstorming outputs, unresolved exploratory design notes

---

### 6-1. Canon Auditor

| Item | Content |
|------|---------|
| **Required notes** | Draft or design output, related Character notes, related Rule/System notes, related Location/Faction notes, cited Timeline Event note |
| **Responsibilities** | Detect direct contradiction, detect unsupported assumption, cite canon references, classify ambiguity vs contradiction |
| **Output destination** | Issue Record, Audit Harness, Writing or Design return route |

---

### 6-2. Timeline Auditor

| Item | Content |
|------|---------|
| **Required notes** | Scene/Chapter note, Timeline Event notes, Location notes, travel-related rule notes, adjacent chapter anchors |
| **Responsibilities** | Check chronology, travel logic, elapsed time gaps, co-location plausibility |
| **Output destination** | Issue Record, timeline correction proposal, regression target list |

---

### 6-3. Causality Auditor

| Item | Content |
|------|---------|
| **Required notes** | Arc note, Chapter/Scene note, event chain from Plot Designer, relevant issue records |
| **Responsibilities** | Detect weak cause-effect chains, missing consequences, convenience-based progression, unsupported reversals |
| **Output destination** | Issue Record, bridge request, design revision request |

---

### 6-4. Motivation Auditor

| Item | Content |
|------|---------|
| **Required notes** | Character note, Scene/Chapter note, recent scene chain, relationship sections, triggering event notes |
| **Responsibilities** | Detect under-motivated decisions, emotional jump, missing internal trigger |
| **Output destination** | Issue Record, Bridge Scene Generator queue, Character Arc Designer review |

---

### 6-5. Structure Auditor

| Item | Content |
|------|---------|
| **Required notes** | Project Overview, Volume/Arc notes, Chapter sequence, ending strategy note, issue history |
| **Responsibilities** | Assess structural coherence, escalation rhythm, turning point strength, closure balance |
| **Output destination** | Arc/Volume revision notes, Issue Record, Story Architect return route |

---

### 6-6. Scene Utility Auditor

| Item | Content |
|------|---------|
| **Required notes** | Scene note, chapter context, current draft, chapter purpose |
| **Responsibilities** | Determine whether scene earns its place, identify redundancy, recommend keep/revise/merge/remove |
| **Output destination** | Issue Record, Writing Manager route |

---

### 6-7. Reader Experience Simulator

| Item | Content |
|------|---------|
| **Required notes** | Draft chapter or scene, Chapter note, Arc note, reveal strategy context |
| **Responsibilities** | Identify boredom points, curiosity peaks, confusion, payoff failure |
| **Output destination** | Reader attention map, audit recommendation object, structure or writing return route |

---

## 7. Harness Operating Rules

**Harness agents do not create story content. They regulate process.**

| Harness | Reads | Writes |
|---------|-------|--------|
| **Global** | Current task/output object, canon filters, project config | Validation object, route decision, blocker list |
| **Design** | Design outputs, canon notes, project config | Design safety state, provisional element list, dependency list |
| **Writing** | Scene design output, draft output, canon refs, scene note | Readiness object, invention flags, audit queue state |
| **Audit** | Audit outputs, issue candidates, revision history | Accepted findings, fail classification, regression schedule, return route |

---

## 8. Manager Routing Rules

**Managers coordinate. They do not generate world truth.**

| Managers MAY | Managers MUST NOT |
|-------------|------------------|
| Select agents | Silently invent canon |
| Merge outputs | Overwrite official canon |
| Prioritize issues | Replace audit evidence with intuition |
| Classify next steps | Directly author large prose scenes (unless explicitly configured) |
| Escalate contradictions | |

---

## 9. Output Routing Matrix

| From | Output Type | Goes To |
|------|------------|---------|
| Story Architect | Structure proposal | Plot Designer / Character Arc Designer / Design Harness |
| Plot Designer | Event chain / setup-payoff map | Arc/Chapter planning / Scene Designer |
| Character Arc Designer | Arc map | Scene Designer / Motivation Auditor |
| Ending Designer | Ending strategy | Story Architect / Structure Auditor |
| Scene Designer | Scene design object | Draft Composer / Writing Harness |
| Draft Composer | Prose draft | Dialogue Coach / Style Coach / Audit Queue |
| Dialogue Coach | Dialogue patch | Draft Composer / Audit Queue |
| Style Coach | Style patch | Draft Composer / Audit Queue |
| Bridge Scene Generator | Bridge proposal | Draft Composer / Audit Queue |
| Canon Auditor | Canon issues | Audit Harness / Writing Manager / Design Manager |
| Timeline Auditor | Timeline issues | Audit Harness / Writing Manager |
| Causality Auditor | Causality issues | Audit Harness / Plot Designer / Writing Manager |
| Motivation Auditor | Motivation issues | Audit Harness / Bridge Generator / Character Arc Designer |
| Structure Auditor | Structure issues | Audit Harness / Story Architect |
| Scene Utility Auditor | Utility verdict | Audit Harness / Writing Manager |
| Reader Experience Simulator | Attention report | Audit Harness / Writing Manager / Structure Auditor |

---

## 10. Stop Conditions

### Design stop conditions
- Unresolved canon dependency
- Structure depends on unknown rule
- Design contradicts official canon

### Writing stop conditions
- Scene goal missing
- POV unclear
- Canon-sensitive action lacks rule validation
- New canon introduced without tagging

### Audit stop conditions
- No evidence for claim
- Note scope invalid
- Canon ambiguity unresolved
- Duplicated issue already under correction

---

## 11. Standard V1 Workflow (New Chapter)

```
Phase A: Design
  1. Story Architect → confirms arc intent
  2. Plot Designer → maps chapter event role
  3. Character Arc Designer → confirms emotional movement
  4. Design Harness → validates unresolved canon dependencies

Phase B: Writing
  5. Scene Designer → defines scene roles and beats
  6. Draft Composer → writes draft
  7. Dialogue Coach + Style Coach → refine
  8. Writing Harness → confirms canon-safe readiness

Phase C: Audit
  9. Canon Auditor → checks contradictions
  10. Motivation Auditor → checks emotional logic
  11. Structure Auditor → checks chapter role
  12. Audit Harness → merges verdict, routes revision if needed
```

---

## 12. Best Practice Notes

```
1. Keep canon notes and structure notes physically separate in the vault.
2. Never let structure notes silently rewrite canon notes.
3. Every audit issue must cite: canon notes, structure notes, or draft evidence (or all three).
4. Use Issue Records for repeated weaknesses — prevents re-discovering the same problem.
5. Allow design freedom — but label exploratory clearly until confirmed.
6. When in doubt about authority: canon entity notes > structure notes > brainstorm.
```

---

*버전: v1.0 | 생성일: 2026-04-02 | 소설: 너라는 운율*
