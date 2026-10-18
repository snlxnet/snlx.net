dcmot()
async function dcmot() {
  await fetch("dc.svg").then(r => r.text()).then(t => dcm.outerHTML = t)

  dcmagnet.style.transformOrigin = "center"
  dcmagnet.style.transformBox = "border-box"
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
    const abs = Math.abs(angle+30)
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

let stepidx = -1
stepper()
async function stepper() {
  await fetch("stepper.svg").then(r => r.text()).then(t => stp.outerHTML = t)

  casestp.style.opacity = 0
  casestp.style.transition = "opacity ease-in-out 1s"
  rotorstp.style.transition = "ease-out 0.1s"
  rotorstp.style.transformOrigin = "center"
  rotorstp.style.transformBox = "border-box"
  mkstp.onclick = step
  stpcase.oninput = () => casestp.style.opacity = +stpcase.checked

  const parts = [stpa1, stpb2, stpa2, stpb1]
  parts.map(el => el.style.opacity = 0)

  setInterval(() => {
    if (+autostep.checked) {
      step()
    }
  }, 150)
}
function step() {
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
