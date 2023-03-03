import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["input", "city", "date", "temperature", "icon"]

  initialize() {
  }

  connect() {
    this.apiKey = "cbfd159cccd8cb52badfad88cc8b1aca"
    fetch(`https://api.openweathermap.org/data/2.5/forecast?q=Nantes&appid=${this.apiKey}&units=metric`)
    .then(response => response.json())
    .then(data => this.#updateCard(data))
  }

  // connect() {
  //   this.apiKey = "cbfd159cccd8cb52badfad88cc8b1aca";
  //   navigator.geolocation.getCurrentPosition(position => {
  //     const { latitude, longitude } = position.coords;
  //     const apiUrl = `https://api.openweathermap.org/data/2.5/forecast?lat=${latitude}&lon=${longitude}&appid=${this.apiKey}&units=metric`;
  //     fetch(apiUrl)
  //       .then(response => response.json())
  //       .then(data => this.#updateCard(data))
  //       .catch(error => console.log(error));
  //   }, error => {
  //     console.log(error);
  //     // Si l'utilisateur refuse la géolocalisation, récupérez les données de prévision météorologique de Nantes
  //     const apiUrl = `https://api.openweathermap.org/data/2.5/forecast?q=Nantes&appid=${this.apiKey}&units=metric`;
  //     fetch(apiUrl)
  //       .then(response => response.json())
  //       .then(data => this.#updateCard(data))
  //       .catch(error => console.log(error));
  //   });
  // }




  fetchWeather(event) {
    event.preventDefault() //eviter de devoir recharger la page
    const city = this.inputTarget.value
    fetch(`https://api.openweathermap.org/data/2.5/forecast?q=${city}&appid=${this.apiKey}&units=metric`)
      .then(response => response.json())
      .then(data => this.#updateCard(data))
  }

  #updateCard(data) {
    this.cityTargets.forEach((target, index) => {
      this.iconTargets[index].src = `https://openweathermap.org/img/w/${data["list"][index].weather[0].icon}.png`
      this.temperatureTargets[index].innerText = `${Math.round(data["list"][index].main.temp)} °C`
      // this.descriptionTarget.innerText = data.weather[0].description
      this.cityTargets[index].innerText = `${data.city.name}`
      // cette ligne va chercher le nom de la ville demandé dans la requete (json)
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
// A FAIRE : nom de la ville = arrondissement
// Ajouter les heures sous la date
// permettre la geolocalisation par défaut
// CSS
