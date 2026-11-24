# 7-Field Handoff `BRIEF` Templates

Child delegates in T3 Code start with **zero parent conversation history**. Use these English templates verbatim when invoking `delegate_task`.

---

## 1. Architect / Scout (`claudeAgent` / `claude-opus-5-5`, `effort: high`, read-only)

```text
BRIEF FOR: claudeAgent / claude-opus-5-5 (effort: high)
ROLE:      architect (read-only)
GOAL:      Produce a concrete architecture and file/function-level blueprint for <feature/fix>.
CONTEXT:   <user requirements, constraints, key entry files, prior findings>
DONE WHEN: Blueprint covers exact files to modify/create, function/type contracts, edge cases,
           non-overlapping worker slices, risks, and executable verification commands.
DO NOT:    Edit any files, run destructive commands, or spawn subagents.
RETURN:    Concise English blueprint with file boundaries, risks, and exact DONE WHEN commands.
```

---

## 2. Code Worker / Builder (`claudeAgent` / `claude-opus-5-5`, `effort: high`)

```text
BRIEF FOR: claudeAgent / claude-opus-5-5 (effort: high)
ROLE:      builder
GOAL:      <one-sentence implementation or failing-test-first fix outcome>
CONTEXT:   <blueprint excerpt, target files, failure logs or repro/expected/actual>
DONE WHEN: `<exact test/build/typecheck command>` exits 0 and new/updated tests cover the change.
DO NOT:    Touch files outside <allowed paths>, edit .env*/migrations/CI config, or spawn subagents.
RETURN:    English summary: files changed, exact verification command outputs, and any uncertainties.
```

---

## 3. Playtester / Senior Reviewer (`codex` / `gpt-6.2-astra`, `reasoningEffort: xhigh`, read-only)

```text
BRIEF FOR: codex / gpt-6.2-astra (reasoningEffort: xhigh)
ROLE:      playtester / senior reviewer (read-only)
GOAL:      Adversarially break this change and audit both implementation and test quality.
CONTEXT:   <task goal, blueprint summary, git diff or changed file list>
DONE WHEN: Checked empty/null input, huge/boundary input, concurrency/race conditions, slow/failing
           network or I/O, Unicode/non-ASCII strings, expired auth/missing permissions, silent
           regressions, blueprint drift, and whether tests actually catch real regressions.
DO NOT:    Edit or fix any files (report only), or spawn subagents.
RETURN:    English numbered list ranked [Critical|Major|Minor|Nit]; each item must include
           file:line, repro steps, expected, actual, and concrete fix criteria (or "No issues found").
```

---

## 4. Docs / Copywriter (`antigravity` / `gemini-4-hydrogen`, `thought_level: medium`)

```text
BRIEF FOR: antigravity / gemini-4-hydrogen (thought_level: medium)
ROLE:      copywriter
GOAL:      Update user-facing documentation and UI copy for <feature/change>.
CONTEXT:   <final diff summary, user-visible API/CLI/UI changes>
DONE WHEN: Every new user-facing feature/string has clear Korean copy; CHANGELOG entry is <= 3 lines
           explaining what changed and why it matters to the user.
DO NOT:    Touch anything outside docs/, README.md, CHANGELOG.md, and designated UI/i18n files;
           do not use jargon or hype; do not spawn subagents.
RETURN:    English summary of edited files and the final changelog entry.
```
