class Person < ActiveRecord::Base
  attr_accessible :name, :date_of_birth, :date_of_death, :orientation_date, :gender, :description, :place_of_birth, :burial_place

  validates_presence_of :name, :gender
  validates_presence_of :orientation_date, :unless => :date_of_birth
end
