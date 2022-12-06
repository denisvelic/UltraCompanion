class WatersController < ApplicationController
  skip_before_action :authenticate_user!, only: %i[index show] ##a enlever

  def index
  end

  def show
    # @water = Water.find(params[:id])

    # @gpx_file = @water.gpx_file
    @race = Race.find(params[:race_id])
    @water_markers = parse_gpx('db/seeds/fixtures/water_west_france.txt')
    @markers = parse_gpx_race(@race.gpx_file)
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

  def parse_gpx_race(filepath)
    file = File.open(filepath)
    doc = Nokogiri::XML(file)
    trackpoints = doc.xpath('//xmlns:trkpt')
    route = trackpoints.map do |trkpt|
      lat = trkpt.xpath('@lat').to_s.to_f
      lng = trkpt.xpath('@lon').to_s.to_f
      [lng, lat]
    end
    route
  end
end
