# Source Digest

This digest synthesizes the writing and tradecraft guidance extracted from the source corpus provided in this workspace. It is a synthesis, not a verbatim restatement of any one document.

Bottom line:
- The corpus does not reward decorative prose.
- It rewards analysts who reach a defensible judgment quickly, support it clearly, acknowledge uncertainty honestly, and resist both bias and vagueness.
- In practice, this often creates a voice that feels less human, because it is less apologetic, less sentimental, and less tolerant of ambiguity without explanation.

## Corpus status

The workspace extraction run covered 11 PDFs.

- Full or strong native machine text extraction: `UWP_Handbook_not_to_edit.pdf`, `Intelligence_Writing_for_Academics.pdf`, `intelligence-analysis-reports.pdf`, `DIAstyleManualIntelProd_2016.pdf`, `cia-writing_guide2017.pdf`, `C2M2 Version 2.1 June 2022.pdf`, `analysts_style_manual.pdf`, `6 Intelligence Writing Tips.pdf`, `SEI Innovation Center Report- Cyber Intelligence Tradecraft Project.pdf`
- OCR-recovered and folded into the corpus: `DIA_Style_Manual_for_Intelligence_Production.pdf`, `Analytic-Thinking-CIA.pdf`

Raw extracts live in `research/illuminati-writing/extracted/`, with metadata in `research/illuminati-writing/extraction-summary.json`.

## Repeating principles across the corpus

### 1. Audience and decision come first

Repeated across the academic guide, Army handbook, high-school research guide, CIA writing guide, and the short tip sheet:

- Define the consumer before writing.
- Decide what question the product must answer.
- Make the relevance explicit: why this matters now, to whom, and for what decision.

Working rule:
- Before drafting, answer `Who is the reader?`, `What do they need to know now?`, and `What should they conclude or do?`

### 2. Put the bottom line up front

Repeated across the Army handbook, academic guide, research guide, and analysts' style manual:

- State the central judgment immediately.
- Titles, leads, and key judgments should align.
- The main point should be visible even to a rushed reader.

Working rule:
- Put the main judgment in the title or first paragraph, and keep the first paragraph focused on meaning, not setup.

The OCR-recovered CIA analysis handbook reinforces this with a tighter formulation:

- The title is a contract with the reader.
- The focus is a `statement of synthesis`: the big picture, bottom line, and the `what and so what`.
- If the writer cannot summarize the bottom line in one sentence, the analysis is not yet ready to draft.

### 3. Supporting paragraphs should also be analytic

Repeated across the academic guide, CIA writing guide, and analysts' style manual:

- Each paragraph should open with a topic sentence or analytic point.
- Evidence should support the paragraph lead, not arrive before it.
- Paragraphs should advance the story in a logical sequence.

Working rule:
- Start each paragraph with the point, then add evidence, explanation, or implication.

### 4. Distinguish evidence, judgment, and uncertainty

Repeated across the academic guide, CIA writing guide, research guide, and SEI cyber tradecraft report:

- Separate what is known from what is assessed.
- Be transparent about what supports the judgment.
- Acknowledge uncertainty, alternative explanations, and information gaps.

Working rule:
- Use explicit labels such as `we know`, `we assess`, `we cannot yet confirm`, and `confidence`.

### 5. Bias and source quality must be visible

Repeated across the academic guide, tip sheet, and SEI cyber tradecraft report:

- Consider source bias, acquisition-chain distortion, corroboration, and reporting history.
- Avoid presenting weakly sourced claims as settled fact.
- For cyber analysis especially, source validation and caveated estimative language are core tradecraft.

Working rule:
- When a source issue changes the judgment, name it plainly and show its effect on confidence.

### 6. Style should be concise, direct, and active

Repeated across the Army handbook, DIA manual, analysts' style manual, CIA writing guide, and tip sheet:

- Prefer active voice.
- Use short sentences and short paragraphs.
- Use precise, conventional words.
- Remove redundancy, inflated phrasing, and unnecessary modifiers.

Working rule:
- If a sentence can lose words without losing meaning, cut it. If the actor matters, name the actor.

### 7. Observation is not analysis

Repeated across the tip sheet, CIA writing guide, and research guide:

- Listing facts is not enough.
- The product should explain significance, causation, likelihood, or implication.
- The reader should leave with a sharper understanding than they had before reading.

Working rule:
- After every fact block, ask `So what?` and make the answer explicit.

The OCR-recovered CIA analysis handbook sharpens this even further:

- Intelligence analysts interpret, not merely describe.
- Data dumps are not proof of expertise.
- The goal is to draw conclusions that are greater than the raw facts alone and then defend them logically.

### 8. Paragraphs should behave like mini-briefs

Repeated across the DIA manual, analysts' style manual, academic guide, and CIA analysis handbook:

- Each paragraph should start with a core assertion or topic sentence.
- The rest of the paragraph should prove, explain, or discuss that assertion.
- Material should generally move in decreasing order of importance or from higher-level meaning to supporting detail.

Working rule:
- Treat each paragraph as a small inverted pyramid: point first, support second.

### 9. The analyst's mindset matters as much as the wording

Especially reinforced by the OCR-recovered CIA analysis handbook:

- Analysts are expected to synthesize, not merely accumulate detail.
- They should deal with ambiguity, test assumptions, reconcile conflicting reporting, and consider alternative scenarios.
- Good writing is the visible output of disciplined analytic thinking, not a substitute for it.

Working rule:
- If the judgment would collapse under one hard question, the analysis is not ready.

## Cyber tradecraft additions

The SEI cyber tradecraft report and the C2M2 model add structure useful for cyber-oriented writing:

- Use estimative language and source validation rather than absolute claims.
- Highlight best practices, gaps, and implications for resource allocation or defensive posture.
- For assessments of cyber capability or program maturity, organize analysis around domains, objectives, practices, and maturity levels where that helps comparison.

Working rule:
- In cyber products, pair the judgment with observable indicators, confidence, and likely operational effect.

## Practical synthesis for this plugin

The plugin follows this combined pattern:

1. `BLUF` with the main judgment and why it matters.
2. `Supporting sections` led by topic-sentence judgments or core assertions.
3. `Evidence and reasoning` directly under each judgment.
4. `Confidence and caveats` whenever the evidence is incomplete or contested.
5. `Implications` that translate analysis into decision value.
6. `Alternative explanations` when they materially compete with the main judgment.

## Recommended editing checklist

- Is the main point visible in the first 1-2 sentences?
- Does each paragraph begin with a real point?
- Are evidence and assessment clearly separated?
- Is confidence stated where needed?
- Are bias, sourcing, or corroboration limits visible?
- Can any sentence be shortened without losing meaning?
- Does the piece answer `So what?`
- Does the title match the judgment?
- Did the writer test the best alternative explanation?
- Is any sentence sounding smarter than the evidence allows?
