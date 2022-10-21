class Animal < ApplicationRecord
    validates :common_name, :scientific_binomial,  presence: true
    validates :common_name, :scientific_binomial,uniqueness: true

    has_many:sightings
end


   # validates_comparison_of :common_name, other_than: :scientific_binomial 