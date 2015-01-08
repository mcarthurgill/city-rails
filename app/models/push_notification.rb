class PushNotification < ActiveRecord::Base
  include ActionView::Helpers::TextHelper

  attr_accessible :device_token_id, :message, :push_notification_type, :status

  belongs_to :device_token

  def send_notification
    #determine what type of notification, and send
    if self.device_token.ios_device_token && self.device_token.ios_device_token.length > 0
      #send ios
      send_ios_notification
    end
    if self.device_token.android_device_token && self.device_token.android_device_token.length > 0
        #send android
        send_android_notification
    end
  end


  def send_ios_notification

    # self.message = truncate(self.message, length: 160)

    # n = Rapns::Apns::Notification.new
    # if self.device_token.environment == "production"
    #   n.app = Rapns::Apns::App.find_by_name(ENV['IOS_PRODUCTION_RAPNS_ENVIRONMENT'])
    # else
    #   n.app = Rapns::Apns::App.find_by_name(ENV['IOS_RAPNS_ENVIRONMENT'])
    # end
    # n.device_token = self.device_token.ios_device_token
    # n.alert = self.message
    # #if self.device_token.user
    # #  n.badge = self.device_token.user.all_unseen_posts(false).count
    # #else
    #   n.badge = 2
    # #end
    # n.attributes_for_device = { :post_id => self.post_id, :group_id => (self.post ? self.post.group_id : nil), :type => self.push_notification_type }
    # n.save!
    APNS.host = "gateway.sandbox.push.apple.com"
    APNS.pem = File.join(Rails.root, "ZroundDevelopment.pem")
    APNS.port = 2195 
    APNS.send_notification("0505aa4768f84595be2910f8908946813496307b2f1ff6ba59695e92eb931242", :alert => 'New Notification!', :badge => 1)

  end


  def send_android_notification
    n = Rapns::Gcm::Notification.new
    n.app = Rapns::Gcm::App.find_by_name(ENV['ANDROID_RAPNS_ENVIRONMENT'])
    n.registration_ids = [self.device_token.android_device_token]
    n.data = {:message => self.message}
    n.save!
  end


end
