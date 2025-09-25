## Arduino: Blink Patterns & Morse (Non‑Blocking Timing)

— Use this tutorial to practice timing without delay, then compose patterns like a heartbeat and Morse “SOS.” Follow atomic steps, check checkpoints, and use the Troubleshooting section if anything diverges.

### Why this matters

Non‑blocking timing with `millis()` lets your robot do more than one thing at a time: read sensors while blinking LEDs, drive motors while signaling status, or play patterns without freezing.

### Learning goals

- Understand and implement non‑blocking timing using `millis()`
- Build a reusable pattern player for on/off sequences
- Encode Morse “SOS” using timing units
- Practice systematic debugging with the Serial Monitor

### Prerequisites

- Arduino IDE installed (2.x recommended) and can upload a basic sketch
- Knows how to open Serial Monitor and select the board/port

### Materials

- Arduino Uno/Nano or compatible (Built‑in LED on pin 13)
- USB cable
- Optional: external LED + 220 Ω resistor, breadboard, jumpers

Time: 45–60 min  •  Difficulty: 2/5  •  Team size: 1–2

### Safety notes

- Disconnect power before rewiring. LEDs have polarity; use a current‑limiting resistor for external LEDs.

### Setup

1) If using only the built‑in LED, no wiring is required. If using an external LED, wire as in the diagram `images/arduino-blink-morse/setup-01.png` (LED anode → resistor → pin 13; LED cathode → GND).
2) Open Arduino IDE, select your board and port. Create a new sketch named `BlinkPatterns`.

### Build Steps

#### Step 1 — Baseline (blocking) blink for comparison

Upload this to verify your setup (then replace in the next step):

```cpp
void setup() {
  pinMode(LED_BUILTIN, OUTPUT);
}

void loop() {
  digitalWrite(LED_BUILTIN, HIGH);
  delay(500);
  digitalWrite(LED_BUILTIN, LOW);
  delay(500);
}
```

Checkpoint CP‑1: LED blinks on/off at ~0.5 s intervals. If not, check board/port, try another USB cable/port.

#### Step 2 — Non‑blocking blink with millis()

Replace your code with:

```cpp
const uint8_t LED_PIN = LED_BUILTIN; // or 13 if using external LED
bool ledOn = false;
unsigned long lastToggleMs = 0;
const unsigned long intervalMs = 500;

void setup() {
  pinMode(LED_PIN, OUTPUT);
}

void loop() {
  unsigned long now = millis();
  if (now - lastToggleMs >= intervalMs) {
    ledOn = !ledOn;
    digitalWrite(LED_PIN, ledOn ? HIGH : LOW);
    lastToggleMs = now;
  }
}
```

Checkpoint CP‑2: LED still blinks ~0.5 s but the loop does not pause. Add `Serial.println(now);` temporarily to see continuous printing while blinking.

#### Step 3 — Pattern player (sequence of on/off segments)

We’ll define a small data structure representing segments where each segment has a duration and whether the LED is on or off.

```cpp
struct Segment {
  unsigned long durationMs;
  bool level; // true = HIGH, false = LOW
};

const uint8_t LED_PIN = LED_BUILTIN;

// Example heartbeat: short‑short‑long pause
const Segment HEARTBEAT[] = {
  {100, true}, {100, false},
  {100, true}, {700, false}
};
const size_t HEARTBEAT_LEN = sizeof(HEARTBEAT) / sizeof(HEARTBEAT[0]);

size_t segIndex = 0;
unsigned long segStartMs = 0;

void setup() {
  pinMode(LED_PIN, OUTPUT);
  segStartMs = millis();
  digitalWrite(LED_PIN, HEARTBEAT[0].level ? HIGH : LOW);
}

void loop() {
  const Segment* pattern = HEARTBEAT;
  const size_t patternLen = HEARTBEAT_LEN;

  unsigned long now = millis();
  const Segment& seg = pattern[segIndex];
  if (now - segStartMs >= seg.durationMs) {
    segIndex = (segIndex + 1) % patternLen;
    digitalWrite(LED_PIN, pattern[segIndex].level ? HIGH : LOW);
    segStartMs = now;
  }
}
```

