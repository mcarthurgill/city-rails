class City < ActiveRecord::Base
  attr_accessible :city_name, :latitude, :longitude

  validates_presence_of :city_name

  has_many :users
  has_many :venues
end
