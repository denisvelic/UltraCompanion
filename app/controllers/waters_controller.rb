class WatersController < ApplicationController
  skip_before_action :authenticate_user!, only: %i[index show] ##a enlever

  def index
  end

  def show
    @water = Water.find(params[:id])
    @gpx_file = @water.gpx_file
    @water_markers = parse_gpx('db/seeds/fixtures/paysloire.txt')
  end

  private

  def parse_gpx(filepath)
    file = File.open(filepath)
    doc = Nokogiri::XML(file)
    trackpoints = doc.xpath('//xmlns:wpt')
    amenity = trackpoints.map do |wpt|
      lat = wpt.xpath('@lat').to_s.to_f
      lng = wpt.xpath('@lon').to_s.to_f
      [lng, lat]
    end
    amenity
  end
end
