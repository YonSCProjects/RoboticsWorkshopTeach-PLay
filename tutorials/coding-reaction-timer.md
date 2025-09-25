## Coding: Reaction Timer (Timing and State)

Build a simple reaction timer game in the browser. Players wait for a visual cue, then click fast. We’ll practice state machines, timing, randomness, and basic UI/UX. Includes optional localStorage to track best times.

### Why this matters

Reaction timers are a compact way to learn event‑driven programming: you’ll manage states, handle user input, and measure precise time intervals—skills used in games, robotics dashboards, and data collection tools.

### Learning goals

- Implement a simple state machine (waiting → ready → clicked/too soon)
- Use randomness and time measurement (`performance.now()`)
- Give user feedback and persist best scores with `localStorage`
- Design quick tests and handle edge cases (false starts)

### Prerequisites

- A computer with a modern web browser (Chrome/Edge/Firefox)
- Basic familiarity with HTML/CSS/JavaScript (copy‑paste friendly for beginners)

### Materials

- Computer + browser; optional: text editor (VS Code)

Time: 30–45 min  •  Difficulty: 1/5  •  Team size: 1–2

### Safety notes

- None (software only). If using shared computers, avoid storing personally identifying information.

### Setup

1) Create a new folder `reaction-timer` on your computer.
2) Inside, create a file named `index.html`.
3) Open it in your editor and paste the code below. See layout reference `images/coding-reaction-timer/setup-01.png`.

### Build Steps

#### Step 1 — Minimal HTML/CSS layout

Paste into `index.html`:

```html
<!doctype html>
<html lang="en">
  <head>
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <title>Reaction Timer</title>
    <style>
      :root {
        --bg: #0f172a; --panel: #111827; --ok: #10b981; --warn: #f59e0b; --bad: #ef4444; --text: #e5e7eb; --muted: #9ca3af;
      }
      html, body { height: 100%; margin: 0; background: var(--bg); color: var(--text); font-family: system-ui, -apple-system, Segoe UI, Roboto, Cantarell, 'Helvetica Neue', Arial, 'Noto Sans', 'Apple Color Emoji', 'Segoe UI Emoji', 'Segoe UI Symbol'; }
      .wrap { min-height: 100%; display: grid; place-items: center; padding: 24px; }
      .card { width: min(560px, 92vw); background: var(--panel); border-radius: 16px; padding: 24px; box-shadow: 0 10px 30px rgba(0,0,0,0.3); }
      h1 { margin: 0 0 12px; font-size: 24px; }
      p { margin: 8px 0; color: var(--muted); }
      .screen { height: 220px; border-radius: 12px; display: grid; place-items: center; margin: 16px 0; font-size: 22px; font-weight: 600; letter-spacing: 0.5px; transition: background 160ms ease; }
      .waiting { background: #374151; }
      .ready { background: var(--ok); color: #073b2f; }
      .toosoon { background: var(--bad); }
      .clicked { background: #1f2937; }
      .btns { display: flex; gap: 12px; flex-wrap: wrap; }
      button { background: #374151; color: var(--text); border: 0; padding: 12px 16px; border-radius: 10px; cursor: pointer; font-weight: 600; }
      button.primary { background: #2563eb; }
      button:disabled { opacity: 0.6; cursor: not-allowed; }
      .stats { display: flex; gap: 16px; flex-wrap: wrap; margin-top: 8px; color: var(--muted); }
      .stat { background: #0b1220; padding: 8px 12px; border-radius: 8px; }
    </style>
  </head>
  <body>
    <div class="wrap">
      <div class="card">
        <h1>Reaction Timer</h1>
        <p>Click start, wait for green, then click as fast as you can.</p>
        <div id="screen" class="screen waiting">Click Start</div>
        <div class="btns">
          <button id="startBtn" class="primary">Start</button>
          <button id="clickBtn" disabled>Click!</button>
          <button id="resetBtn">Reset</button>
        </div>
        <div class="stats">
          <div class="stat">Last: <span id="last">–</span> ms</div>
          <div class="stat">Best: <span id="best">–</span> ms</div>
          <div class="stat">Attempts: <span id="attempts">0</span></div>
        </div>
      </div>
    </div>

    <script>
      const screen = document.getElementById('screen');
      const startBtn = document.getElementById('startBtn');
      const clickBtn = document.getElementById('clickBtn');
      const resetBtn = document.getElementById('resetBtn');
      const lastEl = document.getElementById('last');
      const bestEl = document.getElementById('best');
      const attemptsEl = document.getElementById('attempts');

      // State: 'idle' | 'waiting' | 'ready' | 'clicked' | 'toosoon'
      let state = 'idle';
      let tStart = 0; // when green appears
      let timerId = null;
      let attempts = 0;
      let best = Number(localStorage.getItem('reaction_best') || '0');
      if (best > 0) bestEl.textContent = best;

      function setScreen(cls, text) {
        screen.className = `screen ${cls}`;
        screen.textContent = text;
      }

      function randomDelay(min, max) {
        return Math.floor(Math.random() * (max - min + 1)) + min; // ms
      }

      function startTrial() {
        clearTimeout(timerId);
        state = 'waiting';
        setScreen('waiting', 'Wait for green…');
        clickBtn.disabled = false;
        startBtn.disabled = true;
        const delay = randomDelay(1200, 3200);
        timerId = setTimeout(() => {
          state = 'ready';
          tStart = performance.now();
          setScreen('ready', 'GO! Click!');
        }, delay);
      }

      function handleClick() {
        if (state === 'waiting') {
          // too soon
          clearTimeout(timerId);
          state = 'toosoon';
          setScreen('toosoon', 'Too soon! Click Start to try again.');
          startBtn.disabled = false;
          clickBtn.disabled = true;
          return;
        }
        if (state === 'ready') {
          const t = Math.round(performance.now() - tStart);
          state = 'clicked';
          setScreen('clicked', `Your time: ${t} ms`);
          attempts += 1;
          attemptsEl.textContent = attempts;
          lastEl.textContent = t;
          if (best === 0 || t < best) {
            best = t; bestEl.textContent = best; localStorage.setItem('reaction_best', String(best));
          }
          startBtn.disabled = false;
          clickBtn.disabled = true;
        }
      }

      function resetAll() {
        clearTimeout(timerId);
        state = 'idle';
        tStart = 0; attempts = 0;
        attemptsEl.textContent = '0';
        lastEl.textContent = '–';
        setScreen('waiting', 'Click Start');
        startBtn.disabled = false;
        clickBtn.disabled = true;
      }

      startBtn.addEventListener('click', startTrial);
      clickBtn.addEventListener('click', handleClick);
      // Allow clicking the screen as the click button
      screen.addEventListener('click', () => { if (!clickBtn.disabled) handleClick(); });
      resetBtn.addEventListener('click', resetAll);
    </script>
  </body>
  </html>
```

