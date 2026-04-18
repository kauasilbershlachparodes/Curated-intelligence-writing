from __future__ import annotations

import json
import re
from dataclasses import asdict, dataclass
from pathlib import Path

import fitz


SOURCE_FILES = [
    Path(r"C:\Users\CIA\Desktop\SEI Innovation Center Report- Cyber Intelligence Tradecraft Project.pdf"),
    Path(r"C:\Users\CIA\Desktop\UWP_Handbook_not_to_edit.pdf"),
    Path(r"C:\Users\CIA\Desktop\Intelligence_Writing_for_Academics.pdf"),
    Path(r"C:\Users\CIA\Desktop\intelligence-analysis-reports.pdf"),
    Path(r"C:\Users\CIA\Desktop\DIA_Style_Manual_for_Intelligence_Production.pdf"),
    Path(r"C:\Users\CIA\Desktop\DIAstyleManualIntelProd_2016.pdf"),
    Path(r"C:\Users\CIA\Desktop\cia-writing_guide2017.pdf"),
    Path(r"C:\Users\CIA\Desktop\C2M2 Version 2.1 June 2022.pdf"),
    Path(r"C:\Users\CIA\Desktop\Analytic-Thinking-CIA.pdf"),
    Path(r"C:\Users\CIA\Desktop\analysts_style_manual.pdf"),
    Path(r"C:\Users\CIA\Desktop\6 Intelligence Writing Tips.pdf"),
]

OUTPUT_ROOT = Path("research") / "illuminati-writing"
EXTRACTED_ROOT = OUTPUT_ROOT / "extracted"


@dataclass
class ExtractionSummary:
    file_name: str
    source_path: str
    page_count: int
    text_pages: int
    empty_pages: int
    characters: int
    first_text_page: int | None
    last_text_page: int | None
    output_text: str


def slugify(name: str) -> str:
    stem = Path(name).stem.lower()
    stem = re.sub(r"[^a-z0-9]+", "-", stem)
    return stem.strip("-")


def normalize_text(text: str) -> str:
    text = text.replace("\x00", " ")
    text = text.replace("\u2010", "-")
    text = text.replace("\u2011", "-")
    text = text.replace("\u2012", "-")
    text = text.replace("\u2013", "-")
    text = text.replace("\u2014", "-")
    text = text.replace("\u2018", "'")
    text = text.replace("\u2019", "'")
    text = text.replace("\u201c", '"')
    text = text.replace("\u201d", '"')
    text = text.replace("\u2022", "*")
    text = re.sub(r"[ \t]+\n", "\n", text)
    text = re.sub(r"\n{3,}", "\n\n", text)
    return text.strip()


def extract_document(pdf_path: Path) -> ExtractionSummary:
    slug = slugify(pdf_path.name)
    output_path = EXTRACTED_ROOT / f"{slug}.txt"
    doc = fitz.open(pdf_path)

    pages: list[str] = []
    text_pages = 0
    first_text_page: int | None = None
    last_text_page: int | None = None

    for page_index in range(doc.page_count):
        raw = doc.load_page(page_index).get_text("text")
        cleaned = normalize_text(raw)
        if cleaned:
            text_pages += 1
            page_number = page_index + 1
            if first_text_page is None:
                first_text_page = page_number
            last_text_page = page_number
        else:
            page_number = page_index + 1
            cleaned = "[[NO_EXTRACTED_TEXT]]"

        pages.append(f"===== PAGE {page_number} =====\n{cleaned}\n")

    combined = "\n".join(pages).strip() + "\n"
    output_path.write_text(combined, encoding="utf-8")

    return ExtractionSummary(
        file_name=pdf_path.name,
        source_path=str(pdf_path),
        page_count=doc.page_count,
        text_pages=text_pages,
        empty_pages=doc.page_count - text_pages,
        characters=len(combined),
        first_text_page=first_text_page,
        last_text_page=last_text_page,
        output_text=str(output_path),
    )


def main() -> None:
    EXTRACTED_ROOT.mkdir(parents=True, exist_ok=True)
    summaries = [asdict(extract_document(path)) for path in SOURCE_FILES]

    summary_path = OUTPUT_ROOT / "extraction-summary.json"
    summary_path.write_text(json.dumps(summaries, indent=2), encoding="utf-8")

    print(f"Extracted {len(summaries)} documents into {EXTRACTED_ROOT}")
    print(f"Summary written to {summary_path}")


if __name__ == "__main__":
    main()
