class User < ActiveRecord::Base
  attr_accessible :city_id, :name, :password, :phone
end
