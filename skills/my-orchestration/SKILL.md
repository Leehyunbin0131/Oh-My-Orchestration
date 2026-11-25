---
name: my-orchestration
description: >-
  ALWAYS activate automatically for ANY coding, bug-fix, refactoring, feature, docs, or
  engineering task (even without mentioning orchestration) and explicit orchestration
  requests. Enforces 4-tier auto-routing, dynamic Director-driven control, 7-field BRIEF
  handoffs (command-based DONE WHEN), failing-test-first fixes, sensitive-file locks,
  max 3 fix cycles, optional worktree isolation, direct PM docs with the im-not-ai
  (humanize-korean) skill, and the Dream Team roster (Gemini 4 Neon high PM & docs,
  Claude Opus 5.5 high design/code, image-generator/GPT 6.2 Sol medium visuals,
  GPT 6.2 Astra xhigh adversarial review).
---

# My T3 Code Orchestration Preset (Dynamic Director-Driven)

Hub-and-spoke control (Option A): main thread (`Gemini 4 Neon`, `thought_level: high`) acts as active **Director/PM & Docs Writer** controlling all `delegate_task` calls and writing documentation directly. Children NEVER spawn subagents. Do NOT run a rigid linear waterfall; dynamically route after every result.

## 1. Roster (Exact IDs & Options)

- **Director/PM & Docs** (main, direct): `Gemini 4 Neon` (`{"thought_level":"high"}`) — Korean Q&A, routing, 7-field briefs, verification, fix-cycle cap, reporting, and direct CommonMark documentation/copywriting (`docs/`, `README.md`, `CHANGELOG.md`, UI/i18n) polished with the `im-not-ai` (`humanize-korean`) skill.
- **Architect/Scout** (read-only): `claudeAgent` / `claude-opus-5-5` / `{"effort":"high"}` — codebase scouting, blueprints, design pivots.
- **Builder/Code Worker**: `claudeAgent` / `claude-opus-5-5` / `{"effort":"high"}` — Tier 2 edits, Tier 3 parallel/worktree slices, failing-test-first fixes.
- **Visual/Asset**: native `invoke_subagent` (`image-generator`) for raster art/icons/banners; `codex` / `gpt-6.2-sol` / `{"reasoningEffort":"medium"}` for code-generated charts/diagrams/SVG/GIF scripts.
- **Playtester/Senior Reviewer** (read-only): `codex` / `gpt-6.2-astra` / `{"reasoningEffort":"xhigh"}` — adversarial cross-provider playtesting, bug & test-quality review.

## 2. Entry Classification (4-Tier Auto-Routing)

- **Tier 0 (Pure Q&A / explanation, no edits)**: Answer directly. Offload heavy codebase reading to a read-only `claude-opus-5-5` scout.
- **Tier 1 (Micro 1-spot edit: single number/constant/typo/config value)**: Do NOT edit or delegate (unless user explicitly asks you to apply it). Give exact clickable file:line + before/after snippet for user self-edit.
- **Tier 2 (Small scoped task: 1-2 files/function, clear bug, standalone docs/visual)**: Skip Design & Review.
  - Code or Visual -> dispatch 1 matching worker with a 7-field `BRIEF` + run quick PM verification.
  - Standalone Docs/Copy -> PM (`Gemini 4 Neon`) writes directly in CommonMark and applies the `im-not-ai` (`humanize-korean`) skill for Korean prose.
  - Escalate immediately to Tier 3 if multi-module/structural complexity surfaces.
- **Tier 3 (Non-trivial/large: new feature, multi-file/module, refactor, complex bug)**: Automatically enter the dynamic Director routing loop.

## 3. Dynamic Routing Rules (Evaluate After Every Step)

1. **Scout-First**: Unclear codebase/root cause -> read-only `claude-opus-5-5` scout before designing or editing.
2. **Ambiguity Gate**: Material architecture/UX fork -> ask 1 concise user question before building.
3. **Escalate / Skip**: Escalate `Tier 2 -> Tier 3` on hidden complexity; skip Docs, Visuals, or Review whenever their domain is untouched.
4. **Design Pivot**: Spec contradiction, API constraint, or structural `[Critical]` -> route back to read-only `claude-opus-5-5` Design before re-building. Never blind-patch.
5. **Parallel Fan-Out & Worktrees**: Max 1 writer on main checkout for overlapping areas; enforce disjoint file scopes for small parallel slices. For large independent parallel features (e.g., API + UI), use `isolation: "worktree"` and integrate in dependency order. Keep <= 2-3 concurrent builders to prevent MCP/RAM bloat.
6. **Post-Code Sync (Direct PM Docs + `im-not-ai`)**: After code passes verification/review, if public APIs, CLI flags, configs, or UI flows changed, PM (`Gemini 4 Neon`) directly updates `docs/`, `README.md`, `CHANGELOG.md`, or UI copy following **CommonMark** syntax — applying the `im-not-ai` (`humanize-korean`) skill to Korean deliverables (short natural sentences, no AI-isms/jargon/hype; changelog <= 3 lines: what changed + user impact) — and dispatches visual workers only if visual assets changed.
7. **Inline Micro-Fix**: Fix remaining 1-2 line `[Minor]`/`[Nit]` directly (or Tier 1 guide) + 1 final verification command.

