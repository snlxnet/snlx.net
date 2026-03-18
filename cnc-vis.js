let machineX = 400
let machineY = 200
let zeroX = machineX * 0.618
let zeroY = 0

let gcode = []
let plane = "xy"
let lastX = 50
let lastY = 50

function getAxis() {
  return [plane[0], plane[1]]
}

// to support relative movement in the future
function pushSVG(cmd, className = "cutpath") {
  const prevPos = `M ${lastX} ${machineY - lastY}\n`
  const element = document.createElementNS("http://www.w3.org/2000/svg", "path")
  element.setAttribute("d", prevPos + cmd.toUpperCase())
  element.classList.add("toolpath")
  element.classList.add(className)
  element.style.transform = `translate(${zeroX}px, ${-zeroY}px)`
  svg.appendChild(element)
}

function go(x, y) {
  gcode.push(`G01 X${x} Y${y}`)
  pushSVG(`L ${x} ${machineY - y}`)
  lastX = x
  lastY = y
}

function jump(x, y) {
  gcode.push(`G00 X${x} Y${y}`)
  pushSVG(`L ${x} ${machineY - y}`, "movepath")
  lastX = x
  lastY = y
}

function arc(cmd, radius, x, y) {
  let [ax0, ax1] = getAxis()
   
  gcode.push(`${cmd} ${ax0}${x} ${ax1}${y} R${radius}`.toUpperCase())
  
  const sweep = cmd === "G02" ? 0 : 1
  pushSVG(`A ${radius} ${radius} 0 0 ${1 - sweep} ${x} ${machineY - y}`)
  lastX = x
  lastY = y
}

function cw(radius, x, y) {
  arc("G02", radius, x, y)
}

function ccw(radius, x, y) {
  arc("G03", radius, x, y)
}

function park() {
  jump(50, 50)
}

// ---- ---- ---- ---- //

function exec() {
  const oldElements = Array.from(document.querySelectorAll(".toolpath"))
  lastX = 50
  lastY = 50
  gcode = []
  eval(input.value)
  oldElements.forEach(elem => elem.remove())
  display.textContent = gcode.map((frame, idx) => `N${idx+1} ${frame} LF`).join("\n")

  svg.setAttribute("viewBox", `-10 -10 ${machineX+20} ${machineY+20}`)
  desk.setAttribute("width", machineX)
  desk.setAttribute("height", machineY)

  zerocircle.setAttribute("cy", `${machineY - zeroY}`)
  zerocircle.setAttribute("cx", `${zeroX}`)
  zeropath.setAttribute("d", `
  M ${zeroX} ${machineY - zeroY}
  l -5 0
  a 5 5 0 0 0 5 5
  z
  `)
}

exec()
input.addEventListener("input", exec)
