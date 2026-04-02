# Hard Gate Policy
## Universal Prompt Pack v1 | System Policy

---

## Purpose

Hard gates define the conditions under which a text is automatically blocked from approval and cannot proceed to the next stage without mandatory rework.

Soft gates identify quality issues that require attention but do not block progression.

---

## Hard Gate Conditions

A text is blocked (blocked_for_publish = true) if ANY of the following is true:

### Canon Hard Gates

```
HC-01: Direct contradiction with official canon
  → A statement, event, or behavior directly contradicts an
    official-status canon note.

HC-02: Impossible timeline
  → A character is in two places at once, or an event occurs
    before its necessary cause, within canon-established timeframes.

HC-03: Core system rule violation
  → A character uses an ability, accesses a location, or triggers
    a mechanism that official canon defines as impossible for them.
```

### Narrative Hard Gates

```
HC-04: Major decision without credible motive or transition
  → A character makes a significant choice (alliance change,
    sacrifice, betrayal, commitment) with no shown internal
    or external trigger.

HC-05: Impossible knowledge in POV handling
  → The POV character knows something they cannot know based on
    their in-story experience and information access.

HC-06: Core reveal without sufficient setup
  → A major reveal (identity, truth, mechanism) is delivered
    without traceable prior setup. Reader cannot be surprised
    and satisfied simultaneously.
```

### Design Hard Gates

```
HC-07: Draft canon treated as official canon
  → A design output or draft relies on unconfirmed, draft-status
    content as though it were settled fact.

HC-08: Confirmed ending or arc retroactively contradicted
  → Output contradicts a previously confirmed design decision
    without Canon Governance Manager approval.
```

---

## Soft Gate Conditions

Soft gates do not block progression but require resolution before final approval:

```
SG-01: Slow pacing
  → 3+ scenes in a row with no plot, character, or relationship change.
  Severity: minor to major depending on length.

SG-02: Exposition density
  → Sustained information delivery without action or dialogue.
  Severity: minor.

SG-03: Weak dialogue rhythm
  → Characters sound similar, or lines are primarily information delivery.
  Severity: minor.

SG-04: Underused scene
  → Scene serves only one weak function and could be compressed.
  Severity: minor.

SG-05: Low thematic clarity
  → Theme is not expressed or challenged in the scene.
  Severity: info.

SG-06: Weak turning point
  → Turning point is reversible or coincidence-dependent.
  Severity: minor to major.

SG-07: Voice inconsistency
  → Character's speech pattern drifts from established profile.
  Severity: minor to major.
```

---

## Gate Processing Rules

```
1. Hard gate violations must be identified by at least one audit agent
   with evidence before blocking.

2. A single hard gate violation blocks the entire unit
   (scene, episode, arc) regardless of how many soft gates pass.

3. Soft gate findings accumulate. If 5+ soft gates fail in a single
   unit, escalate to major severity.

4. Hard gate resolution requires rework and regression check.
   Soft gate resolution may use Patch Generator.

5. Info-level findings are advisory only. No blocking, no rework required.
```

---

## Hard Gate Verdict Reference

| Verdict | Condition | Action |
|---------|-----------|--------|
| `pass` | No hard or soft gates failed | Proceed |
| `soft_fail` | Soft gates only | Patch Generator + continue |
| `hard_fail` | Any hard gate triggered | Block + mandatory rework |

---

*Prompt version: v1.0 | Universal Pack | novelwriter*
