import { createMobileButton } from "/mobile.js"
import { renderDates } from "/dates.js"

createMobileButton()
startRenderingDates()
fixIframes()

function startRenderingDates() {
  renderDates()
  setTimeout(startRenderingDates, 5000)
}

function fixIframes() {
  document.querySelectorAll("iframe").forEach((frame) => {
    frame.onload = resizeMultipleTimes
    frame.contentWindow.addEventListener("click", resize)
    frame.contentWindow.addEventListener("keydown", resize)
    frame.onload()

    addEventListener("resize", () => {
      frame.style.height = frame.clientWidth / 21 * 9 + "px"
      resize()
    })

    function resizeMultipleTimes() {
      resize()
      setTimeout(resize, 50)
      setTimeout(resize, 100)
      setTimeout(resize, 1000)
    }
    
    function resize() {
      frame.style.height = frame.contentWindow.document.body.scrollHeight + "px"
    }
  })
}

