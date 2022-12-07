import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="play"
export default class extends Controller {
  static targets = ["icon"]

  connect() {
    // console.log("hello");
  }

  toggle() {
  }
}
