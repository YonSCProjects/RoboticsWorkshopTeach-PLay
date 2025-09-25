## Project Context: Reaction Timer (Cursor‑Only Build)

This file gives Cursor all the context needed to generate and edit the project without the student writing code manually. Students will only prompt, test, and iterate.

### Goals

- Build a browser‑based Reaction Timer with states: idle → waiting → ready → clicked/too soon.
- No manual code typing by students; all changes are AI‑authored via Cursor edit flows.
- Persist best time with `localStorage`; optional avg(10) and keyboard control.

### Constraints

- HTML/CSS/JS in a single `index.html` initially; may refactor to separate files if Cursor proposes clear diffs.
- Keep UI readable (contrast), responsive, and simple. No external build tools.
- Timing via `performance.now()`; avoid libraries.

### Acceptance Tests (teacher runs after each Cursor change)

1. Start → panel shows “Wait for green…”; after 1.2–3.2 s becomes green.
2. Click while waiting → shows “Too soon!”; disables click until Start.
3. Click when green → shows time in ms; increments attempts; updates best if lower.
4. Refresh page → best time remains (localStorage). If blocked, no errors and game still works.
5. Optional: Spacebar works as Start/Click; Avg(10) shows after attempts.

### Environment

- Run locally by double‑clicking `index.html` in a modern browser.

### Editing Policy (Cursor‑Only)

- Students will ask Cursor to create and edit files. Students must:
  - Paste this `CONTEXT.md` into Cursor once, then reference it in prompts.
  - Always ask for FILE‑SCOPED edits (e.g., “Edit `index.html` adding X between Y and Z”).
  - After each change, run and report exact outcomes to Cursor for the next iteration.

### Next Action for Cursor

- Create or overwrite `tutorials/cursor-only-reaction-timer.md` with a student‑facing, step‑by‑step guide for running this build fully via Cursor, including copy‑paste‑ready prompts and checkpoints aligned to the Acceptance Tests above.


