class RacesController < ApplicationController
  skip_before_action :authenticate_user!, only: %i[index show]

  def index
    @races = Race.all
  end

  def show
    @race = Race.find(params[:id])
    @gpx_file = @race.gpx_file
    @markers = parse_gpx(@gpx_file)
  end

  def new
    @race = Race.new
  end

  def create
    @race = Race.new(race_params)
    @race.user = current_user

    if @race.save
      redirect_to races_path(@race)
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  def parse_gpx(filepath)
    file = File.open(filepath)
    doc = Nokogiri::XML(file)
    trackpoints = doc.xpath('//xmlns:trkpt')
    # funnel = Array.new
    route = trackpoints.map do |trkpt|
      lat = trkpt.xpath('@lat').to_s.to_f
      lng = trkpt.xpath('@lon').to_s.to_f
      # ele = trkpt.text.strip.to_f
      [lng, lat]
    end
    # route.map do |coor|
    #   if route.index(coor) % (route.length/100) == 0
    #    funnel.push(coor)
    #   end
    #  end
    # funnel
    route ## Pour test, on renvoie les 4 premiers points

  end

  def race_params
    params.require(:race).permit(:status, :name, :date)
  end


end
