class PushNotification < ActiveRecord::Base
  include ActionView::Helpers::TextHelper

  attr_accessible :device_token_id, :message, :push_notification_type, :status

  belongs_to :device_token

  # def send_notification
  #   #determine what type of notification, and send
  #   if self.device_token.ios_device_token && self.device_token.ios_device_token.length > 0
  #     #send ios
  #     send_ios_notification
  #   end
  #   if self.device_token.android_device_token && self.device_token.android_device_token.length > 0
  #       #send android
  #       send_android_notification
  #   end
  # end


  def send_ios_notification

    self.message = truncate(self.message, length: 160)
    APNS.host = "gateway.sandbox.push.apple.com"
    APNS.pem = File.join(Rails.root, "ck.pem")
    APNS.port = 2195 
    APNS.send_notification(self.device_token.ios_device_token, :alert => self.message, :badge => 1)

  end

  def self.create_with_device_token_and_message(dt, m)
    PushNotification.create(:device_token_id => dt.id, :message => m)
  end

  # def send_android_notification
  #   n = Rapns::Gcm::Notification.new
  #   n.app = Rapns::Gcm::App.find_by_name(ENV['ANDROID_RAPNS_ENVIRONMENT'])
  #   n.registration_ids = [self.device_token.android_device_token]
  #   n.data = {:message => self.message}
  #   n.save!
  # end


end
