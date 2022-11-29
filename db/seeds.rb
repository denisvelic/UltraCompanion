# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)
require 'date'

Race.destroy_all
User.destroy_all

celine = User.create!(email: "celine@hotmail.fr", password: "password", first_name: "Céline", last_name: "Brin", phone_number: "0987654326", description: "Passionnée de sport et on m'a conseillé de faire un parcours")
pierre = User.create!(email: "pierre@gmail.fr", password: "password", first_name: "Pierre", last_name: "Caro",  phone_number: "0698714320", description: "passionné de triath et pas à ma première expérience de race")

race_gpx_1 = File.read('db/seeds/fixtures/race1.txt')

race_gpx_2 = File.read('db/seeds/fixtures/race2.txt')

race_gpx_3 = File.read('db/seeds/fixtures/race3.txt')

race_gpx_4 = File.read('db/seeds/fixtures/race4.txt')


race1 = Race.create!(
  user: pierre,
  name: "bikingman france",
  date: DateTime.strptime("09/12/2022 09:57", "%m/%d/%Y %H:%M"),
  distance: 1000,
  elevationgain: 20_000,
  elevationloss: 20_000,
  gpx_file: race_gpx_1
)


race2 = Race.create!(
  user: pierre,
  name: "gravelman breizh",
  date: DateTime.strptime("10/12/2022 09:57", "%m/%d/%Y %H:%M"),
  distance: 355,
  elevationgain: 3720,
  elevationloss: 3720,
  gpx_file: race_gpx_2
)



race3 = Race.create!(
  user: pierre,
  name: "gravelman mont-blanc",
  date: DateTime.strptime("11/12/2022 09:57", "%m/%d/%Y %H:%M"),
  distance: 327,
  elevationgain: 8830,
  elevationloss: 8830,
  gpx_file: race_gpx_3
)


race4 = Race.create!(
  user: celine,
  name: "gravelman pays basques",
  date: DateTime.strptime("09/12/2022 09:57", "%m/%d/%Y %H:%M"),
  distance: 332,
  elevationgain: 8010,
  elevationloss: 8010,
  gpx_file: race_gpx_4
)

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
