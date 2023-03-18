import { Controller } from "@hotwired/stimulus";
import gtag from "../src/analytics";

export default class extends Controller {
  static values = {
    name: String,
    options: Object
  }

  track(e) {
    gtag('event', this.nameValue, this.optionsValue);
  }

}