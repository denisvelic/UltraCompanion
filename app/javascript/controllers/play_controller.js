import { Controller } from "@hotwired/stimulus"
import { RadarController } from "chart.js";

// Connects to data-controller="play"
export default class extends Controller {
  static targets = ["icon", "pause", "timer", "switch"]


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

  start() {
    let temps = 0

    let Interval = setInterval(() => {
      let minutes = parseInt(temps / 60, 10)
      let secondes = parseInt(temps % 60, 10)

      minutes = minutes < 10 ? "0" + minutes : minutes
      secondes = secondes < 10 ? "0" + secondes : secondes

      this.timerTarget.innerText = `${minutes}:${secondes}`
      temps = temps + 1
    }, 1000)

    // let temps = 0
    // let MyInterval = -1

    // this.switchTarget.addEventListener("click", function(event) {
    //   if (MyInterval = -1) {
    //     MyInterval = setInterval(() => {
    //       let minutes = parseInt(temps / 60, 10)
    //       let secondes = parseInt(temps % 60, 10)

    //       minutes = minutes < 10 ? "0" + minutes : minutes
    //       secondes = secondes < 10 ? "0" + secondes : secondes

    //       this.timerTarget.innerText = `${minutes}:${secondes}`
    //       temps = temps + 1
    //     }, 1000)
    //   }
    //   else {
    //     clearInterval(MyInterval);
    //     MyInterval = -1;
    //   }
    // });
  }
}
