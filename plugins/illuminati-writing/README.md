# Illuminati Writing

This local plugin packages a curated intelligence-writing workflow grounded in the source corpus extracted in this workspace.

What is included:
- A skill for BLUF-first intelligence writing and cyber analytic products.
- A source digest that synthesizes the recurring rules across the provided CIA, DIA, Army, academic, and cyber tradecraft materials.
- Reusable report templates for quick notes, formal assessments, and cyber maturity snapshots.
- A sharpened analytic mindset layer focused on hypothesis testing, contradiction hunting, and judgment discipline.
- An embedded corpus with all extracted `.txt` source files inside the plugin.
- A master corpus file and manifest for corpus-first operation.
- A distribution bundle in `dist/` for local install or upload to a code host.

Design intent:
- This plugin should behave less like a polite formatter and more like an analytic machine.
- It should force the main judgment to appear early.
- It should challenge weak logic, surface alternative explanations, and tighten vague prose.
- It should prefer decision value over background accumulation.
- It should feel non-human in discipline: colder, more precise, less sentimental, and less tolerant of weak reasoning.
- It should not sound theatrical; its edge should come from control, compression, and superior analytic structure.

Embedded intelligence base:
- Full corpus folder: `skills/illuminati-writing/references/corpus/`
- Corpus manifest: `skills/illuminati-writing/references/corpus-manifest.json`
- Corpus index: `skills/illuminati-writing/references/corpus-index.md`
- Master combined file: `skills/illuminati-writing/references/master-corpus.txt`
- Maximum mentality doctrine: `skills/illuminati-writing/references/corpus-mentality-max.md`
- Operational ruleset: `skills/illuminati-writing/references/doctrine-rules.json`
- Source arbitration matrix: `skills/illuminati-writing/references/conflict-matrix.md`

Reality check:
- The plugin now carries the whole extracted corpus inside itself.
- What can be guaranteed is corpus-first behavior and bundled access to all texts.
- What cannot be guaranteed literally is that an execution environment will hold every character "always in memory" at once under all runtime limits.

Maximum-state goal:
- The plugin should use the corpus as a doctrine engine, not merely as a library.
- That means ranking evidence, testing contradictions, weighing rival hypotheses, and producing tighter decision-ready outputs.
- It now also has a compact operational ruleset and a conflict matrix so the corpus can be applied faster and more consistently.

Workspace support files:
- Raw machine extracts live in `research/illuminati-writing/extracted/`.
- Extraction metadata lives in `research/illuminati-writing/extraction-summary.json`.
- The extractor used for this build lives at `scripts/extract_intelligence_writing_sources.py`.
- Windows OCR recovery for image-heavy PDFs lives at `scripts/ocr_pdf_windows.ps1`.
- The summary rebuilder that reflects OCR output lives at `scripts/rebuild_extraction_summary.py`.

OCR status:
- `DIA_Style_Manual_for_Intelligence_Production.pdf` and `Analytic-Thinking-CIA.pdf` were OCR-recovered and folded into the extracted corpus.

Install options:
- Repo-local: keep this plugin under `plugins/illuminati-writing` with `.agents/plugins/marketplace.json`.
- Home-local: copy the plugin folder to `~/plugins/illuminati-writing` and copy the marketplace entry to `~/.agents/plugins/marketplace.json`.
- Remote hosting: upload the packaged zip from `dist/` to a code host or release page, then distribute that archive together with the manifest metadata.
