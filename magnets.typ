#import "@preview/catppuccin:1.1.0": catppuccin, flavors, set-code-theme
#import "main.typ": theme
#set document(title: [Magnets | snlx.net articles])
#show: catppuccin.with(flavors.mocha)
#show: theme("/magnets", "card.svg", "dark", 20261015)

#let sidenote(it) = html.div(class: "sidenote", it)

#html.style(```css
svg {
  width: 100%;
  height: unset;
}
```.text)

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

#html.div(id: "dcm")
#html.input(type: "range", id: "voltage", min: -5, max: 5, step: 0.5)
#html.script(```js
dcmot()
async function dcmot() {
  await fetch("dc.svg").then(r => r.text()).then(t => dcm.outerHTML = t)

  dcmagnet.style.transformOrigin = "center"
  dcmagnet.style.transformBox = "border-box"
  dcmagnet.style.rotate = "20deg"
  brushes.style.transformOrigin = "center"
  brushes.style.transformBox = "border-box"
  north.style.transition = "ease-in-out 0.1s"
  south.style.transition = "ease-in-out 0.1s"

  setInterval(() => {
    brushes.style.transform = voltage.value > 0 ? "" : "scaleY(-1)"

    if (voltage.value == 0) {
      dcmplus.style.opacity = 0
      dcmminus.style.opacity = 0
      north.style.opacity = 0
      south.style.opacity = 0
      return
    }
    north.style.opacity = 1
    south.style.opacity = 1

    const angle = (+dcmagnet.style.rotate.slice(0, -3) + +voltage.value)%360
    const abs = Math.abs(angle)
    if ((abs > 340 || abs < 20) || (abs > 160&& abs < 200)) {
      north.style.opacity = 0
      south.style.opacity = 0
    } else {
      dcmplus.style.opacity = 1
      dcmminus.style.opacity = 1
    }
    dcmagnet.style.rotate = angle + "deg"
    dcmagnet.style.transform = (abs > 180) ? "scaleY(-1)" : ""
  }, 10)
}
```.text)

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

#html.div(id: "brl")
#html.input(type: "range", id: "speed", min: 1, max: 120, value: 5)
#html.label[
  Power
  #html.input(id: "pwrbr", type: "checkbox")
]
#html.label[
  Show coils & case
  #html.input(id: "brushlesscase", type: "checkbox")
]
#html.script(```js
let powerBrushless = false
pwrbr.oninput = () => powerBrushless = pwrbr.checked
brushless()
async function brushless() {
  await fetch("brushless.svg").then(r => r.text()).then(t => brl.outerHTML = t)

  arrow.style.transformOrigin = "center"
  rotor.style.transformOrigin = "center"
  rotorlid.style.transformOrigin = "center"
  rotor.style.transformBox = "border-box"
  rotorlid.style.transformBox = "border-box"

  rotorlid.style.opacity = 0
  rotorlid.style.display = "inline"
  rotorlid.style.transition = "opacity ease-in-out 1s"
  coils.style.opacity = 0
  coils.style.display = "inline"
  coils.style.transition = "ease-in-out 0.2s"
  let t = 0
  let globalPause = false

  const u0 = 1

  function frame() {
    if (globalPause) {
      return
    }

    if (!powerBrushless) {
      [
        an1, an2,
        bn1, bn2,
        cn1, cn2,
        as1, as2,
        bs1, bs2,
        cs1, cs2,
      ].forEach(el => el.style.opacity = 0)
      arrow.style.opacity = 0
      return
    }

    const omega = +speed.value * 6.28 / 60

    const va = u0 * Math.sin(omega * t)
    an1.style.opacity = va
    as1.style.opacity = -va
    an2.style.opacity = -va
    as2.style.opacity = va

    const vb = u0 * Math.sin(omega * t + 6.28/3)
    bn1.style.opacity = vb
    bs1.style.opacity = -vb
    bn2.style.opacity = -vb
    bs2.style.opacity = vb

    const vc = u0 * Math.sin(omega * t - 6.28/3)
    cn1.style.opacity = vc
    cs1.style.opacity = -vc
    cn2.style.opacity = -vc
    cs2.style.opacity = vc

    arrow.style.opacity = 1
    arrow.style.rotate = -(omega * t) + "rad"
    rotor.style.rotate = -(omega * t) + "rad"
    rotorlid.style.rotate = -(omega * t) + "rad"
  }

  setInterval(() => {
    t = new Date().getTime() / 1000
    frame()
  }, 10)

  speed.oninput = () => {
    clearTimeout(globalPause || -1)
    document.querySelectorAll("#rpm").forEach(el => el.textContent = speed.value)
    globalPause = setTimeout(() => globalPause = false, 100)
  }
  brushlesscase.oninput = () => {
    setBrushlessLid(brushlesscase.checked)
  }
}
function setBrushlessLid(show) {
  coils.style.opacity = +show
  rotorlid.style.opacity = +show
}
```.text)

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

#html.div(id: "stp")
#html.label[
  Power
  #html.input(id: "pwrst", type: "checkbox")
]
#html.button(id: "mkstp")[step]
#html.label[
  Auto run
  #html.input(id: "autostep", type: "checkbox")
]
#html.label[
  Show case
  #html.input(id: "stpcase", type: "checkbox")
]
#html.label[
  Microstep
  #html.select(id: "microstep")[
    #html.option(value: "1")[Off]
    #html.option(value: "2")[1/2]
    #html.option(value: "4")[1/4]
    #html.option(value: "8")[1/8]
    #html.option(value: "16")[1/16]
  ]
]
#html.script(```js
let stepidx = -1
let powerStepper = false
pwrst.oninput = () => {
  powerStepper = pwrst.checked
  step()
}
stepper()
async function stepper() {
  await fetch("stepper.svg").then(r => r.text()).then(t => stp.outerHTML = t)

  casestp.style.opacity = 0
  casestp.style.transition = "opacity ease-in-out 1s"
  rotorstp.style.transition = "ease-out 0.1s"
  rotorstp.style.transformOrigin = "center"
  rotorstp.style.transformBox = "border-box"
  step()
  mkstp.onclick = step
  stpcase.oninput = () => casestp.style.opacity = +stpcase.checked

  setInterval(() => {
    if (+autostep.checked) {
      step()
    }
  }, 150)
}
function step() {
  if (!powerStepper) {
    [stpa1, stpb2, stpa2, stpb1].forEach(el => el.style.opacity = 0)
    return
  }

  const ms = 1 / +microstep.value
  stepidx += ms
  if (stepidx % ms !== 0) {
    stepidx = Math.ceil(stepidx)
  }

  const q = stepidx%4
  if (q <= 1) {
    stpa1.style.opacity = 1 - q
    stpb2.style.opacity = q
    stpa2.style.opacity = 0
    stpb1.style.opacity = 0
  } else if (q <= 2) {
    stpa1.style.opacity = 0
    stpb2.style.opacity = 2 - q
    stpa2.style.opacity = q - 1
    stpb1.style.opacity = 0
  } else if (q <= 3) {
    stpa1.style.opacity = 0
    stpb2.style.opacity = 0
    stpa2.style.opacity = 3 - q
    stpb1.style.opacity = q - 2
  } else {
    stpa1.style.opacity = q - 3
    stpb2.style.opacity = 0
    stpa2.style.opacity = 0
    stpb1.style.opacity = 4 - q
  }

  rotorstp.style.rotate = -1.8*stepidx + "deg"
}
```.text)