Checkpoint CP‑1: Open `index.html` in a browser. Click Start; after 1.2–3.2 s the panel turns green. Click to see your time. If nothing happens, open DevTools Console (F12) for errors.

#### Step 2 — Edge cases and UX polish

- False start: clicking before green should show “Too soon!” and disable Click until Start is pressed again (already implemented).
- Accessibility: allow clicking the big screen area to act like the Click button (already implemented).
- Visual cues: change panel color for each state; ensure text is readable.

Checkpoint CP‑2: Try clicking too early and confirm the protection works. Try 5 attempts and see attempts count and best time update.

#### Step 3 — Optional: keyboard support and average score

Add keyboard shortcuts and compute an average of the last N attempts.

```html
<script>
  // ... existing code ...
  let lastTimes = [];
  function updateAverage() {
    const n = Math.min(lastTimes.length, 10);
    const slice = lastTimes.slice(-n);
    const avg = Math.round(slice.reduce((a,b)=>a+b,0)/n);
    let el = document.getElementById('avg');
    if (!el) {
      const s = document.createElement('div');
      s.className = 'stat';
      s.innerHTML = 'Avg(10): <span id="avg">–</span> ms';
      document.querySelector('.stats').appendChild(s);
      el = document.getElementById('avg');
    }
    el.textContent = isFinite(avg) ? avg : '–';
  }

  function handleClickWithAverage() {
    if (state === 'ready') {
      const t = Math.round(performance.now() - tStart);
      lastTimes.push(t);
      updateAverage();
    }
    handleClick();
  }

  document.addEventListener('keydown', (e) => {
    if (e.code === 'Space') {
      if (state === 'idle' || state === 'toosoon' || state === 'clicked') startTrial();
      else handleClickWithAverage();
    }
  });
  // swap the click handler
  clickBtn.removeEventListener('click', handleClick);
  clickBtn.addEventListener('click', handleClickWithAverage);
</script>
```

Checkpoint CP‑3: Press Space to start and to click. Confirm Avg(10) appears and updates after attempts.

### Troubleshooting

- Panel never turns green: check that JavaScript loaded (Console errors?). Ensure you opened the HTML file, not a folder. Try a different browser.
- Best time never updates: localStorage might be blocked in very strict privacy modes; still works without it.
- Double clicks: ensure Click becomes disabled after a trial completes (already handled).

### Assessment

- Evidence: short screen recording, code snapshot with comments on state handling, and a table of 10 attempts with min/avg.
- Rubric alignment: correct state transitions; accurate timing; clean UI; reflection covers UX and edge cases.

### Extensions & Choice

- Add a 3‑2‑1 countdown before the random delay.
- Add a two‑player mode: alternate turns and keep separate best scores.
- Add a chart of recent times using a tiny chart library or `<canvas>`.
- Make a “trainer mode” that increases difficulty by shrinking the green window.

### Reflection

- What states did you identify? How did you prevent invalid transitions?
- How would you port this to Arduino Serial Monitor or a phone touch interface?
- If a user mis‑clicks, how do you keep the UI forgiving?

— End of Tutorial —


