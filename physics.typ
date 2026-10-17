= Magnets

A magnet has a north pole (red) and a south pole (blue). Opposite poles attract, same poles repel each other.

Placing one magnet on top and another magnet on the left is effectively the same as putting a single one in the top-left.

(./magnets.svg)

Electromagnets only work as magnets when there's electricity flowing through them.
If you turn up the current, the magnet becomes stronger. If you connect it backwards,
the poles switch.

= Motors

== DC Motors

DC motors are the simplest.
They have curved magnets on the top and bottom.

In the middle is an electromagnet (dark frame with gray contacts) powered by two (white) brushes.

(./dc.svg)

When you connect power, the top of the electromagnet repels the permanent magnet above
and is attracted to the magnet below, so it turns. When it completes half a turn,
the brushes disconnect. No power = the electromagnet doesn't work.
It keeps spinning (because it is already in motion) until it reconnects with the brushes the opposite way,
making its poles switch. Now the same side repels the bottom magnet and attracts to the top one,
so the motor completes the turn.

Powerful DC motors are large and expesive, but small ones are widely used.
Look up #link("https://duck.com/yellow%20DC%20motor%20!i")["yellow DC motor"],
they come with a reduction drive (the motor itself spins at 9000+ RPM)
and are very common for hobbyist electronics projects.

To control a small one, you need a *DC motor driver* (mx1508, for example),
since the motor draws more power than a microcontroller (MCU, a small computer) can supply
and requires switching polarity (swapping `+` and `-`), which the MCU also can't do.
To find how to connect one, look up "mx1508 pinout" or "mx1508 arduino".

Control is something like:
```python
import board
import pwmio
from adafruit_motor import motor

pwm_a = pwmio.PWMOut(board.D5, frequency=1600)
pwm_b = pwmio.PWMOut(board.D6, frequency=1600)
m1 = motor.DCMotor(pwm_a, pwm_b)

m1.throttle = -0.6 # backward, 60% power
```

More on that later.

== Brushless (synchronous)

Brushless motors are smaller, more powerful, but harder to control.

They have many small magnets along the inside of the rotor (the rotating part)
which act as one big round magnet.

In the middle, there are 6 (sometimes 9, usually 12) electromagnets
that turn on sequentially in 3 groups. They create a rotating magnetic field
and the rotor rotates synchronously with that field (hence the name).
Since the electromagnets are not spinning, they don't need brushes,
wires connect directly (hence the other name).

(./brushless-real.svg)

The real RPM is usually 3000+.

#sidenote[
  An asynchronous motor has 3, 6, 9 or 12 electromagnets arrnaged the same way,
  and a rotor placed between them in the middle. The rotor there is not a magnet,
  but it's made of steel and does interact with them. Since it doesn't have defined poles,
  the rotating magnetic field spins faster than the rotor.
]

To connect one, you use an electronic speed controller (ESC).

Control:
```python
import board
import pwmio
from adafruit_motor import servo

pwm = pwmio.PWMOut(board.D5, frequency=50)
m1 = servo.ContinuousServo(pwm, min_pulse=1000, max_pulse=2000)

esc.throttle = -0.2 # backward, 20% power
```

== Stepper

// don't forget about the current adjust thing

