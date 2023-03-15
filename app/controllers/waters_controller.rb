require 'net/http'
require 'json'

class WatersController < ApplicationController
  skip_before_action :authenticate_user!, only: %i[index show] ##a enlever

  def index

  end

  def show
    @race = Race.find(params[:race_id])
    # @water_markers = parse_gpx('db/seeds/fixtures/water_point_angers_nantes.txt')
    @water_markers = api_poi
    @markers = @race.gpx_path
    # @status = @race.status
  end

  private

  def parse_gpx(filepath)
    file = File.open(filepath)
    doc = Nokogiri::XML(file)
    trackpoints = doc.xpath('//xmlns:wpt')
    amenity = trackpoints.map do |wpt|
      {
        lat: wpt.xpath('@lat').to_s.to_f,
        lng: wpt.xpath('@lon').to_s.to_f,
        image_url: helpers.asset_url("icons/bottle_true.svg")
      }
    end
    amenity
  end

  def api_poi
    access_token = ENV['GEOAPIFY']

    # get the user's current location using the geolocation API of the browser
    # latitude = '47.6586772'
    # longitude = '-2.7599079'

    # construct
    # api_url = "https://api.geoapify.com/v2/places?categories=amenity.drinking_water&filter=circle:-1.5768993084440663,47.21595744839796,1000&limit=5&apiKey=#{access_token}"
    api_url = "https://api.geoapify.com/v2/places?categories=amenity.drinking_water&filter=circle:-1.6646715918647903,43.38746478130658,1000&limit=5&apiKey=#{access_token}"

    # make an HTTP GET request to the API url
    uri = URI(api_url)
    response = Net::HTTP.get(uri)

    # parse the JSON response into a Ruby hash
    results = JSON.parse(response)
    # puts results
    # puts results["features"][0]["properties"]["lat"]
    # puts results["features"][0]["properties"]["lon"]
    amenity = results["features"].map do |feature|
      {
        lat: feature["properties"]["lat"],
        lon: feature["properties"]["lon"],
        image_url: helpers.asset_url("icons/bottle_true.svg")
      }
      # puts feature["properties"]["lat"]
      # puts feature["properties"]["lon"]
    end
    amenity
  end
end


def api_poi
  access_token = ENV['GEOAPIFY']

  api_url = "https://api.geoapify.com/v2/places?categories=amenity.drinking_water&filter=circle:-1.6646715918647903,43.38746478130658,1000&limit=5&apiKey=#{access_token}"

  # make an HTTP GET request to the API url
  uri = URI(api_url)
  response = Net::HTTP.get(uri)

  # parse the JSON response into a Ruby hash
  results = JSON.parse(response)
  amenity = results["features"].map do |feature|
    {
      lat: feature["properties"]["lat"],
      lon: feature["properties"]["lon"],
      image_url: helpers.asset_url("icons/bottle_true.svg")
    }
  end
  amenity
end