Checkpoint CP‑3: Observe a two‑pulse heartbeat pattern. If the LED stays on or off, print `segIndex` and `now - segStartMs` to debug.

#### Step 4 — Morse “SOS” using timing units

Morse timing uses a base unit `U`. Dot = 1U on, Dash = 3U on, intra‑character gap = 1U off, inter‑character gap = 3U off, word gap = 7U off. “SOS” is `... --- ...`.

```cpp
struct Segment { unsigned long durationMs; bool level; };
const uint8_t LED_PIN = LED_BUILTIN;

const unsigned long U = 120; // base unit in ms; adjust 80–200 for speed

// ... S (dot dot dot) ...
// ... O (dash dash dash) ...
// Sequence: S (end letter gap), O (end letter gap), S (end word gap)
const Segment SOS[] = {
  // S: dot dot dot
  {1*U, true}, {1*U, false},
  {1*U, true}, {1*U, false},
  {1*U, true}, {3*U, false}, // letter gap
  // O: dash dash dash
  {3*U, true}, {1*U, false},
  {3*U, true}, {1*U, false},
  {3*U, true}, {3*U, false}, // letter gap
  // S: dot dot dot
  {1*U, true}, {1*U, false},
  {1*U, true}, {1*U, false},
  {1*U, true}, {7*U, false}  // word gap
};
const size_t SOS_LEN = sizeof(SOS) / sizeof(SOS[0]);

size_t segIndex = 0;
unsigned long segStartMs = 0;

void setup() {
  pinMode(LED_PIN, OUTPUT);
  Serial.begin(9600);
  while (!Serial) {}
  segStartMs = millis();
  digitalWrite(LED_PIN, SOS[0].level ? HIGH : LOW);
  Serial.println("Starting SOS pattern");
}

void loop() {
  unsigned long now = millis();
  if (now - segStartMs >= SOS[segIndex].durationMs) {
    segIndex = (segIndex + 1) % SOS_LEN;
    digitalWrite(LED_PIN, SOS[segIndex].level ? HIGH : LOW);
    segStartMs = now;
    Serial.print("Segment: ");
    Serial.print(segIndex);
    Serial.print(" level=");
    Serial.print(SOS[segIndex].level ? "HIGH" : "LOW");
    Serial.print(" durMs=");
    Serial.println(SOS[segIndex].durationMs);
  }
}
```

Checkpoint CP‑4: LED spells SOS with clear rhythm. Adjust `U` for speed. Serial Monitor should print segment transitions.

### Troubleshooting

- LED never turns on: check board/port; if using external LED, reverse polarity or verify resistor; try `LED_BUILTIN`.
- Upload errors: close Serial Monitor; select correct COM port; try a different cable.
- Timing feels off: your computer’s serial prints don’t affect timing, but very slow baud settings can lag prints; try `115200`.
- LED flickers unpredictably: avoid using `delay()` alongside `millis()` patterns unless you isolate them.

### Assessment (copy for portfolio)

- Evidence: working video, annotated code (which parts you wrote vs. starter), and a timing diagram (hand‑drawn or digital).
- Rubric alignment: non‑blocking timing implemented; pattern plays correctly; code is readable and modular; reflection answers are specific.

### Extensions & Choice

- Add a second pattern and a pushbutton to switch patterns.
- Encode your initials in Morse and loop through it.
- Add a status LED that blinks a heartbeat while the main loop does another task (e.g., reading a sensor).

### Reflection (prompt)

- Where did blocking timing limit you? How did `millis()` change your approach?
- What debugging step (print, checkpoint, wiring check) helped the most?
- If a younger student asked how this works, how would you explain it with a sketch?

— End of Tutorial —


