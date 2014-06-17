class Venue < ActiveRecord::Base
  attr_accessible :city_id, :venue_name, :venue_type, :json_info, :user_id, :api_id, :user_id_override

  serialize :json_info

  belongs_to :city
  belongs_to :user

  def as_json(options)
    super(:methods => [:json, :friends])
  end

  def json
    return self.json_info.to_json.to_s
  end

  def friends
    frs = []
    User.find_by_id(self.friends_user_id).connections.includes(:venues).each do |f|
      if f.id != self.friends_user_id && f.venues.find_by_api_id(self.api_id)
        frs << f
      end
    end
    return frs
  end

  def friends_user_id
    return self.user_id_override ? self.user_id_override : self.user_id
  end

end
