class Venue < ActiveRecord::Base
  attr_accessible :city_id, :venue_name, :venue_type

  validates_presence_of :city_id, :venue_name, :venue_type

  belongs_to :city
end
