import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="live"
export default class extends Controller {
  static values = {
    geoapifyApiKey: String,
    mapboxApiKey: String
  }

  async connect() {
    // geoapify & mapbox api keys
    const geoapifyApiKey = this.geoapifyApiKeyValue;
    mapboxgl.accessToken = this.mapboxApiKeyValue;

    // Get the user's current location using the browser's geolocation API.
    navigator.geolocation.getCurrentPosition(
      // Success callback function if user grants location access.
      async (success) => {
      // 1. Extract latitude and longitude from the success object.
        const longitude = success.coords.longitude
        const latitude = success.coords.latitude

        console.log(longitude)
        console.log(latitude)

        // 2. Query Geoapify API from URL
        const categories = "amenity.drinking_water";
        const filter = `circle:${longitude},${latitude},100000`;
        const bias = `proximity:${longitude},${latitude}`;
        const limit = 5;
        const url = `https://api.geoapify.com/v2/places?categories=${categories}&filter=${filter}&bias=${bias}&limit=${limit}&apiKey=${geoapifyApiKey}`;

        console.log(url)

        // 3. Get POI from URL
        const response = await fetch(url);
        const data = await response.json();

        console.log(data)

        // 4. Get each POI Coordinates
        const poiCoordinates = data.features.map((feature) => {
          return feature.geometry.coordinates;
        });

        console.log(poiCoordinates)

        // 5. Create a new Mapbox map with the user's location as the center.
        this.map = new mapboxgl.Map({
          container: this.element,
          style: "mapbox://styles/mapbox/streets-v12",
          center: [longitude, latitude],
          zoom: 12,
          pitch: 0
        });

        // 6. Add markers for each POI coordinate
        poiCoordinates.forEach((coordinate) => {
          // Create a new marker with a custom HTML element.
          const marker = document.createElement('div');
          marker.className = 'marker';
          new mapboxgl.Marker({ element: marker })
            .setLngLat(coordinate)
            .addTo(this.map);
        });

        // 7. Add the geolocate control to the map, which allows the user to center the map on their location.
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
      async (error) => {
        //1. Set a default location (Nantes, France) if user denies location access
        const latitude = 47.218371
        const longitude = -1.553621

        // 2. Query Geoapify API from URL
        const categories = "amenity.drinking_water";
        const filter = `circle:${longitude},${latitude},100000`;
        const bias = `proximity:${longitude},${latitude}`;
        const limit = 20;
        const url = `https://api.geoapify.com/v2/places?categories=${categories}&filter=${filter}&bias=${bias}&limit=${limit}&apiKey=${geoapifyApiKey}`;

        // 3. Get POI from URL
        const response = await fetch(url);
        const data = await response.json();

        // 4. Get each POI Coordinates
        const poiCoordinates = data.features.map((feature) => {
          return feature.geometry.coordinates;
        });

        // console.log(poiCoordinates);

        // Create a new Mapbox map with the default location as the center.
        this.map = new mapboxgl.Map({
          container: this.element,
          style: "mapbox://styles/mapbox/streets-v12",
          center: [longitude, latitude],
          zoom: 12,
          pitch: 0
        });

        // 6. Add markers for each POI coordinate
        poiCoordinates.forEach((coordinate) => {
          new mapboxgl.Marker()
            .setLngLat(coordinate)
            .addTo(this.map);
        });
      }
    )
  }
}
