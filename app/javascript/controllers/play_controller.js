import { Controller } from "@hotwired/stimulus"
import { RadarController } from "chart.js";

// Connects to data-controller="play"
export default class extends Controller {
  static targets = ["icon", "pause", "timer", "switchstart", "switchpause"]


  connect() {
    console.log("hello");
  }

  toggle() {
    this.iconTarget.classList.toggle("d-none")
    this.pauseTarget.classList.toggle("d-none")
    this.switchstartTarget.classList.toggle("d-none")
    this.switchpauseTarget.classList.toggle("d-none")
  }

  start(event) {
    // console.log(event.target.getAttribute("class"));
    if (event.target.getAttribute("class") === "play-button") {

      if (!this.interval) {
        this.temps = 0

        this.interval = setInterval(() => {
          let minutes = parseInt(this.temps / 60, 10)
          let secondes = parseInt(this.temps % 60, 10)

          minutes = minutes < 10 ? "0" + minutes : minutes
          secondes = secondes < 10 ? "0" + secondes : secondes

          this.timerTarget.innerText = `${minutes}:${secondes}`
          this.temps = this.temps + 1
        }, 1000)
      }
      else {
        this.interval = setInterval(() => {
          let minutes = parseInt(this.temps / 60, 10)
          let secondes = parseInt(this.temps % 60, 10)

          minutes = minutes < 10 ? "0" + minutes : minutes
          secondes = secondes < 10 ? "0" + secondes : secondes

          this.timerTarget.innerText = `${minutes}:${secondes}`
          this.temps = this.temps + 1
        }, 1000)
      }
    }
    else {
      clearInterval(this.interval)
    }
  }
