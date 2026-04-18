# Conflict Matrix

This matrix tells the plugin how to arbitrate between sources when the corpus offers different emphases.

## Principle

Do not treat every source as equal in every situation.
Resolve conflict by product type, purpose, and decision value.

## Source roles

- `CIA analysis handbook`: strongest on synthesis, statement of synthesis, core assertions, alternative scenarios, and analytic mindset.
- `DIA style manuals`: strongest on sentence control, active voice, paragraph mechanics, qualifiers, headings, and style precision.
- `Army / UWP handbook`: strongest on BLUF pedagogy, concision, plain writing, and reader accessibility.
- `Academic / student guides`: strongest on explaining the difference between academic structure and intelligence structure.
- `SEI cyber tradecraft`: strongest on estimative language, source validation, and cyber analytic tradecraft.
- `C2M2`: strongest on cyber maturity framing, domains, objectives, and capability progression structure.
- `Analysts style manual`: strong reinforcement for BLUF, short paragraphs, active voice, and topic-sentence discipline.
- `6 Intelligence Writing Tips`: strongest as a compact reminder layer, not as a primary adjudicator.

## Arbitration rules

### 1. Structure conflicts

If sources disagree on how much setup to include:
- prefer CIA/Army/Analysts Manual
- outcome: judgment first, background only if it changes comprehension

### 2. Sentence-level style conflicts

If sources disagree on sentence form or mechanics:
- prefer DIA
- outcome: active voice, shorter sentences, cleaner modifiers, precise headings

### 3. Tone conflicts

If one source suggests a more instructional tone and another implies a harder intelligence tone:
- prefer CIA for finished assessments
- prefer Army/academic guides for teaching or onboarding pieces

### 4. Cyber product conflicts

If a cyber product needs both writing discipline and cyber tradecraft:
- structure and prose from CIA/DIA
- caveating and source validation from SEI
- maturity architecture from C2M2 when relevant

### 5. Confidence wording conflicts

If a draft sounds firmer than the evidence:
- confidence discipline overrides rhetoric
- prefer CIA, DIA, and SEI caution over strong-sounding prose

### 6. Background conflicts

If one approach wants more context and another wants tighter compression:
- prefer compression unless the context changes the judgment, implication, or watchpoint

### 7. Non-human voice conflicts

If a harder voice risks becoming theatrical:
- corpus severity loses to analytic credibility
- controlled clarity always outranks dramatic intensity

## Precedence ladder

Use this when fast resolution is needed:

1. Decision value
2. Evidence integrity
3. Judgment clarity
4. Confidence honesty
5. Consumer relevance
6. Stylistic elegance

## Shortcut mappings

- `Need sharper analysis`: CIA -> Analysts Manual -> DIA
- `Need cleaner prose`: DIA -> Army -> Analysts Manual
- `Need cyber rigor`: SEI -> CIA -> DIA -> C2M2
- `Need maturity framing`: C2M2 -> DIA -> CIA
- `Need teaching bridge`: Academic guide -> Army -> CIA

## Failure warning

The plugin is mishandling source conflict when:
- it chooses the most dramatic wording over the most defensible wording
- it chooses more background over a clearer judgment
- it chooses stylistic force over evidence discipline
- it chooses generic fluency over corpus doctrine
