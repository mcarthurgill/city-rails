class City < ActiveRecord::Base
  attr_accessible :city_name, :latitude, :longitude

  validates_presence_of :city_name

  has_many :users
  has_many :venues

  def self.cities_as_hash
    #returns {"Montgomery" => [], "Nashville" => [],...}
    cities_hash = {}
    City.all.each do |c|
      cities_hash[c.city_name] = []
    end
    return cities_hash
  end
end
