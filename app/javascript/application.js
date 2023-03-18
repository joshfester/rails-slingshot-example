// Entry point for the build script in your package.json
import "@hotwired/turbo-rails"

import 'bootstrap/js/dist/alert';
import 'bootstrap/js/dist/dropdown';
import "./controllers"
import gtag from "./src/analytics";

document.addEventListener("turbo:load", (e) => {
  gtag('config', window.railsApp.googleTagId, {
    page_location: e.detail.url,
    page_path: e.srcElement.parentNode.location.pathname,
    page_title: e.srcElement.parentNode.title
  });
});