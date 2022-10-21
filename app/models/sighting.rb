class Sighting < ApplicationRecord
    validates :latitude, :longitude, :date, presence: true
    belongs_to:animal
end
