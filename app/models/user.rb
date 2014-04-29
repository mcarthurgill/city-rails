class User < ActiveRecord::Base
  attr_accessible :city_id, :name, :password, :phone

  validates_presence_of :name, :password, :phone
  validates_uniqueness_of :phone

  belongs_to :city
  has_many :invitations

  has_many :friendships
  has_many :friends, :through => :friendships  
  has_many :inverse_friendships, :class_name => "Friendship", :foreign_key => "friend_id"
  has_many :inverse_friends, :through => :inverse_friendships, :source => :user

  has_many :contacts
  has_many :connections, :through => :contacts, :class_name => 'User', :foreign_key => 'phone_number'

  # def all_friends
  #   all_friends = []
  #   all_friends << self.friends
  #   all_friends << self.inverse_friends
  #   return all_friends.flatten
  # end

  def friends_in_my_city
    # return self.all_friends.select { |friend| friend.city_id == self.city_id }
    return self.friends_in_city(self.city)
  end

  def friends_in_city city
    return self.connections.select { |friend| friend.city_id == city.id }
  end

  def create_contacts contacts_array
    contacts_array.each do |contact|
      c = Contact.find_or_create_by_phone_number_and_user_id(format_phone(contact), user.id)
      puts c
    end
  end

end
