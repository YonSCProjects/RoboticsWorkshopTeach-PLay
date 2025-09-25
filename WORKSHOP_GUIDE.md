## Robotics & Coding Workshop Guide

This living guide is the single source of truth for running a trauma‑informed, inclusive, project‑based Robotics & Coding workshop for grades 7–12. It blends proven pedagogy, maker‑space routines, and LLM‑assisted learning to help students grow technical skill, collaboration, and self‑regulation.

— Maintain this file alongside your projects. Link or embed images into the `images/` folder using the conventions below.


### 1) Audience, Context, and Design Principles

- **Learners**: 7th–12th graders with diverse needs: strong individuality and opposition, significant learning difficulties, a spectrum of externalizing (often verbal) and internalizing (anxiety, depression, social communication) behaviors.
- **Implications**:
  - **Trauma‑informed**: predictability, choice, voice, co‑regulation, and dignified exits from escalation.
  - **Neurodiversity‑affirming**: sensory breaks, alternative communication, visual supports, explicit routines.
  - **Mastery‑based**: small wins, visible progress, re‑attempts welcome.
  - **Universal Design for Learning (UDL)**: multiple means of engagement, representation, and action/expression.
  - **Constructionist & Project‑based**: learning by making authentic artifacts.


### 2) Teaching Approach and Workshop Flow

- **Core pedagogy**: Project‑Based Learning (PBL), Constructionism, Cognitive Apprenticeship, Gradual Release (I do → We do → You do), and Deliberate Practice.
- **Session routine (predictable rhythm)**:
  1. Arrival & check‑in (2–5 min): visual schedule, “today’s wins,” role selection.
  2. Mini‑lesson or demo (5–10 min): one focused concept or skill.
  3. Build time (30–60 min): teams follow tutorial steps, with checkpoints.
  4. Share & reflect (5–10 min): 1 artifact + 1 learning + 1 next step.
  5. Reset (5 min): kit inventory, charge batteries, log issues.
- **Roles** (rotate each session): Driver (hands‑on), Navigator (reads tutorial, sanity checks), Documentarian (photos/log), Peacekeeper (de‑escalation script & timekeeper).


### 3) Behavior Supports and SEL Integration

- **Foundations**: clear norms, co‑created team contracts, private redirection, celebrate process.
- **De‑escalation protocol** (posters at stations):
  - Notice → Name → Normalize → Next Step. Offer choices: “Reset station,” “Walk & water,” “Quiet task,” “Switch roles.”
  - Use respectful scripts: “I see you’re frustrated; we can pause and pick one helpful next step.”
- **Restorative brief** (after conflict): what happened, who was affected, how to repair, what support is needed.
- **SEL skills** embedded: emotion labeling, frustration tolerance, turn‑taking, assertive communication, help‑seeking.


### 4) Safety, Space, and Logistics

- **Safety basics**: no running; eye protection as needed; no exposed wires near metal; disconnect power before re‑wiring; respect personal space.
- **LEGO Mindstorms**: protect cables and ports; secure battery; tidy wire routing.
- **Arduino/electronics**: power off before changes; double‑check polarity; mind 5V/3.3V limits; avoid short circuits.
- **Kit management**: each kit has an ID; inventory before/after; damaged parts logged; chargers kept at a charging bar.
- **Images**: photos only of projects/hands unless student media consent is on file.


### 5) LLM‑Assisted Learning Framework

- **Purpose**: a supportive coach, not a shortcut. Use LLMs to plan, scaffold, debug, reflect; verify outputs with tests.
- **Ground rules**: protect privacy; attribute AI assistance; never paste personal data; verify code before running.
- **Prompt patterns**:
  - Plan → Implement → Verify → Reflect: “Help me plan the steps, then I’ll try, then you help me test and reflect.”
  - Debug‑with‑context: paste minimal reproducible example, error, expected behavior, constraints.
  - Rubber Duck: “Ask me questions until you can explain my bug back to me.”
  - Scaffold‑first: “Give me a starter checklist; don’t give answers yet.”
- **Student LLM checklist**: Did I specify hardware, versions, goals, constraints? Did I ask for small steps? Did I test safely? Did I cite what came from the LLM?


