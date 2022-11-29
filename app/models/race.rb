class Race < ApplicationRecord
  belongs_to :user
  has_one_attached :photo

  geocoded_by :gpx_file
end
