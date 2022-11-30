import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="map"
export default class extends Controller {
  static values = {
    apiKey: String,
    markers: Array
  }

  connect() {
    mapboxgl.accessToken = this.apiKeyValue

    this.map = new mapboxgl.Map({
      container: this.element,
      style: "mapbox://styles/mapbox/streets-v12",
      center: this.markersValue[0],
      zoom: 14
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
      'line-color': '#888',
      'line-width': 8
      }
      });
    })

    // this.#addMarkersToMap()
    // this.#addLineToMap()
    // this.#fitMapToMarkers()
    // console.log(this.markersValue);
  }

  #addMarkersToMap() {
    this.markersValue.forEach((marker) => {
    new mapboxgl.Marker()
      .setLngLat([ marker.lng, marker.lat ])
      .addTo(this.map)
  })
  }

  #addLineToMap() {
      // this.map.addLayer({
      //   'id': 'route',
      //   'type': 'line',
      //   'source': 'route',
      //   'layout': {
      //   'line-join': 'round',
      //   'line-cap': 'round'
      //   },
      //   'paint': {
      //   'line-color': '#888',
      //   'line-width': 8
      //   }
      // });
      this.map.addSource("route", this.markersValue);
      this.map.addLayer({
        id: 'route',
        type: 'line',
        source: 'route', // <= the same source id
        layout: {
          'line-cap': "round",
          'line-join': "round"
        },
        paint: {
          'line-color': "#6084eb",
          'line-width': 8
        }
      });
    }

  #fitMapToMarkers() {
    const bounds = new mapboxgl.LngLatBounds()
    this.markersValue.forEach(marker => bounds.extend([ marker.lng, marker.lat ]))
    this.map.fitBounds(bounds, { padding: 70, maxZoom: 15, duration: 0 })
  }
}
