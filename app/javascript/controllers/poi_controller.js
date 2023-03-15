import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="poi"
export default class extends Controller {
  static values = {
    apiKey: String
  }

  async connect() {
    // geoapify api key
    const apiKey = this.apiKeyValue

    navigator.geolocation.getCurrentPosition(
      // Success callback function if user grants location access.
      async (success) => {
      // 1. Extract latitude and longitude from the success object.
      const latitude = success.coords.latitude
      const longitude = success.coords.longitude

      console.log(latitude);
      console.log(longitude);

      // 2. Query Geopify API and get poi drinking water coordinates around me
      async function fetchPlaces(apiKey, latitude, longitude) {
        const defaultOptions = {
          categories: "amenity.drinking_water", // Type d'amenity
          filter: `circle:${latitude},${longitude},100000`, // Methode Geoapify avec un rayon de 10 km
          limit: 10,
        };
        const urlSearchParams = new URLSearchParams({
          ...defaultOptions,
          apiKey: apiKey,
        });
        const api_url = `https://api.geoapify.com/v2/places?${urlSearchParams}`;
        console.log(api_url)
        }
          await fetchPlaces(apiKey, latitude, longitude);
        }
      )
    }
  }




      // 2. Make it flexible to get any type of amenity
      // 3. Response -> Return each coordinates for POI into something
      // 4. From this something display each markers
      // 5. add Markers to the MAP

      // #addMarkersToMap() {
      //   this.waterpointsValue.forEach((point) => {

      //     const customMarker = document.createElement("div")
      //     customMarker.className = "marker"
      //     customMarker.style.backgroundImage = `url('${point.image_url}')`
      //     customMarker.style.backgroundSize = "contain"
      //     customMarker.style.width = "25px"
      //     customMarker.style.height = "25px"

      //     new mapboxgl.Marker(customMarker)
      //       .setLngLat([ point.lon, point.lat ])
      //       .addTo(this.map)
      //   })



// // Code saved to work with
// // This function fetches data from the Geoapify Places API
// async function fetchPlaces(apiKey, options) {
//   // Define default options for the API request
//   const defaultOptions = {
//     categories: "amenity.drinking_water",
//     filter: "circle:-1.6646715918647903,43.38746478130658,1000",
//     limit: 5,
//   };

//   // Merge default options with any passed in as an argument
//   const urlSearchParams = new URLSearchParams({
//     ...defaultOptions,
//     ...options,
//     apiKey,
//   });

//   // Construct the URL for the API request
//   const api_url = `https://api.geoapify.com/v2/places?${urlSearchParams}`;

//   try {
//     // Make an HTTP GET request to the API URL
//     const response = await fetch(api_url);
//     // Parse the response as JSON
//     const results = await response.json();
//     // Return the array of features from the API response
//     return results.features;
//   } catch (error) {
//     // Log any errors to the console and return an empty array
//     console.error(error);
//     return [];
//   }
// }

// This function maps features from the Places API response to a simpler format
function mapPlacesToAmenity(features) {
  return features.map((feature) => ({
    lat: feature.properties.lat,
    lon: feature.properties.lon,
    image_url: helpers.asset_url("icons/bottle_true.svg"),
  }));
}

// This function is the entry point to the module, and returns a Promise that resolves to an array of amenity locations
async function getAmenity() {
  // Get the Geoapify API key from an environment variable
  const apiKey = process.env.GEOAPIFY;
  // Fetch data from the Places API using default options
  const features = await fetchPlaces(apiKey, {
    categories: "amenity.drinking_water",
    filter: "circle:-1.6646715918647903,43.38746478130658,1000",
    limit: 5,
  });
  // Map the API response to a simpler format and return it
  return mapPlacesToAmenity(features);
}
