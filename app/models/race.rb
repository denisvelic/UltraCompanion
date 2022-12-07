class Race < ApplicationRecord
  belongs_to :user
  has_one_attached :photo
  # has_one_attached :gpx_file
  geocoded_by :gpx_file

  serialize :gpx_path, Array
  serialize :elevations, Array
end
