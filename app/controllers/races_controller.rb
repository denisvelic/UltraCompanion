class RacesController < ApplicationController
  skip_before_action :authenticate_user!, only: %i[index show] ##a enlever


  def index
    # parse_gpx(gpx_file)
  end

  def show
    @race = Race.find(params[:id])
  end

  private

  # def self.parse_gpx(gpx_file)
  #   file = File.open(gpx_file)
  #   doc = Nokogiri::XML(file)
  #   trackpoints = doc.xpath('//xmlns:trkpt')
  #   route = Array.new
  #   trackpoints.each do |trkpt|
  #     latitude = trkpt.xpath('@lat').to_s.to_f
  #     longitude = trkpt.xpath('@lon').to_s.to_f
  #     elevation = trkpt.text.strip.to_f
  #     route << {latitude: latitude, longitude: longitude, elevation: elevation}
  #   end
  #   route
  # end
end
