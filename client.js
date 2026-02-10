import { createMobileButton } from "/mobile.js"
import { renderDates } from "/dates.js"

createMobileButton()
startRenderingDates()

function startRenderingDates() {
  renderDates()
  setTimeout(startRenderingDates, 5000)
}

