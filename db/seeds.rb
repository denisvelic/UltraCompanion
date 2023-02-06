# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

require 'date'
require "nokogiri"
require 'haversine'

filepath = 'db/seeds/fixtures/race5.txt'

def parse_gpx(filepath)
  file = File.read(filepath)
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

parse_gpx(filepath)

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

# Output the result
p total_distance(filepath)


# Méthode pour parser chaque altitude des coordonnées GPS du fichier GPX
def elevation_parse(filepath)
  file = File.open(filepath)
  doc = Nokogiri::XML(file)
  trackpoints = doc.xpath('//xmlns:trkpt')
  elevation = trackpoints.map do |trkpt|
    trkpt.text.strip.to_f
  end
  elevation
end

# Méthode pour calculer l'élévation totale d'un parcours
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

# p elevation_gain(filepath)

# puts "Destroying all"

# Race.destroy_all
# User.destroy_all

# puts "Creating users"

# celine = User.create!(email: "celine@comp.fr", password: "password", first_name: "Céline", last_name: "Brin", phone_number: "0987654326", description: "Passionnée de sport et on m'a conseillé de faire un parcours")
# pierre = User.create!(email: "pierre@comp.fr", password: "password", first_name: "Pierre", last_name: "Caro",  phone_number: "0698714320", description: "passionné de triath et pas à ma première expérience de race")

# race_gpx_1 = 'db/seeds/fixtures/race1.txt'

# race_gpx_2 = 'db/seeds/fixtures/race2.txt'

# # race_gpx_3 = 'db/seeds/fixtures/race3.txt'

# # race_gpx_4 = 'db/seeds/fixtures/race4.txt'

# race_gpx_5 = 'db/seeds/fixtures/race5.txt'

# race_gpx_6 = 'db/seeds/fixtures/race6.txt'

# # race_gpx_7 = 'db/seeds/fixtures/race7.txt'

# # race_gpx_8 = 'db/seeds/fixtures/race8.txt'

# puts "Creating races"

# race1 = Race.create!(
#   user: pierre,
#   name: "Biking Man Cannes",
#   date: DateTime.strptime("09/12/2022 09:57", "%m/%d/%Y %H:%M"),
#   distance: 1040,
#   elevationgain: 20_000,
#   elevationloss: 20_000,
#   gpx_file: race_gpx_1,
#   city: "Cannes",
#   country: "France",
#   time: 88,
#   comp_distance: "Le format habituel des courses Biking man avec 1000 km. 3 grands cols à passer avec le légendaire Mont-Ventoux, Vars et la Bonnette",
#   comp_elevation: "Le dénivelé globale de 20 000m va être un gros défi.",
#   comp_time: "Le temps estimé est de 88 heures.",
#   status: "done"
# )

# race1.gpx_path = parse_gpx(race_gpx_1)
# race1.elevations = elevation_parse(race_gpx_1)
# race1.save

# race2 = Race.create!(
#   user: pierre,
#   name: "Gravelman Breizh",
#   date: DateTime.strptime("10/12/2022 09:57", "%m/%d/%Y %H:%M"),
#   distance: 355,
#   elevationgain: 3720,
#   elevationloss: 3720,
#   gpx_file: race_gpx_2,
#   city: "Plogoff",
#   country: "France",
#   time: 20,
#   comp_distance: "Le format habituel des courses gravel man de 355 km. L'édition est cette fois en Bretagne Nord.",
#   comp_elevation: "L'association vent et bosses courtes vont être un vrai challenge.",
#   comp_time: "Le temps estimé est de 20 heures.",
#   status: "done"
# )

# race2.gpx_path = parse_gpx(race_gpx_2)
# race2.elevations = elevation_parse(race_gpx_2)
# race2.save

# # race3 = Race.create!(
# #   user: pierre,
# #   name: "Ultra Nantes",
# #   date: DateTime.strptime("11/12/2022 09:57", "%m/%d/%Y %H:%M"),
# #   distance: 480,
# #   elevationgain: 2330,
# #   elevationloss: 2327,
# #   gpx_file: race_gpx_3,
# #   city: "Nantes",
# #   country: "France",
# #   time: 30,
# #   comp_distance: "Une distance intéressante de preque 500 km. Prends le temps de t'hydrater et de te reposer.",
# #   comp_elevation: "La sucession des petites bosses bretonnes va t'émousser. Attaque les tranquillement.",
# #   comp_time: "Le temps estimé est de 30 heures.",
# #   status: "undone"
# # )

# # race3.gpx_path = parse_gpx(race_gpx_3)
# # race3.elevations = elevation_parse(race_gpx_3)
# # race3.save

# # race4 = Race.create!(
# #   user: pierre,
# #   name: "Ultra de Noël",
# #   date: DateTime.strptime("09/12/2022 09:57", "%m/%d/%Y %H:%M"),
# #   distance: 1013,
# #   elevationgain: 6563,
# #   elevationloss: 6561,
# #   gpx_file: race_gpx_4,
# #   city: "Nantes",
# #   country: "France",
# #   time: 80,
# #   comp_distance: "Une distance sérieuse de 1000 km. Prends le temps de t'hydrater et de te reposer.",
# #   comp_elevation: "La sucession des petites bosses bretonnes va t'émousser. Attaque les tranquillement.",
# #   comp_time: "Le temps estimé est de 80 heures.",
# #   status: "undone"
# # )

# # race4.gpx_path = parse_gpx(race_gpx_4)
# # race4.elevations = elevation_parse(race_gpx_4)
# # race4.save

