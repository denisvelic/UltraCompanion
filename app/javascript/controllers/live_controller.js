import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="live"
export default class extends Controller {
  static values = {
    apiKey: String
  }

  connect() {
    mapboxgl.accessToken = this.apiKeyValue

    navigator.geolocation.getCurrentPosition(
      // La connexion à la position GPS de l''utilisateur est un succès.
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
      },
       // L'utilisateur n'accèpte pas de partager sa position GPS. Il est par défaut positionné sur Nantes.
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
