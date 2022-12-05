# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)
require 'date'

puts "Destroying all"

Race.destroy_all
User.destroy_all

puts "Creating users"

celine = User.create!(email: "celine@comp.fr", password: "password", first_name: "Céline", last_name: "Brin", phone_number: "0987654326", description: "Passionnée de sport et on m'a conseillé de faire un parcours")
pierre = User.create!(email: "pierre@comp.fr", password: "password", first_name: "Pierre", last_name: "Caro",  phone_number: "0698714320", description: "passionné de triath et pas à ma première expérience de race")

race_gpx_1 = 'db/seeds/fixtures/race1.txt'

race_gpx_2 = 'db/seeds/fixtures/race2.txt'

race_gpx_3 = 'db/seeds/fixtures/race3.txt'

race_gpx_4 = 'db/seeds/fixtures/race4.txt'

race_gpx_5 = 'db/seeds/fixtures/race5.txt'

race_gpx_6 = 'db/seeds/fixtures/race6.txt'

race_gpx_7 = 'db/seeds/fixtures/race7.txt'

race_gpx_8 = 'db/seeds/fixtures/race8.txt'

puts "Creating races"

race1 = Race.create!(
  user: pierre,
  name: "Bikingman Cannes, France",
  date: DateTime.strptime("09/12/2022 09:57", "%m/%d/%Y %H:%M"),
  distance: 1040,
  elevationgain: 20_000,
  elevationloss: 20_000,
  gpx_file: race_gpx_1,
  city: "Cannes",
  country: "France",
  time: 88,
  comp_distance: "Le format habituel des courses Biking man avec 1000 km. 3 grands cols à passer avec le légendaire Mont-Ventoux, Vars et la Bonnette",
  comp_elevation: "Le dénivelé globale de 20 000m va être un gros défi.",
  comp_time: "Le temps estimé est de 88 heures."
)

race2 = Race.create!(
  user: pierre,
  name: "Gravelman Breizh",
  date: DateTime.strptime("10/12/2022 09:57", "%m/%d/%Y %H:%M"),
  distance: 355,
  elevationgain: 3720,
  elevationloss: 3720,
  gpx_file: race_gpx_2,
  city: "Plogoff",
  country: "France",
  time: 20,
  comp_distance: "Le format habituel des courses gravel man de 355 km. L'édition est cette fois en Bretagne Nord.",
  comp_elevation: "L'association vent et bosses courtes vont être un vrai challenge.",
  comp_time: "Le temps estimé est de 20 heures."
)

race3 = Race.create!(
  user: pierre,
  name: "Ultra Nantes",
  date: DateTime.strptime("11/12/2022 09:57", "%m/%d/%Y %H:%M"),
  distance: 480,
  elevationgain: 2330,
  elevationloss: 2327,
  gpx_file: race_gpx_3,
  city: "Nantes",
  country: "France",
  time: 30,
  comp_distance: "Une distance intéressante de preque 500 km. Prends le temps de t'hydrater et de te reposer.",
  comp_elevation: "La sucession des petites bosses bretonnes va t'émousser. Attaque les tranquillement.",
  comp_time: "Le temps estimé est de 30 heures."
)

race4 = Race.create!(
  user: pierre,
  name: "Ultra de Noël",
  date: DateTime.strptime("09/12/2022 09:57", "%m/%d/%Y %H:%M"),
  distance: 1013,
  elevationgain: 6563,
  elevationloss: 6561,
  gpx_file: race_gpx_4,
  city: "Nantes",
  country: "France",
  time: 80,
  comp_distance: "Une distance sérieuse de 1000 km. Prends le temps de t'hydrater et de te reposer.",
  comp_elevation: "La sucession des petites bosses bretonnes va t'émousser. Attaque les tranquillement.",
  comp_time: "Le temps estimé est de 80 heures."
)

race5 = Race.create!(
  user: pierre,
  name: "Gravelman Pays Basque",
  date: DateTime.strptime("05/12/2022 09:57", "%m/%d/%Y %H:%M"),
  distance: 332,
  elevationgain: 8010,
  elevationloss: 8010,
  gpx_file: race_gpx_5,
  city: "St Jean de Luz",
  country: "France",
  time: 25,
  comp_distance: "Méfies-toi de la distance qui semble courte sur le papier. La concentration des cols en début de parcours va faire mal.",
  comp_elevation: "Le dénivelé va faire mal. Soit prêt pour la bataille dans le col d'Arnosteguy et de Bagargui.",
  comp_time: "Compte environ une journée de course à une allure moyenne de 14km/h."
)

