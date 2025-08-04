import { apiInitializer } from "discourse/lib/api";

export default apiInitializer("0.11.1", (api) => {
  api.onPageChange(() => {
    const banner = document.querySelector(".welcome-banner__wrap");
    // Log the banner element to help verify it exists on the current page
    // and avoid silently failing when the container is missing.
    /* eslint-disable no-console */
    console.debug("FortuneGPT banner element:", banner);
    /* eslint-enable no-console */
    if (!banner || banner.querySelector(".fortune-gpt-container")) {
      return;
    }

    const mountPoint = document.createElement("div");
    mountPoint.className = "fortune-gpt-container";
    banner.appendChild(mountPoint);
    api.mountComponent("fortune-display", mountPoint);
  });
});
