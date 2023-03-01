# require 'date'
# require "nokogiri"
# require 'haversine'

require 'net/http'
require 'json'
require 'dotenv'
# gem geocoder
Dotenv.load


def api_poi
  access_token = ENV['GEOAPIFY']

  # get the user's current location using the geolocation API of the browser
  # latitude = '47.6586772'
  # longitude = '-2.7599079'

  # construct
  api_url = "https://api.geoapify.com/v2/places?categories=amenity.drinking_water&filter=circle:-1.5768993084440663,47.21595744839796,1000&limit=5&apiKey=#{access_token}"

  # make an HTTP GET request to the API url
  uri = URI(api_url)
  response = Net::HTTP.get(uri)

  # parse the JSON response into a Ruby hash
  results = JSON.parse(response)
  # puts results
  # puts results["features"][0]["properties"]["lat"]
  # puts results["features"][0]["properties"]["lon"]
  amenity = results["features"].map do |feature|
    {
      lat: feature["properties"]["lat"],
      lon: feature["properties"]["lon"],
      # image_url: helpers.asset_url("icons/bottle_true.svg")
    }
    # puts feature["properties"]["lat"]
    # puts feature["properties"]["lon"]
  end
  puts amenity
end

api_poi

# category = "supermarket"
# longitude = -1.5541362
# latitude = 47.2186371

# structure de l'URL de Mapbox
# "https://api.mapbox.com/geocoding/v5/mapbox.places/#{category}.json?type=poi&proximity=#{longitude},#{latitude}&access_token=#{access_token}"




# filepath = 'db/seeds/fixtures/race5.txt'

# Method to get total distance with haversine gem
# # Load the GPX file into a Nokogiri document
# def total_distance(filepath)
#   file = File.read(filepath)
#   doc = Nokogiri::XML(file)
#   track_points = doc.xpath('//xmlns:trkpt')
#   total_distance = 0.0

#   # Loop through all track points
#   track_points.each_with_index do |point, index|
#     # Get the latitude and longitude of the current track point
#     lat = point.attr('lat').to_f
#     lon = point.attr('lon').to_f

#     # Get the latitude and longitude of the next track point (if there is one)
#     next_lat = track_points[index + 1].attr('lat').to_f if index + 1 < track_points.count
#     next_lon = track_points[index + 1].attr('lon').to_f if index + 1 < track_points.count

#     # Calculate the distance between the current and next track point (if there is one)
#     if next_lat && next_lon
#       distance = Haversine.distance(lat, lon, next_lat, next_lon).to_km
#       total_distance += distance
#     end
#   end
#   total_distance.round(2)
# end

# puts "Race distance is :"
# p total_distance(filepath)

# def elevation_gain(filepath)
#   file = File.open(filepath)
#   doc = Nokogiri::XML(File.open(file))
#   elevations = doc.xpath('//xmlns:ele').map { |ele| ele.content.to_f }
#   gain = 0
#   elevations.each_with_index do |ele, index|
#     if index > 0 && elevations[index - 1] < ele
#       gain += ele - elevations[index - 1]
#     end
#   end
#   gain
# end

# puts "Race elevation elevation gain is :"
# p elevation_gain(filepath)
