class Contact < ActiveRecord::Base
  attr_accessible :name, :phone_number, :user_id
end
