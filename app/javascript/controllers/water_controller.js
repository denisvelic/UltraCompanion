import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="water"
export default class extends Controller {
  static values = {
    apiKey: String,
    points: Array
  }

  connect() {
    // console.log(this.pointsValue);
    mapboxgl.accessToken = this.apiKeyValue

    this.map = new mapboxgl.Map({
      container: this.element,
      style: "mapbox://styles/mapbox/streets-v12",
      center: this.pointsValue[0],
      zoom: 14
    })


    this.map.on('load', () => {
      this.#addMarkersToMap()
    })

  }

  #addMarkersToMap() {

      this.pointsValue.forEach((marker) => {
        // console.log(marker[0]);
        // console.log(marker[1]);
      new mapboxgl.Marker()
        .setLngLat([ marker[0], marker[1] ])
        .addTo(this.map)
    })
  }
}
