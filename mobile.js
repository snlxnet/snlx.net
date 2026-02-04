createMobileButton()

function createMobileButton() {
  const ICON_SHOW_MENU = `<svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" class="lucide lucide-menu-icon lucide-menu"><path d="M4 5h16"/><path d="M4 12h16"/><path d="M4 19h16"/></svg>`
  const ICON_HIDE_MENU = `<svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" class="lucide lucide-circle-arrow-out-up-left-icon lucide-circle-arrow-out-up-left"><path d="M2 8V2h6"/><path d="m2 2 10 10"/><path d="M12 2A10 10 0 1 1 2 12"/></svg>`
  const UI_NAV = document.querySelector("nav")

  const mobileButton = document.createElement("button")
  mobileButton.innerHTML = ICON_SHOW_MENU
  mobileButton.classList.add("mobile-button")
  mobileButton.addEventListener("click", () => {
    if (nav.classList.contains("show")) {
      UI_NAV.classList.remove("show")
      mobileButton.innerHTML = ICON_SHOW_MENU
    } else {
      UI_NAV.classList.add("show")
      mobileButton.innerHTML = ICON_HIDE_MENU
    }
  })
  document.body.appendChild(mobileButton)
}

