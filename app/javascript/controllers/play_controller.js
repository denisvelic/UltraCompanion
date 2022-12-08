import { Controller } from "@hotwired/stimulus"
import { RadarController } from "chart.js";

// Connects to data-controller="play"
export default class extends Controller {
  static targets = ["icon", "pause"]


  connect() {
    console.log("hello");
  }


  toggle() {
    // console.log(this.pauseTarget);
    this.iconTarget.classList.toggle("d-none")
    this.pauseTarget.classList.toggle("d-none")
  }

  toggle() {
    this.iconTarget.classList.toggle("d-none")
    this.pauseTarget.classList.toggle("d-none")
  }
}
