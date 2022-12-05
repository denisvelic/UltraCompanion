import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="mergemaps"
export default class extends Controller {
  static values = {
    apiKey: String,
    racepoints: Array,
    waterpoints: Array
  }

  connect() {
    // console.log(this.racepointsValue);
    // console.log(this.waterpointsValue);
    mapboxgl.accessToken = this.apiKeyValue

    this.map = new mapboxgl.Map({
      container: this.element,
      style: "mapbox://styles/mapbox/streets-v12",
      center: this.racepointsValue[0],
      zoom: 3
    })
    this.map.on('load', () => {
      this.map.addSource('route', {
          'type': 'geojson',
          'data': {
            'type': 'FeatureCollection',
            'features': [
              {
                'type': 'Feature',
                'geometry': {
                  'type': 'LineString',
                  'coordinates': this.racepointsValue
                }
              },
            ]
          }
        });

        this.map.addLayer({
          'id': 'race',
          'type': 'line',
          'source': 'route',
          'layout': {
            'line-join': 'round',
            'line-cap': 'round'
          },
          'paint': {
            'line-color': '#0000FF',
            'line-width': 8
          }
        });

        this.#addMarkersToMap()
        this.#fitMapToMarkers()

        // this.waterpointsValue.forEach(function() {
        //   // create a DOM element for the marker
        //   let customPoint = document.createElement("div");
        //   customPoint.className = "marker";
        //   customPoint.style.backgroundImage = `url('icons/water-bottle.png')`;
        //   customPoint.style.width = marker.properties.iconSize[0] + 'px';
        //   customPoint.style.height = marker.properties.iconSize[1] + 'px';
        // });

      })
    }
    #addMarkersToMap() {
      this.waterpointsValue.forEach((point) => {

        // let customPoint = document.createElement("div");
        // customPoint.className = "marker";
        // customPoint.style.backgroundImage = `url('icons/water-bottle.png')`;
      // Create a HTML element for your custom marker
      // const customMarker = document.createElement("div")
      // customMarker.className = "marker"
      // customMarker.style.backgroundImage = `url('icons/water-bottle.png')`
      // customMarker.style.backgroundSize = "contain"
      // customMarker.style.width = "25px"
      // customMarker.style.height = "25px"

      new mapboxgl.Marker()
        .setLngLat([ point[0], point[1] ])
        .addTo(this.map)
    })
  }

    #fitMapToMarkers() {
      const bounds = new mapboxgl.LngLatBounds()
      this.racepointsValue.forEach(point => bounds.extend([ point[0], point[1] ]))
      this.map.fitBounds(bounds, { padding: 70, maxZoom: 15, duration: 0 })
    }
}
