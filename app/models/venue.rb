class Venue < ActiveRecord::Base
  attr_accessible :city_id, :venue_name, :venue_type, :json_info, :user_id

  belongs_to :city
  belongs_to :user
end
