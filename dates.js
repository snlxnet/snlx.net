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

	const diffHours = (now - dateObj) / 1000 / 60 / 60;
	const diffDays = diffHours / 24;
	if (diffDays > 365) {
		return (diffDays / 365).toFixed(2) + " yrs";
	}
	if (diffDays < 1) {
		return diffHours.toFixed(2) + " hrs";
	}
	return Math.floor(diffDays) + "d";
}

