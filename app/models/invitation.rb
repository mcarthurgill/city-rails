class Invitation < ActiveRecord::Base
  attr_accessible :invitee_name, :phone_number, :status, :user_id

  validates_presence_of :phone_number, :user_id

  belongs_to :user

  def update_status
    self.status = "accepted"
    self.save!
  end

  def send_invite
    user = User.where("phone = ?", phone_number).first

    if user.nil?
      message = "#{self.user.name} invited you to join Zround. Here's the iPhone download link: https://appsto.re/us/2MAt2.i"
      invite_msg = Kptwilio.new(self.phone_number, "+12052676367", message)
      invite_msg.send
    end 
  end
end
