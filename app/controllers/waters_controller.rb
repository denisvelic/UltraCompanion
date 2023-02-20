require 'net/http'
require 'json'

class WatersController < ApplicationController
  skip_before_action :authenticate_user!, only: %i[index show] ##a enlever

  def index

  end

  def show
    @race = Race.find(params[:race_id])
    @water_markers = parse_gpx('db/seeds/fixtures/water_point_angers_nantes.txt')
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

end