race6 = Race.create!(
  user: pierre,
  name: "Gravelman Pays Mont Blanc",
  date: DateTime.strptime("06/12/2022 09:57", "%m/%d/%Y %H:%M"),
  distance: 327,
  elevationgain: 8830,
  elevationloss: 8830,
  gpx_file: race_gpx_6,
  city: "Chamonix",
  country: "France",
  time: 26,
  comp_distance: "Fais-toi plaisir sur ce parcours autour du Mont Blanc.",
  comp_elevation: "Le dénivelé va faire mal. Tu vas passer par des cols mythiques des Alpes.",
  comp_time: "Compte environ une journée de course à une allure moyenne de 13km/h."
)

race7 = Race.create!(
  user: celine,
  name: "Nantes Centre",
  date: DateTime.strptime("07/12/2022 09:57", "%m/%d/%Y %H:%M"),
  distance: 17,
  elevationgain: 113,
  elevationloss: 113,
  gpx_file: race_gpx_7,
  city: "Nantes",
  country: "France",
  time: 1,
  comp_distance: "pas de commentaire",
  comp_elevation: "pas de commentaire",
  comp_time: "pas de commentaire"
)

race8 = Race.create!(
  user: pierre,
  name: "Nantes Beaujoire",
  date: DateTime.strptime("08/12/2022 09:57", "%m/%d/%Y %H:%M"),
  distance: 17,
  elevationgain: 110,
  elevationloss: 110,
  gpx_file: race_gpx_8,
  city: "Nantes",
  country: "France",
  time: 1,
  comp_distance: "pas de commentaire",
  comp_elevation: "pas de commentaire",
  comp_time: "pas de commentaire"
)

puts "Adding races map pictures"

file = File.open(Rails.root.join('db/seeds/images/races/biking_man_map.png'))
race1.photo.attach(io: file, filename: "biking_man_map.png", content_type: "image/png")

file = File.open(Rails.root.join('db/seeds/images/races/gravel_man_breizh_map.png'))
race2.photo.attach(io: file, filename: "gravel_man_breizh_map.png", content_type: "image/png")

file = File.open(Rails.root.join('db/seeds/images/races/gravel_man_mont_blanc_map.png'))
race3.photo.attach(io: file, filename: "gravel_man_mont_blanc_map.png", content_type: "image/png")

file = File.open(Rails.root.join('db/seeds/images/races/gravel_man_pays_basque_map.png'))
race4.photo.attach(io: file, filename: "gravel_man_pays_basque_map.png", content_type: "image/png")

file = File.open(Rails.root.join('db/seeds/images/races/pierre.png'))
pierre.photo.attach(io: file, filename: "pierre.png", content_type: "image/png")

file = File.open(Rails.root.join('db/seeds/images/races/celine.png'))
celine.photo.attach(io: file, filename: "celine.png", content_type: "image/png")

file = File.open(Rails.root.join('db/seeds/images/races/race5.png'))
race1.photo.attach(io: file, filename: "race5.png", content_type: "image/png")

file = File.open(Rails.root.join('db/seeds/images/races/race6.png'))
race2.photo.attach(io: file, filename: "race6.png", content_type: "image/png")

file = File.open(Rails.root.join('db/seeds/images/races/race7.png'))
race3.photo.attach(io: file, filename: "race7.png", content_type: "image/png")

file = File.open(Rails.root.join('db/seeds/images/races/race8.png'))
race4.photo.attach(io: file, filename: "race8.png", content_type: "image/png")

puts "Adding Drinking Water GPX location"
# Points d'eau pour la région Pays de la Loire

water_gpx_paysloire = 'db/seeds/fixtures/paysloire.txt'
water_gpx_west_france = 'db/seeds/fixtures/water_west_france.txt'

water_paysloire = Water.create!(
  name: "Water Pays de la loire",
  gpx_file: water_gpx_paysloire
)

water_west_france = Water.create!(
  name: "Water Ouest France",
  gpx_file: water_gpx_west_france
)

puts "Finished"
