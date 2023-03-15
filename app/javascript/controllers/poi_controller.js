import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="poi"
export default class extends Controller {
  static values = {
    geoapifyApiKey: String,
    mapboxApiKey: String
  }

  async connect() {
    // geoapify & mapbox api keys
    const geoapifyApiKey = this.geoapifyApiKeyValue;
    mapboxgl.accessToken = this.mapboxApiKeyValue;

    navigator.geolocation.getCurrentPosition(
      // Success callback function if user grants location access.
      async (success) => {
      // 1. Extract latitude and longitude from the success object.
      const longitude = success.coords.longitude
      const latitude = success.coords.latitude

      // console.log(longitude);
      // console.log(latitude);

      // 2. Query Geoapify API from URL
      const categories = "amenity.drinking_water";
      const filter = `circle:${longitude},${latitude},100000`;
      const bias = `proximity:${longitude},${latitude}`;
      const limit = 20;
      const url = `https://api.geoapify.com/v2/places?categories=${categories}&filter=${filter}&bias=${bias}&limit=${limit}&apiKey=${geoapifyApiKey}`;

      // console.log(url);

      // 3. Get POI from URL
      const response = await fetch(url);
      const data = await response.json();

      // console.log(data);

      // 4. Get each POI Coordinates
      const poiCoordinates = data.features.map((feature) => {
        return feature.geometry.coordinates;
      });

      // console.log(poiCoordinates);

      // 5. Create a new map
      this.map = new mapboxgl.Map({
        container: this.element, // container ID
        style: 'mapbox://styles/mapbox/streets-v12', // style URL
        center: [longitude, latitude], // starting position [lng, lat]
        zoom: 12 // starting zoom
      });

      // 6. Add markers for each POI coordinate
      poiCoordinates.forEach((coordinate) => {
        new mapboxgl.Marker()
          .setLngLat(coordinate)
          .addTo(this.map);
      });

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

      }
      )
    }
  }
