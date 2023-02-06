class RacesController < ApplicationController
  before_action :set_race, only: [:show, :update]
  before_action :set_user, only: [:index]

  def index
    # @races = Race.all ========== utile que si un seul user pour afficher toutes les races
    @races = @user.races # associer les courses à l'user
  end

  def show
    @race = Race.find(params[:id])
    @markers = @race.gpx_path
    @elevations = @race.elevations
    @gains = @race.gains
  end

  def new
    @race = Race.new
  end

  def start

  end

  def create
    @race = Race.new(race_params)
    gpx_file = params.require(:race).permit(:gpx_file)[:gpx_file].read
    @race.gpx_path = parse_gpx(gpx_file)
    @race.elevations = elevation_parse(gpx_file)
    @race.gains = elevation_gain(gpx_file)
    @race.user = current_user
    @race.status = "undone"

    if @race.save
      redirect_to races_path(@race)
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  # Méthode pour parser les coordonnées lattitude et longitude GPS du fichier GPX
  def parse_gpx(file)
    # file = File.read(filepath)
    doc = Nokogiri::XML(file)
    trackpoints = doc.xpath('//xmlns:trkpt')
    # funnel = Array.new
    trackpoints.map do |trkpt|
      lat = trkpt.xpath('@lat').to_s.to_f
      lng = trkpt.xpath('@lon').to_s.to_f
      # ele = trkpt.text.strip.to_f
      [lng, lat]
    end
  end

  # Méthode pour parser les coordonnées lattitude et longitude GPS du fichier GPX
  def elevation_parse(file)
    # file = File.open(filepath)
    doc = Nokogiri::XML(file)
    trackpoints = doc.xpath('//xmlns:trkpt')
    elevation = trackpoints.map do |trkpt|
      ele = trkpt.text.strip.to_f
      [ele]
    end
    elevation
  end

  # Méthode pour calculer l'élévation totale d'un parcours
def elevation_gain(filepath)
  # file = File.open(filepath)
  doc = Nokogiri::XML(File.open(file))
  elevations = doc.xpath('//xmlns:ele').map { |ele| ele.content.to_f }
  gain = 0
  elevations.each_with_index do |ele, index|
    if index > 0 && elevations[index - 1] < ele
      gain += ele - elevations[index - 1]
    end
  end
  gain
end

  def race_params
    params.require(:race).permit(:name, :date, :started_at, :gpx_file, :photo)
  end

  def set_race
    @race = Race.find(params[:id])
  end

  def set_user
    @user = current_user
  end
end
