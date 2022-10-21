require 'rails_helper'

RSpec.describe Animal, type: :model do
  describe 'Animal Model' do 
  it 'throws an error if common name is empty' do 
  animal = Animal.create common_name: nil, scientific_binomial: 'jellyfish absolute'

  p animal.errors[:common_name]

    expect(animal.errors[:common_name]).to_not be_empty
    expect(animal.errors[:common_name]).to eq ["can't be blank"]
  end
  it 'throws an error if scientific_binomial is empty' do 
    animal = Animal.create common_name: 'jellyfish', scientific_binomial: nil
  
    p animal.errors[:scientific_binomial]
  
      expect(animal.errors[:scientific_binomial]).to_not be_empty
      expect(animal.errors[:scientific_binomial]).to eq ["can't be blank"]
  end
  it 'is not valid if the common_name is not unique' do
    Animal.create(common_name: 'jellyfish', scientific_binomial: 'jellyfishic absolute')
    animal = Animal.create(common_name: 'jellyfish', scientific_binomial: 'jellyfishic absolute')
    expect(animal.errors[:common_name]).to_not be_empty
  end 
  it 'is not valid if the scientific_binomial is not unique' do
    Animal.create(common_name: 'jellyfish', scientific_binomial: 'jellyfishic absolute')
    animal = Animal.create(common_name: 'jellyfish', scientific_binomial: 'jellyfishic absolute')
    expect(animal.errors[:scientific_binomial]).to_not be_empty
  end 
end
end



 # it 'throws an error if scientific_binomial and common_name are the same' do 
  #   animal = Animal.create common_name: 'jellyfish', scientific_binomial: 'jellyfish'

  #     expect(animal.errors[:common_name]).to_not eq [:scientific_binomial]
  # end
