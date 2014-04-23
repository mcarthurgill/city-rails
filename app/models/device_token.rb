class DeviceToken < ActiveRecord::Base
  attr_accessible :android_device_token, :ios_device_token, :user_id, :environment

  belongs_to :user

  has_many :push_notifications
end
