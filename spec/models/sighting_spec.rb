require 'rails_helper'

RSpec.describe Sighting, type: :model do
  describe 'Sighting Model' do 
    it 'throws an error if latitude is empty' do 
    sighting = Sighting.create animal_id: 1, latitude:nil, longitude: '89274.123 N', date:20220901 
  
    p sighting.errors[:latitude]
  
      expect(sighting.errors[:latitude]).to_not be_empty
      expect(sighting.errors[:latitude]).to eq ["can't be blank"]
    end
    it 'throws an error if longitude is empty' do 
      sighting = Sighting.create animal_id: 1, latitude: '1234.123 S', longitude:nil, date:20220901 
    
      p sighting.errors[:longitude]
    
        expect(sighting.errors[:longitude]).to_not be_empty
        expect(sighting.errors[:longitude]).to eq ["can't be blank"]
    end
    it 'throws an error if date is empty' do 
      sighting = Sighting.create animal_id: 1, latitude: '1234.123 S', longitude:'89274.123 N', date:nil 
    
      p sighting.errors[:date]
    
        expect(sighting.errors[:date]).to_not be_empty
        expect(sighting.errors[:date]).to eq ["can't be blank"]
    end
  end
end
