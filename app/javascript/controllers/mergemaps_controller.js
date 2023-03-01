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
      zoom: 12,
      pitch: 0
    })

    const geolocate = new mapboxgl.GeolocateControl({
      positionOptions: {
        enableHighAccuracy: true
      },
      trackUserLocation: true
      });


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
            'line-color': '#2C445C',
            'line-width': 5
          }
        });
      }
    )

    this.#addMarkersToMap()
    this.#fitMapToMarkers()


    // Add the control to the map.
    this.map.addControl(geolocate);
    // Set an event listener that fires
    // when a geolocate event occurs.
    geolocate.on('geolocate', () => {
      console.log('A geolocate event has occurred.');
    });
  }

  // This part manage water access on the map.

  #addMarkersToMap() {
    this.waterpointsValue.forEach((point) => {

      const customMarker = document.createElement("div")
      customMarker.className = "marker"
      customMarker.style.backgroundImage = `url('${point.image_url}')`
      customMarker.style.backgroundSize = "contain"
      customMarker.style.width = "25px"
      customMarker.style.height = "25px"

      new mapboxgl.Marker(customMarker)
        .setLngLat([ point.lon, point.lat ])
        .addTo(this.map)
    })



    let point = this.racepointsValue[0]
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


    let pont = this.racepointsValue.pop()
  const customPoint = document.createElement("div")
  customPoint.className = "marker"
  customPoint.style.backgroundImage = "asset-url('icons/cloud.svg')"
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
    this.racepointsValue.forEach(point => bounds.extend([ point[0], point[1] ]))
    this.map.fitBounds(bounds, { padding: 70, maxZoom: 15, duration: 0 })
  }
}
