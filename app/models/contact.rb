class Contact < ActiveRecord::Base
  attr_accessible :name, :phone_number, :user_id

  validates_presence_of :name, :phone_number, :user_id

  belongs_to :user

end
