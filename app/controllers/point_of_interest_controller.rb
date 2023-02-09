require 'net/http'
require 'json'

class PointOfInterestController < ApplicationController
  def index
    response = Net::HTTP.get(URI("http://overpass-api.de/api/interpreter?data=[out:json];node[\"amenity\"=\"drinking_water\"](around:#{params[:radius]},#{params[:latitude]},#{params[:longitude]});out body;>;out skel qt;"))
    @drinking_waters = JSON.parse(response)["elements"]
  end
end
