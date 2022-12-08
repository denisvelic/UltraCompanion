import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="map"
export default class extends Controller {
  static values = {
    apiKey: String,
    markers: Array
  }

  connect() {
    // console.log(this.markersValue);
    // console.log(this.#getEveryNth(this.markersValue, 10));
    mapboxgl.accessToken = this.apiKeyValue

    this.map = new mapboxgl.Map({
      container: this.element,
      style: "mapbox://styles/mapbox/streets-v12",
      center: this.markersValue[0],
      zoom: 7

    })
    this.map.on('load', () => {
      this.map.addSource('route', {
      'type': 'geojson',
      'data': {
      'type': 'Feature',
      'properties': {},
      'geometry': {
      'type': 'LineString',
      'coordinates': this.markersValue
      }
      }
      });
      this.map.addLayer({
      'id': 'route',
      'type': 'line',
      'source': 'route',
      'layout': {
      'line-join': 'round',
      'line-cap': 'round'
      },
      'paint': {
      'line-color': '#2C445C',
      'line-width': 2
      }
      });
    })


    this.#addMarkersToMap()
    this.#fitMapToMarkers()
    // console.log(this.markersValue);
  }

  #addMarkersToMap() {

    let point = this.markersValue[0]
    const customMarker = document.createElement("div")
    customMarker.className = "marker"
    customMarker.style.backgroundImage = "asset-url('icons/cloud.svg')"
    customMarker.style.backgroundSize = "contain"
    customMarker.style.backgroundColor = "#04AA6D"
    customMarker.style.borderRadius = "100%"
    customMarker.style.width = "25px"
    customMarker.style.height = "25px"
    new mapboxgl.Marker(customMarker)
      .setLngLat([ point[0], point[1] ])
      .addTo(this.map)


    let pont = this.markersValue.pop()
  const customPoint = document.createElement("div")
  customPoint.className = "marker"
  customPoint.style.backgroundImage = "asset-url('icons/clock.svg')"
  customPoint.style.backgroundSize = "contain"
  customPoint.style.backgroundColor = "#E60F05"
  customPoint.style.borderRadius = "100%"
  customPoint.style.width = "25px"
  customPoint.style.height = "25px"

  new mapboxgl.Marker(customPoint)
    .setLngLat([ pont[0], pont[1] ])
    .addTo(this.map)
  }

  #fitMapToMarkers() {
    const bounds = new mapboxgl.LngLatBounds()
    this.markersValue.forEach(marker => bounds.extend([ marker[0], marker[1] ]))
    this.map.fitBounds(bounds, { padding: 70, maxZoom: 15, duration: 0 })
  }

  // #getEveryNth(arr, nth) {
  //   const result = [];

  //   for (let i = 0; i < arr.length; i += nth) {
  //     result.push(arr[i]);
  //   }

  //   return result;
  // }
}
