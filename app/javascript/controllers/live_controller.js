import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="live"
export default class extends Controller {
  static values = {
    apiKey: String
  }

  connect() {
    // Mapbox api key.
    mapboxgl.accessToken = this.apiKeyValue
    // Get the user's current location using the browser's geolocation API.
    navigator.geolocation.getCurrentPosition(
       // Success callback function if user grants location access.
      (position) => {
        // Extract latitude and longitude from the position object.
        const latitude = position.coords.latitude
        const longitude = position.coords.longitude

        console.log(latitude);
        console.log(longitude);

        // Create a new Mapbox map with the user's location as the center.
        this.map = new mapboxgl.Map({
          container: this.element,
          style: "mapbox://styles/mapbox/streets-v12",
          center: [longitude, latitude],
          zoom: 12,
          pitch: 0
        })

        // Add the geolocate control to the map, which allows the user to center the map on their location.
        const geolocate = new mapboxgl.GeolocateControl({
          positionOptions: {
            enableHighAccuracy: true
          },
          trackUserLocation: true
          });

          this.map.addControl(geolocate);

          // Set an event listener that fires when the geolocate button is clicked.
          geolocate.on('geolocate', () => {
            console.log('A geolocate event has occurred.');
    });
      },
       // Error callback function if user denies location access.
      (error) => {
         // Set a default location (Nantes, France) if user denies location access
        const latitude = 47.218371
        const longitude = -1.553621

        // Create a new Mapbox map with the default location as the center.
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
