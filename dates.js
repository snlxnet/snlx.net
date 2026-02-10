export function renderDates() {
  document.querySelectorAll(".date").forEach((element) => {
    element.textContent = calculateRelativeDate(element.dataset.date)
  })
}

function calculateRelativeDate(dateStr) {
  if (dateStr === "Invalid Date") {
    return "..."
  }
  const dateObj = new Date(dateStr)
  const now = new Date()
  const diffDays = Math.floor((now - dateObj) / 1000 / 60 / 60 / 24)
  if (diffDays > 365) {
    return (diffDays/365).toFixed(1) + " yrs"
  }
  if (diffDays > 99) {
    return (diffDays/30.5).toFixed(1) + " mo"
  }
  return diffDays + "d"
}

