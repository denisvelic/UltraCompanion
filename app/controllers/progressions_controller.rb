class ProgressionsController < ApplicationController

  def show
    @race = Race.find(params[:race_id])
    @gpx_file = @race.gpx_file
    @markers = parse_gpx(@gpx_file)
  end

  private

  def parse_gpx(filepath)
    file = File.open(filepath)
    doc = Nokogiri::XML(file)
    trackpoints = doc.xpath('//xmlns:trkpt')
    route = trackpoints.map do |trkpt|
      lat = trkpt.xpath('@lat').to_s.to_f
      lng = trkpt.xpath('@lon').to_s.to_f
      ele = trkpt.xpath('@ele').to_s.to_f
      [lng, lat, ele]
    end
  end

  def race_params
    params.require(:race).permit(:name, :date, :started_at)
  end

  def set_race
    @race = Race.find(params[:id])
  end
end
