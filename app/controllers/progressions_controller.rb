class ProgressionsController < ApplicationController

  def show
    @race = Race.find(params[:race_id])
    @markers = @race.gpx_path
    @elevations = @race.elevations
    
  end

  private

  # parsing du fichier pour afficher la carte et le parcours sur la page
  # def parse_gpx(file)
  #   # file = File.open(filepath)
  #   doc = Nokogiri::XML(file)
  #   trackpoints = doc.xpath('//xmlns:trkpt')
  #   route = trackpoints.map do |trkpt|
  #     lat = trkpt.xpath('@lat').to_s.to_f
  #     lng = trkpt.xpath('@lon').to_s.to_f
  #     [lng, lat]
  #   end
  #   route
  # end

  # parsing du fichier pour obtenir les valeurs de l'élévation
  # def elevation_parse(file)
  #   # file = File.open(filepath)
  #   doc = Nokogiri::XML(file)
  #   trackpoints = doc.xpath('//xmlns:ele')
  #   elevation = trackpoints.map do |trkpt|
  #     trkpt.text.strip.to_f
  #   end
  #   elevation
  # end



  def race_params
    params.require(:race).permit(:name, :date, :started_at)
  end

  def set_race
    @race = Race.find(params[:id])
  end
end