# race5 = Race.create!(
#   user: pierre,
#   name: "Gravelman Pays Basque",
#   date: DateTime.strptime("05/12/2022 09:57", "%m/%d/%Y %H:%M"),
#   distance: 332,
#   elevationgain: 8010,
#   elevationloss: 8010,
#   gpx_file: race_gpx_5,
#   city: "St Jean de Luz",
#   country: "France",
#   time: 20,
#   comp_distance: "Méfies-toi de la distance qui semble courte sur le papier. La concentration des cols en début de parcours va faire mal.",
#   comp_elevation: "Le dénivelé va faire mal. Soit prêt pour la bataille dans le col d'Arnosteguy et de Bagargui.",
#   comp_time: "Compte environ une journée de course à une allure moyenne de 14km/h.",
#   status: "done"
# )

# race5.gpx_path = parse_gpx(race_gpx_5)
# race5.elevations = elevation_parse(race_gpx_5)
# race5.save

# race6 = Race.create!(
#   user: pierre,
#   name: "Gravelman Pays Mont Blanc",
#   date: DateTime.strptime("06/12/2022 09:57", "%m/%d/%Y %H:%M"),
#   distance: 327,
#   elevationgain: 8830,
#   elevationloss: 8830,
#   gpx_file: race_gpx_6,
#   city: "Chamonix",
#   country: "France",
#   time: 26,
#   comp_distance: "Fais-toi plaisir sur ce parcours autour du Mont Blanc.",
#   comp_elevation: "Le dénivelé va faire mal. Tu vas passer par des cols mythiques des Alpes.",
#   comp_time: "Compte environ une journée de course à une allure moyenne de 13km/h.",
#   status: "done"
# )

# race6.gpx_path = parse_gpx(race_gpx_6)
# race6.elevations = elevation_parse(race_gpx_6)
# race6.save

# # race7 = Race.create!(
# #   user: celine,
# #   name: "Nantes Centre",
# #   date: DateTime.strptime("07/12/2022 09:57", "%m/%d/%Y %H:%M"),
# #   distance: 17,
# #   elevationgain: 113,
# #   elevationloss: 113,
# #   gpx_file: race_gpx_7,
# #   city: "Nantes",
# #   country: "France",
# #   time: 1,
# #   comp_distance: "pas de commentaire",
# #   comp_elevation: "pas de commentaire",
# #   comp_time: "pas de commentaire",
# #   status: "undone"
# # )

# # race7.gpx_path = parse_gpx(race_gpx_7)
# # race7.elevations = elevation_parse(race_gpx_7)
# # race7.save

# # race8 = Race.create!(
# #   user: pierre,
# #   name: "Nantes Beaujoire",
# #   date: DateTime.strptime("08/12/2022 09:57", "%m/%d/%Y %H:%M"),
# #   distance: 17,
# #   elevationgain: 110,
# #   elevationloss: 110,
# #   gpx_file: race_gpx_8,
# #   city: "Nantes",
# #   country: "France",
# #   time: 1,
# #   comp_distance: "pas de commentaire",
# #   comp_elevation: "pas de commentaire",
# #   comp_time: "pas de commentaire",
# #   status: "undone"
# # )

# # race8.gpx_path = parse_gpx(race_gpx_8)
# # race8.elevations = elevation_parse(race_gpx_8)
# # race8.save

# puts "Adding races map pictures"


# file = File.open(Rails.root.join('db/seeds/images/races/pierre.png'))
# pierre.photo.attach(io: file, filename: "pierre.png", content_type: "image/png")

# file = File.open(Rails.root.join('db/seeds/images/races/gravel.jpg'))
# race1.photo.attach(io: file, filename: "gravel.jpg", content_type: "image/png")
# race1.save

# file = File.open(Rails.root.join('db/seeds/images/races/bm.jpg'))
# race2.photo.attach(io: file, filename: "bm.jpg", content_type: "image/png")
# race2.save

# # file = File.open(Rails.root.join('db/seeds/images/races/tourmalet.jpg'))
# # race3.photo.attach(io: file, filename: "tourmalet.jpg", content_type: "image/png")
# # race3.save

# # file = File.open(Rails.root.join('db/seeds/images/races/biking.jpg'))
# # race4.photo.attach(io: file, filename: "biking.jpg", content_type: "image/png")
# # race4.save

# file = File.open(Rails.root.join('db/seeds/images/races/pays.jpg'))
# race5.photo.attach(io: file, filename: "pays.jpg", content_type: "image/png")
# race5.save

# file = File.open(Rails.root.join('db/seeds/images/races/gravel.jpg'))
# race6.photo.attach(io: file, filename: "gravel.jpg", content_type: "image/png")
# race6.save

# # file = File.open(Rails.root.join('db/seeds/images/races/bm.jpg'))
# # race7.photo.attach(io: file, filename: "bm.jpg", content_type: "image/png")
# # race7.save

# # file = File.open(Rails.root.join('db/seeds/images/races/vtt.jpeg'))
# # race8.photo.attach(io: file, filename: "vtt.jpeg", content_type: "image/png")
# # race8.save

# puts "Adding Drinking Water GPX location"
# # Points d'eau pour la région Pays de la Loire

# # water_gpx_paysloire = 'db/seeds/fixtures/paysloire.txt'
# water_gpx_west_france = 'db/seeds/fixtures/water_west_france.txt'

# # water_paysloire = Water.create!(
# #   name: "Water Pays de la loire",
# #   gpx_file: water_gpx_paysloire
# # )

# water_west_france = Water.create!(
#   name: "Water Ouest France",
#   gpx_file: water_gpx_west_france
# )

# puts "Finished"
