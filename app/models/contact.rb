class Contact < ActiveRecord::Base
  attr_accessible :name, :phone_number, :user_id

  validates_presence_of :phone_number, :user_id

  belongs_to :user
  belongs_to :connection, :class_name => 'User', :foreign_key => 'phone_number', :primary_key => 'phone'

  scope :unblocked, ->{ where('blocked = ?', false) }
end
