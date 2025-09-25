## Mindstorms: Line Follower v1 (Reflectance + Proportional Correction)

Follow a high‑contrast black line on a light surface using a Color/Light sensor. Start with a threshold (bang‑bang) controller, then upgrade to proportional steering for smoother motion.

### Why this matters

Line following is a classic foundation for autonomous navigation. You’ll learn sensing, thresholds, control loops, and incremental tuning—skills that transfer to obstacle avoidance and maze solving.

### Learning goals

- Calibrate a reflectance sensor and derive a threshold
- Implement bang‑bang control to follow a line
- Implement proportional correction for smooth tracking
- Practice systematic testing and tuning (Kp, speed)

### Prerequisites

- Basic familiarity with your kit’s programming environment (SPIKE Prime/Robot Inventor Python, or EV3 MicroPython/blocks)
- Can run a simple program and read sensor values

### Materials

- LEGO Mindstorms SPIKE Prime or Robot Inventor kit (or EV3 with Color Sensor)
- 1× Color/Light sensor mounted close to the floor (≈1–3 mm)
- High‑contrast line mat (black tape on white poster board works)

Time: 45–60 min  •  Difficulty: 2/5  •  Team size: 2–3

### Safety notes

- Keep fingers, hair, and clothing away from wheels/gears while running.
- Clear the test area to avoid collisions.

### Setup

1) Mount the Color/Light sensor at the front, angled straight down, 1–3 mm above the surface. See `images/mindstorms-line-follower-v1/setup-01.png`.
2) Ensure cables are firmly seated. Charge the hub and use fresh batteries if applicable.
3) Place the robot on the line so the sensor can see both black and white by moving slightly.

### Build Steps

#### Step 1 — Read and calibrate reflectance

We’ll read the reflectance on white and on black, then compute a threshold T = (white + black) / 2. This example uses SPIKE Prime/Robot Inventor Python.

```python
from spike import PrimeHub, ColorSensor
from spike.control import wait_for_seconds

hub = PrimeHub()
sensor = ColorSensor('F')  # adjust port to match your build (A–F)

print('Place sensor over WHITE area')
wait_for_seconds(2)
white = sensor.get_reflected_light()
print('White =', white)

print('Place sensor over BLACK line')
wait_for_seconds(2)
black = sensor.get_reflected_light()
print('Black =', black)

T = (white + black) / 2
print('Threshold T =', T)
```

Checkpoint CP‑1: Readings make sense (white > black). If reversed or very close, adjust sensor height/angle and re‑measure.

EV3 MicroPython (alternative): read `cs.reflected_light_intensity` using the EV3 color sensor, then compute T similarly.

#### Step 2 — Bang‑bang line follower (threshold steering)

Use the threshold to decide which side you’re on and steer accordingly. Start slow. For SPIKE Prime/Robot Inventor:

```python
from spike import PrimeHub, MotorPair, ColorSensor
from spike.control import wait_for_seconds

hub = PrimeHub()
motors = MotorPair('A', 'B')  # drive motors
sensor = ColorSensor('F')     # color sensor

base_speed = 25  # percent
T = 50           # replace with your measured threshold

motors.set_default_speed(base_speed)

while True:
    r = sensor.get_reflected_light()
    if r < T:
        # over dark: steer right (positive turn)
        motors.start(steering=30, speed=base_speed)
    else:
        # over light: steer left (negative turn)
        motors.start(steering=-30, speed=base_speed)
```

Checkpoint CP‑2: Robot follows the edge with noticeable wobble. If it loses the line, reduce speed to 15–20 and increase steering magnitude.

#### Step 3 — Proportional correction (smoother tracking)

Compute an error e = r − T and scale turn = Kp × e. Tune Kp. Start small and increase until tracking is smooth without oscillation.

```python
from spike import PrimeHub, MotorPair, ColorSensor

hub = PrimeHub()
motors = MotorPair('A', 'B')
sensor = ColorSensor('F')

base_speed = 30
T = 50       # replace with calibrated threshold
Kp = 1.2     # start 0.8–1.5; tune as needed

motors.set_default_speed(base_speed)

def clamp(val, lo, hi):
    return max(lo, min(hi, val))

while True:
    r = sensor.get_reflected_light()
    e = r - T
    turn = clamp(int(Kp * e), -100, 100)
    motors.start(steering=turn, speed=base_speed)
```

Checkpoint CP‑3: Robot follows smoothly. If it oscillates, lower Kp or speed. If it drifts off, increase Kp slightly.

#### Step 4 — Quick recovery behavior (optional)

If the sensor reads extreme values for >300 ms (likely off the line), stop and sweep to reacquire.

Idea: if r < black+margin or r > white−margin for long, stop motors, then rotate in place slowly until r crosses near T.

### Troubleshooting

- Readings too close: lower the sensor (but avoid scraping), increase light contrast, use thicker tape line, shield ambient light.
- Robot oscillates wildly: reduce Kp, reduce speed, ensure wheels track straight and sensor is centered.
- Robot fails corners: slow down near turns (lower base speed) or increase steering authority.
- Losing line on intersections: choose edge‑following (left or right) and maintain it consistently.

### Assessment

- Evidence: short video of smooth following around curves; code snapshot; T and Kp values recorded with notes.
- Rubric fit: calibration documented; bang‑bang works; proportional tracking tuned; reflection answers describe tuning decisions.

### Extensions & Choice

- Add a button to toggle between bang‑bang and proportional modes.
- Add a speed boost on straights by detecting low error magnitude.
- Follow the opposite edge by inverting the error or offsetting T.
- Add a second color sensor and implement more robust control (beyond v1).

### Reflection

- How did changing Kp affect stability and responsiveness?
- What sensor mounting change improved your readings the most?
- If you had to explain proportional control to a friend, how would you do it with a diagram?

— End of Tutorial —


