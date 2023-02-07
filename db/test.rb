require 'date'
require "nokogiri"
require 'haversine'

filepath = 'db/seeds/fixtures/race5.txt'

# Method to get total distance with haversine gem
# Load the GPX file into a Nokogiri document
def total_distance(filepath)
  file = File.read(filepath)
  doc = Nokogiri::XML(file)
  track_points = doc.xpath('//xmlns:trkpt')
  total_distance = 0.0

  # Loop through all track points
  track_points.each_with_index do |point, index|
    # Get the latitude and longitude of the current track point
    lat = point.attr('lat').to_f
    lon = point.attr('lon').to_f

    # Get the latitude and longitude of the next track point (if there is one)
    next_lat = track_points[index + 1].attr('lat').to_f if index + 1 < track_points.count
    next_lon = track_points[index + 1].attr('lon').to_f if index + 1 < track_points.count

    # Calculate the distance between the current and next track point (if there is one)
    if next_lat && next_lon
      distance = Haversine.distance(lat, lon, next_lat, next_lon).to_km
      total_distance += distance
    end
  end
  total_distance.round(2)
end

puts "Race distance is :"
p total_distance(filepath)

def elevation_gain(filepath)
  file = File.open(filepath)
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

puts "Race elevation elevation gain is :"
p elevation_gain(filepath)