### 6) Project Lifecycle Template (copy/paste per tutorial)

Use this template to author every tutorial consistently.

— START TEMPLATE —

#### Project Title

- **Why this matters**: real‑world tie‑in in 1–2 sentences.
- **Learning goals**:
  - Robotics/coding concepts (e.g., sensors, loops, state, debugging)
  - SEL/process skills (e.g., turn‑taking, frustration tolerance)
- **Prerequisites**: what students should know or have practiced.
- **Materials**: exact kit, sensors/actuators, cables, laptop/IDE, batteries.
- **Time**: total and per section; **Difficulty**: 1–5; **Team size**: 1–3.
- **Safety notes**: callouts for power, motion, sharp edges.

##### Setup
1) Prepare hardware (photos: `images/<slug>/setup-01.png`).
2) Prepare software/IDE, libraries, versions.

##### Build Steps
1) Step with a clear action and a micro‑goal.
2) Screenshot or diagram (`images/<slug>/step-02.png`).
3) Short validation (“You should see… If not, go to Troubleshooting.”)

##### Checkpoints
- CP‑1: What state should be true? How do we measure it?
- CP‑2: Quick test script or sensor read‑out.

##### Troubleshooting
- Symptom → Likely cause → Quick test → Fix.
- Safe rollback steps.

##### Assessment
- Evidence: photo/video, code snippet, log output.
- Rubric (Emerging / Developing / Proficient / Advanced) aligned to goals.

##### Extensions & Choice
- Add a feature; remix behavior; apply to a new context; cross‑disciplinary tie‑ins.

##### Reflection
- “What worked?”, “Where did I get stuck?”, “What helped me?”, “What will I try next time?”

— END TEMPLATE —


### 7) Assessment and Mastery

- **Mastery levels**: Emerging (needs heavy scaffolds), Developing (partial independence), Proficient (independent), Advanced (teaches others, optimizes).
- **Evidence sources**: working demo, code readability, logs/measurements, design notes, reflections, peer feedback.
- **Feedback cadence**: checkpoint comments during build; brief exit ticket; weekly portfolio review.
- **Accommodations**: alternative demonstrations (verbal walkthroughs, recorded videos), extended time, simplified rubrics.


### 8) Differentiation & Inclusion Playbook

- **For externalizing behaviors**: proactive roles; short, kinetic tasks; non‑verbal cues; private resets; clear “stop” and “resume” scripts.
- **For anxiety/withdrawal**: predictable tasks, quiet corners, written prompts, buddy‑check, asynchronous reflection.
- **For learning difficulties**: chunk steps into micro‑goals, heavy visuals, sentence starters, word banks, exemplars, extra practice loops.
- **Language & communication**: allow AAC/gestures; diagrams count as explanations; pair with supportive peers.


### 9) Equipment, Inventory, and Maintenance

- **Labeling**: kits `K-01…`, batteries `B-01…`, sensors `S-01…`. QR codes link to parts lists.
- **Check‑in/out**: one clipboard per kit; 60‑second end‑of‑session inventory.
- **Maintenance**: weekly charge/cycle batteries; inspect cables; update firmware; log missing parts.
- **Contingencies**: offline tasks when internet fails; “no‑robot day” options using simulators or paper‑prototyping.


### 10) Project Index (Starter Set)

Mindstorms (Robotics):
- Line Follower v1: follow high‑contrast line with proportional correction. Concepts: reflectance sensing, thresholds, loops.
- Obstacle Avoider: ultrasonic sensing with safe stop/turn. Concepts: distance sensing, branching, state.
- Color Sorter: detect color and actuate a simple sort. Concepts: sensing, timing, actuation.
- Maze Solver (Left‑hand Rule): deterministic navigation. Concepts: algorithms, state machines.
- Choreo‑Bot: synchronized moves to a beat. Concepts: sequencing, timing, creativity.

Arduino (Physical Computing):
- Blink Patterns & Morse: timing without delay. Concepts: non‑blocking loops, patterns.
- Button Traffic Light: debouncing and finite state machines. Concepts: inputs, FSM.
- Light Theremin: photoresistor + buzzer mapping. Concepts: analogRead, mapping functions.
- Smart Night Light: PIR + LED with sensitivity tuning. Concepts: sensors, thresholds.
- Servo Grabber: sweep + button control. Concepts: PWM, servo control.

