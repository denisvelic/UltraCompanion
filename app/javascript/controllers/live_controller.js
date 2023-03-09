import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="live"
export default class extends Controller {
  static values = {
    apiKey: String
  }

  connect() {
    mapboxgl.accessToken = this.apiKeyValue

      // const geolocate = new mapboxgl.GeolocateControl({
      //   positionOptions: {
      //     enableHighAccuracy: true
      //   },
      //   trackUserLocation: true
      //   });

      //   // Add the control to the map.
      //   this.map.addControl(geolocate);
      //   // Set an event listener that fires
      //   // when a geolocate event occurs.
      //   geolocate.on('geolocate', () => {
      //     console.log('A geolocate event has occurred.');
      //   });

    navigator.geolocation.getCurrentPosition(
      (position) => {
        const latitude = position.coords.latitude
        const longitude = position.coords.longitude

        console.log(latitude);
        console.log(longitude);

        this.map = new mapboxgl.Map({
          container: this.element,
          style: "mapbox://styles/mapbox/streets-v12",
          center: [longitude, latitude],
          zoom: 12,
          pitch: 0
        })

      },
      (error) => {
        const latitude = 47.218371
        const longitude = -1.553621

        this.map = new mapboxgl.Map({
          container: this.element,
          style: "mapbox://styles/mapbox/streets-v12",
          center: [longitude, latitude],
          zoom: 12,
          pitch: 0
        })
      }
    )
  }
}
