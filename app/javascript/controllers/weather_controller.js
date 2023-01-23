import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["input", "city", "date", "temperature", "icon"]

  initialize() {
    this.apiKey = "cbfd159cccd8cb52badfad88cc8b1aca"
  }

  connect() {
    this.fetchWeatherByCoordinates()
  }

  fetchWeather(event) {
    event.preventDefault() //eviter de devoir recharger la page
    const city = this.inputTarget.value
    fetch(`https://api.openweathermap.org/data/2.5/forecast?q=${city}&appid=${this.apiKey}&units=metric`)
      .then(response => response.json())
      .then(data => this.#updateCard(data))
  }

  fetchWeatherByCoordinates() {
    navigator.geolocation.getCurrentPosition((data) => {
      fetch(`http://api.openweathermap.org/data/2.5/forecast?lat=${data.coords.latitude}&lon=${data.coords.longitude}&appid=${this.apiKey}&units=metric`)
        .then(response => response.json())
        .then(data => this.#updateCard(data))
    })
  }

  #updateCard(data) {
    this.cityTargets.forEach((target, index) => {
      this.iconTargets[index].src = `https://openweathermap.org/img/w/${data["list"][index].weather[0].icon}.png`
      this.temperatureTargets[index].innerText = `${Math.round(data["list"][index].main.temp)} °C`
      // this.descriptionTarget.innerText = data.weather[0].description
      target.innerText = data["city"]["name"]
      const today = new Date();
      const localOffset = data["list"][index].dt_txt + today.getTimezoneOffset() * 60
      const localDate = new Date(today.setUTCSeconds(localOffset))
      const date = new Date(data["list"][index].dt_txt)
      const options = {  day: 'numeric', month: 'long', hour: 'numeric', minute: 'numeric' }
      const formattedDate = date.toLocaleDateString("fr-fr")
      this.dateTargets[index].innerText = formattedDate
    })
  }
}