Coding (Games/Sim & Tools):
- Reaction Timer: measure latency, visualize results. Concepts: state, randomness, timing.
- Pong Lite: collision and scoring. Concepts: vectors, loops, functions.
- Turtle Art Generator (Python): parameters and loops create patterns. Concepts: decomposition, iteration.

Each index item should be authored using the Tutorial Template above. Keep steps small; add images for every structural change or wiring view.


### 11) Ready‑to‑Use Rubric (copy/paste per project)

| Dimension | Emerging | Developing | Proficient | Advanced |
|---|---|---|---|---|
| Build Completeness | Partly assembled; needs help to run | Runs with guidance; some features incomplete | Runs independently; all core features | Adds features; optimizes performance |
| Code Quality | Disorganized; unclear naming | Basic structure; some duplication | Modular; clear naming/comments | Abstractions; reusable patterns |
| Debugging & Testing | Rare testing; guesses fixes | Tests with hints; basic logs | Systematic tests; targeted logs | Designs tests; profiles performance |
| Collaboration & SEL | Struggles with roles; frequent conflict | Follows roles with reminders | Shares roles; constructive feedback | Leads peers; models de‑escalation |
| Reflection | Minimal or off‑topic | Identifies one challenge and fix | Explains process and next steps | Insightful patterns and strategies |


### 12) Image & Asset Conventions

- Store images at `images/<project-slug>/step-XX.png` (two‑digit step numbers).
- Diagrams/source at `images/<project-slug>/step-XX.drawio` (or `.pptx/.key`), exported to `.png` for tutorials.
- Keep file names descriptive and consistent with step numbers used in the tutorial.


### 13) Risk & Emergency Playbooks

- **Hardware injury**: stop work, first aid, notify staff, incident log.
- **Emotional escalation**: remove audience, offer choices, co‑regulate, log trigger/repair plan, follow‑up.
- **Equipment damage**: power down, isolate device, photo/log, calm debrief focused on repair and learning.


### 14) Family Communication & Showcases

- Monthly update: wins, upcoming demos, how families can support.
- Demo days: short rehearsed explanations per team; photo consent respected; QR codes to portfolios.


### 15) Appendices (templates to copy)

#### A) Team Contract (one page)
- Our goals…
- Roles we will rotate…
- How we handle disagreement…
- How we ask for help…
- Our reset plan…

#### B) LLM Prompt Cards (student‑friendly)
- Plan: “Help me break this project into 5–8 steps. Ask 3 clarifying questions first.”
- Debug: “Here’s my minimal example, the error, what I expected. What’s the next safe test?”
- Explain: “Explain this code for a 7th grader with two examples.”
- Verify: “Propose tests to confirm this behavior on Arduino Uno using only the built‑in LED and Serial Monitor.”

#### C) Tutorial Authoring Checklist
- Have I filled the template sections?
- Are steps atomic (1 action → 1 micro‑goal)?
- Are there images for setup and each major step?
- Do checkpoints have measurable expectations?
- Is troubleshooting symptom‑driven?
- Is the rubric aligned to learning goals?
- Did I add at least one extension/choice?

#### D) Inventory Sheet (per kit)
- Kit ID, contents, missing/needs, battery level, notes.


### 16) Roadmap (next authoring targets)

Create these first, end‑to‑end with images and teacher notes:
1) Arduino: Blink Patterns & Morse (non‑blocking timing)
2) Mindstorms: Line Follower v1 (reflectance + proportional correction)
3) Coding: Reaction Timer (timing and state)

Then expand to Obstacle Avoider, Button Traffic Light, Turtle Art Generator, and Servo Grabber.


### 17) How to Use This Guide Weekly

- Pick 1–2 tutorials from the index; clone the template; add images.
- Run once as a teacher rehearsal; note time, snags, and likely misconceptions.
- During class: use checkpoints for quick formative assessment; record issues in the kit log.
- After class: file images, commit changes, and schedule the next tutorial.


— End of Guide —


