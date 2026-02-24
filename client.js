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
    frame.onload = resize
    frame.contentWindow.addEventListener("click", resizeTwice)
    frame.contentWindow.addEventListener("keydown", resizeTwice)
    frame.onload()

    addEventListener("resize", () => {
      frame.style.height = frame.clientWidth / 21 * 9 + "px"
      resize()
    })

    function resizeTwice() {
      resize()
      setTimeout(resize, 100)
    }
    
    function resize() {
      frame.style.height = frame.contentWindow.document.body.scrollHeight + "px"
    }
  })
}

