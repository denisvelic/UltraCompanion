require 'net/http'
require 'json'

class PointOfInterestController < ApplicationController
  def index
    uri = URI("http://overpass-api.de/api/interpreter")
    params = {
      data: "[out:json];node[\"amenity\"= \"drinking_water\"](around:#{radius},#{params[:latitude]},#{params[:longitude]});out body;>;out skel qt;",
      radius: 100000, # Radius allow to perform a research in a distance 1000 = 1000 meter
    }

    response = Net::HTTP.post_form(uri, params)
    @points_of_interest = JSON.parse(response.body)['elements']
  end
end