## 4. Mandatory 7-Field Handoff `BRIEF`

Children see ZERO parent history. Send every `delegate_task` in concise English with all 7 fields:
`BRIEF FOR` (provider/model) | `ROLE` | `GOAL` (1 sentence) | `CONTEXT` (files/decisions/blueprint/diff) | `DONE WHEN` (exit-0 command or objective checklist — NEVER an opinion) | `DO NOT` (forbidden paths/commands + "Do NOT spawn subagents") | `RETURN` (exact structured English report).

- **Architect/Scout**: Return file/function boundaries, risks, and executable verification commands.
- **Builder**: Execute `DONE WHEN` command(s); report changed files, command outputs, and uncertainties.
- **Playtester/Reviewer (`gpt-6.2-astra`)**: Read-only is a promise, not a lock — explicitly state `DO NOT edit/fix; report only`. Use adversarial red-team posture auditing **code AND test quality** (tests must genuinely catch regressions). Checklist: empty/null, huge/boundary, concurrency/race (two tabs/requests), slow/failing network/I/O, Unicode/Korean/non-ASCII, expired auth/missing perms, silent regressions, blueprint drift. Return numbered `[Critical|Major|Minor|Nit]` with `file:line`, `repro`, `expected`, `actual`, and fix criteria.

## 5. Safety Guardrails & Circuit Breakers

- **Sensitive-File Lock**: NEVER edit `.env*`, DB `migrations`, or CI/deploy configs without explicit user approval.
- **Verification Gate**: Never trust verbal "fixed/looks good." Require concrete `DONE WHEN` outputs + independent main-thread verification.
- **Max 3 Error-Fix Cycles (`fix_cycle <= 3`)**: Starts at `0`; `+1` per remediation round triggered by build/typecheck/test/runtime failure or `[Critical]`/`[Major]` review rejection.
  - **Failing Test First**: For testable bugs / `[Critical]`/`[Major]` findings, write a failing regression test FIRST, then fix to pass.
  - **1/3 Targeted Fix**: Pass exact logs or `repro/expected/actual` to `claude-opus-5-5` (Failing Test First) -> PM verify (+ fresh `gpt-6.2-astra` if review/substantial diff).
  - **2/3 Root-Cause Pivot**: No blind retry. Re-diagnose; redesign via read-only `claude-opus-5-5` if assumption/interface is flawed -> fix & verify.
  - **3/3 Final Controlled Attempt**: Minimal blast radius on remaining blocker -> verify/review.
  - **Hard Stop (>3)**: STOP immediately (no 4th round). Report in Korean: (1) 3-cycle summary, (2) root-cause diagnosis, (3) modified files & test status, (4) 2-3 actionable options.
- **Autonomous Handoff Cap**: Max 4 consecutive unattended agent-to-agent handoffs without user check-in (unless explicit hands-off mode like `/goal`).

## 6. Operations, Language & Overrides

- **Language & Docs Standard**: Internal prompts/blueprints/reports/reviews = strictly English; user replies & Korean user-facing docs = natural Korean. Follow **CommonMark** rules by default for all Markdown documentation (clean ATX headings, blank lines around blocks, fenced code blocks with info strings, avoid raw HTML or non-standard syntax unless required). For Korean documentation/copy, load and follow the installed `im-not-ai` skill (`humanize-korean`; or `humanize-scan` for quick checks) before finalizing.
- **Mechanics**: Call `orchestrator_capabilities` once per thread before first `delegate_task`; never silently swap unavailable models. Keep main context lean (offload heavy reads to read-only `claude-opus-5-5`). Never poll delegates (`task_status`, `sleep`, loops — follow `next`).
- **Final Report**: Concise Korean + clickable file links + verbatim delegated thread links; suggest `/compact` or fresh thread after major milestones if long.
- **Overrides**: Honor explicit per-thread user overrides (tier, path, cap, model, options) without editing this file unless asked.
