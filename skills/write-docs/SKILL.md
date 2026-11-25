---
name: write-docs
description: >-
  Use automatically whenever writing, updating, or polishing documentation, READMEs,
  changelogs, guides, technical specs, reports, or user-facing UI copy/i18n — both
  standalone and during multi-agent orchestration. Enforces formal Korean register
  (official documents, reports, manuals, presentations) by default and coordinates
  drafting principles with installed formatting (`make-md`) and Korean prose polishing
  (`humanize-korean` / `humanize-scan`) skills while keeping documentation concerns
  decoupled from orchestration.
---

# Write Docs (Draft -> Format -> Polish)

Follow this lightweight 3-stage pipeline whenever authoring or revising documentation (`README.md`, `docs/*.md`, `CHANGELOG.md`, guides, specs, reports, presentations, or user-facing UI copy).

## 1. Drafting Principles & Default Register

- **Formal register by default (Korean)**: Write Korean documents in a clean, formal declarative register suited for official documents, reports, technical manuals, and presentations (formal polite `-hamnida / -imnida` endings).
  - Prefer formal, precise verbs and phrasing over colloquialisms or spoken contractions (e.g., avoid casual spoken wording such as informal "use/write" equivalents; use formal verbs consistently).
  - Never mix sentence-ending registers within the same document unless the user explicitly requests another tone (such as plain academic style or casual UI copy).
- **Lead with the point**: State the document's purpose, audience, and core takeaway in the opening paragraph.
- **Fact-based, zero hype**: Ground every claim in actual code, commands, or verified behavior. Avoid marketing adjectives, filler, and unverified assumptions.
- **Concise, scannable structure**: Use short sentences, one main idea per paragraph, and concrete examples. Keep `CHANGELOG.md` entries <= 3 lines stating what changed and why it matters to users.
- **Scope safety**: Touch only documentation and designated copy/i18n files; never alter application code during a docs pass.

## 2. Markdown Formatting (`make-md`)

- For all Markdown files, load and apply the installed **`make-md`** skill (CommonMark 0.31.2 rules: clean ATX headings, blank lines between blocks, fenced code blocks with info strings, safe emphasis/tilde boundaries around Korean particles and punctuation, and avoiding unnecessary raw HTML or non-standard syntax).
- If `make-md` is unavailable, still adhere strictly to CommonMark 0.31.2.

## 3. Korean Prose Polishing (`humanize-korean` / `humanize-scan`)

- For user-facing **Korean** documentation or copy, finish by applying the installed **`humanize-korean`** skill (or **`humanize-scan`** first for a quick check on short or already-clean prose) to remove AI-isms and translationese without altering any facts, numbers, or technical terms.
- **Lock formal register during polishing**: Explicitly specify the genre as formal report / technical manual / official document so polishing removes AI translationese **without** downgrading formal endings or formal verbs into casual spoken phrasing.
- Skip Korean polishing for strictly English documentation; verify clarity and conciseness directly.
- If `humanize-korean` is unavailable, manually remove translationese, stock AI phrases, and repetitive phrasing while preserving formal register.
