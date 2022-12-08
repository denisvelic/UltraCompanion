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
    fetch(`https://api.openweathermap.org/data/2.5/weather?q=${city}&appid=${this.apiKey}&units=metric`)
      .then(response => response.json())
      .then(data => this.#updateCard(data))
  }

  fetchWeatherByCoordinates() {
    navigator.geolocation.getCurrentPosition((data) => {
      fetch(`http://api.openweathermap.org/data/2.5/weather?lat=${data.coords.latitude}&lon=${data.coords.longitude}&appid=${this.apiKey}&units=metric`)
        .then(response => response.json())
        .then(data => this.#updateCard(data))
    })
  }

  #updateCard(data) {
    this.iconTarget.src = `https://openweathermap.org/img/w/${data.weather[0].icon}.png`
    this.temperatureTarget.innerText = `${Math.round(data.main.temp)} °C`
    // this.descriptionTarget.innerText = data.weather[0].description
    this.cityTarget.innerText = data.name
    const today = new Date();
    const localOffset = data.timezone + today.getTimezoneOffset() * 60
    const localDate = new Date(today.setUTCSeconds(localOffset))
    const options = { day: 'numeric', weekday: 'long', month: 'long', hour: 'numeric', minute: 'numeric' }
    const formattedDate = localDate.toLocaleDateString("fr")
    this.dateTarget.innerText = formattedDate
  }
}
