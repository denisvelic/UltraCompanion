import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="play"
export default class extends Controller {
  static targets = ["icon", "pause"]

  connect() {
    // console.log("hello");
  }

  toggle() {
    this.iconTarget.classList.toggle("d-none")
    this.pauseTarget.classList.toggle("d-none")
  }
}
