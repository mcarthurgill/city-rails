class User < ActiveRecord::Base
  attr_accessible :city_id, :name, :password, :phone

  validates_presence_of :name, :password, :phone
  validates_uniqueness_of :phone

  belongs_to :city
  has_many :contacts
  has_many :invitations

  has_many :friendships
  has_many :friends, :through => :friendships  
  has_many :inverse_friendships, :class_name => "Friendship", :foreign_key => "friend_id"
  has_many :inverse_friends, :through => :inverse_friendships, :source => :user

  def all_friends
    all_friends = []
    all_friends << self.friends
    all_friends << self.inverse_friends
    return all_friends.flatten
  end

  def friends_in_my_city
    return self.all_friends.select { |friend| friend.city_id == self.city_id }
  end

  def create_contacts
    #create all the contacts for this motha fuckin user
    #see if the new contact's phone number is the phone number of a user in our system. 
    #if so, create a friendship between the self and the found user
  end
end
