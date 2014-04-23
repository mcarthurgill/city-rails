class Contact < ActiveRecord::Base
  attr_accessible :name, :phone_number, :user_id

  validates_presence_of :name, :phone_number, :user_id

  belongs_to :user

  # scope :in_same_city_as_user, lambda { |user_id| where("user_id = ?", user_id).order('id DESC').limit(20) }

end
