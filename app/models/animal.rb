class Animal < ApplicationRecord
    validates :common_name, :scientific_binomial,  presence: true
    has_many:sightings
end
