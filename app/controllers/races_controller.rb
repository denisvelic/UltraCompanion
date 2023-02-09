class RacesController < ApplicationController
  before_action :set_race, only: [:show, :update]
  before_action :set_user, only: [:index]

  def index
    @races = Race.all
  end

  def show
    @race = Race.find(params[:id])
    @markers = @race.gpx_path
    @elevations = @race.elevations
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
    @race.user = current_user
    @race.status = "undone"

    if @race.save
      redirect_to race_waters_path(@race)
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

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

  # def parse_gpx(file)
  #     # file = File.read(filepath)
  #     doc = Nokogiri::XML(file)
  #     trackpoints = doc.xpath('//xmlns:trkpt')
  #     # funnel = Array.new
  #     yaya = trackpoints.map do |trkpt|
  #       {
  #       lat: trkpt.xpath('@lat').to_s.to_f,
  #       lng: trkpt.xpath('@lon').to_s.to_f,
  #       image_url: helpers.asset_url("pierre.png")
  #       }
  #     end
  #     yaya
  # end

  # parsing du fichier pour obtenir les valeurs de l'élévation
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
