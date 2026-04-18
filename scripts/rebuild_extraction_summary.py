from __future__ import annotations

import json
import re
from pathlib import Path

import fitz

from extract_intelligence_writing_sources import OUTPUT_ROOT, SOURCE_FILES


def count_native_text_pages(pdf_path: Path) -> tuple[int, int | None, int | None]:
    doc = fitz.open(pdf_path)
    text_pages = 0
    first_text_page: int | None = None
    last_text_page: int | None = None

    for page_index in range(doc.page_count):
        text = doc.load_page(page_index).get_text("text").strip()
        if text:
            text_pages += 1
            page_number = page_index + 1
            if first_text_page is None:
                first_text_page = page_number
            last_text_page = page_number

    return text_pages, first_text_page, last_text_page


def count_extracted_text_pages(text_path: Path) -> tuple[int, int | None, int | None]:
    content = text_path.read_text(encoding="utf-8", errors="ignore").lstrip("\ufeff")
    marker_pattern = re.compile(r"^===== PAGE (\d+) =====\s*$", flags=re.MULTILINE)
    matches = list(marker_pattern.finditer(content))
    text_pages = 0
    first_text_page: int | None = None
    last_text_page: int | None = None

    for index, match in enumerate(matches):
        page_number = int(match.group(1))
        body_start = match.end()
        body_end = matches[index + 1].start() if index + 1 < len(matches) else len(content)
        body = content[body_start:body_end].strip()
        if body and body != "[[NO_EXTRACTED_TEXT]]":
            text_pages += 1
            if first_text_page is None:
                first_text_page = page_number
            last_text_page = page_number

    return text_pages, first_text_page, last_text_page


def slugify(name: str) -> str:
    stem = Path(name).stem.lower()
    stem = re.sub(r"[^a-z0-9]+", "-", stem)
    return stem.strip("-")


def main() -> None:
    summaries: list[dict[str, object]] = []

    for pdf_path in SOURCE_FILES:
        text_path = OUTPUT_ROOT / "extracted" / f"{slugify(pdf_path.name)}.txt"
        doc = fitz.open(pdf_path)
        native_text_pages, native_first, native_last = count_native_text_pages(pdf_path)
        extracted_text_pages, extracted_first, extracted_last = count_extracted_text_pages(text_path)
        content = text_path.read_text(encoding="utf-8", errors="ignore")

        summaries.append(
            {
                "file_name": pdf_path.name,
                "source_path": str(pdf_path),
                "page_count": doc.page_count,
                "native_text_pages": native_text_pages,
                "native_empty_pages": doc.page_count - native_text_pages,
                "native_first_text_page": native_first,
                "native_last_text_page": native_last,
                "extracted_text_pages": extracted_text_pages,
                "extracted_empty_pages": doc.page_count - extracted_text_pages,
                "extracted_first_text_page": extracted_first,
                "extracted_last_text_page": extracted_last,
                "ocr_applied": extracted_text_pages > native_text_pages,
                "characters": len(content),
                "output_text": str(text_path),
            }
        )

    summary_path = OUTPUT_ROOT / "extraction-summary.json"
    summary_path.write_text(json.dumps(summaries, indent=2), encoding="utf-8")
    print(f"Summary written to {summary_path}")


if __name__ == "__main__":
    main()
