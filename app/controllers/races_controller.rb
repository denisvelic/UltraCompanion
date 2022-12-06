class RacesController < ApplicationController
  skip_before_action :authenticate_user!, only: %i[index show]
  before_action :set_race, only: [:show, :update]
  before_action :set_user, only: [:index]

  def index
    @races = @user.races
  end

  def show
    @race = Race.find(params[:id])
    @markers = @race.gpx_path
  end

  def new
    @race = Race.new
  end

  def update
    @race.update(race_params)
    redirect_to race_path(@race)
  end

  def create
    @race = Race.new(race_params)
    gpx_file = params.require(:race).permit(:gpx_file)[:gpx_file].read
    @race.gpx_path = parse_gpx(gpx_file)
    @race.user = current_user
    @race.status = "undone"

    if @race.save
      redirect_to races_path(@race)
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

  def race_params
    params.require(:race).permit(:name, :date, :started_at, :gpx_file)
  end

  def set_race
    @race = Race.find(params[:id])
  end

  def set_user
    @user = current_user
  end

end
