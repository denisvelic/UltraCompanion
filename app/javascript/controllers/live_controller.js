import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="live"
export default class extends Controller {
  static values = {
    apiKey: String
  }

  connect() {
    mapboxgl.accessToken = this.apiKeyValue

    this.map = new mapboxgl.Map({
      container: this.element,
      style: "mapbox://styles/mapbox/streets-v12",
      center: [-1.553621, 47.218371],
      zoom: 12,
      pitch: 0
    })

    const geolocate = new mapboxgl.GeolocateControl({
      positionOptions: {
        enableHighAccuracy: true
      },
      trackUserLocation: true
      });

    // Add the control to the map.
    this.map.addControl(geolocate);
    // Set an event listener that fires
    // when a geolocate event occurs.
    geolocate.on('geolocate', () => {
      console.log('A geolocate event has occurred.');
    });
  }
}
