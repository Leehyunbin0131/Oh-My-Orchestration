---
name: write-docs
description: >-
  Use automatically whenever drafting or revising documentation, READMEs, changelogs,
  guides, technical specs, reports, or user-facing UI copy/i18n — both standalone and
  during multi-agent orchestration. Enforces formal Korean register (vocabulary and
  endings), revision preservation, code-verified precision, strictly opt-in Korean
  polishing (`humanize-korean` with `--genre report`), and final CommonMark formatting
  (`make-md`) while staying decoupled from orchestration.
---

# Write Docs (Draft or Revise -> [Optional Polish] -> Format)

Follow this order whenever authoring or revising documentation (`README.md`, `docs/*.md`, `CHANGELOG.md`, guides, specs, reports, presentations, or user-facing UI copy). For Markdown deliverables, always run final formatting **after** the last prose edit.

## 1. Drafting Principles & Technical Register

- **Formal register covers vocabulary AND endings (Korean)**: Default to formal declarative Korean suited for official documents, reports, technical manuals, and presentations (`-hamnida / -imnida`). Formal endings around colloquial words or folk metaphors are a register violation — forbid casual words, anthropomorphism (e.g., describing sensors/models as "seeing" or "forgetting"), and school/exam metaphors in place of domain terms. Keep register uniform within a document unless another tone is requested.
- **Audience & term-first rule**: Default audience = engineer/developer. When a beginner/novice audience is requested, introduce each concept in strict order: **standard domain term -> 1-sentence definition -> real numeric/code example**. Never replace a domain term with a lay paraphrase. Use at most one explicitly marked analogy per section in body text only (after the technical statement), and **never** place analogies or colloquialisms in headings, tables, or Q&A answers.
- **Concrete examples**: Use real values, equations, commands, file paths, or measured results from the project (e.g., `130 / 260 = 0.5`) — not everyday analogies.
- **Fact-based, zero hype**: Ground every claim, input/output count, and qualifier (such as prior/full/only or dataset leakage bounds) in actual code or measurements. Avoid false broad generalizations and marketing adjectives.
- **Selective bolding & concise structure**: Lead with purpose and key takeaway. Keep sentences concise and `CHANGELOG.md` entries <= 3 lines (what changed + user impact). Bold key terms or values selectively — **never bold whole sentences**.
- **Code-scope safety**: Touch only documentation and designated copy/i18n files; never modify application logic during a docs pass.

## 2. Revision Mode (Editing Existing Docs)

- Preserve established headings, domain terminology, register, working code examples, and unaffected sections unless the user explicitly asks to change them.
- Change only the requested scope; note any intentional tone or terminology changes in your summary.
- If a revision grows a document to **at least 1.5x** its pre-edit byte or character length (`>= 1.5x`), stop and verify the scope before finalizing.

## 3. Optional Korean Polishing (`humanize-korean` — Strict Opt-In)

- Never run `humanize-korean` or `humanize-scan` without an **explicit user request**. If you observe a specific translationese issue that obscures meaning, you may *suggest* running `humanize-scan` or `humanize-korean`, but do not run either unasked.
- When explicitly requested: pass **only the requested scope**, specify **`--genre report`** (never generic or official-document labels that route to `essay`), use conservative intensity, and lock code identifiers, domain terms, numbers, and headings.
- Diff changed claims, qualifiers, and identifiers against the pre-polish source before accepting.

## 4. Final Formatting & Precision Check (`make-md` — Always Last for Markdown)

- For **Markdown deliverables only**, apply the installed **`make-md`** skill (CommonMark 0.31.2) **after the final prose edit or optional polish** so formatting is never disturbed downstream. (If `make-md` is unavailable, apply CommonMark 0.31.2 directly.) For non-Markdown deliverables (such as JSON i18n or presentation files), preserve their native format.
- Run a brief final check before finishing: headings are searchable and metaphor-free, Q&A answers use formal technical vocabulary, bolding is selective (no full-sentence bold), and technical claims/qualifiers match the codebase.
