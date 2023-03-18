import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static values = {
    name: String,
    options: Object
  }

  track(e) {
    gtag('event', this.nameValue, this.optionsValue);
    console.log('dataLayer:::', dataLayer);
  }

}