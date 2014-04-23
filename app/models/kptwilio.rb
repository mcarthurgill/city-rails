class Kptwilio < ActiveRecord::Base
  attr_accessible :body, :from_number, :to_number

  def initialize(to_number, from_number, body)
     @to_number = to_number
     @from_number = determine_from_number(to_number)
     @body = body
  end

  def send
    account_sid = "ACe141f2c62c8497956a83d0ffa61eca27"
    auth_token = "7afb7431bb3d199bf07605c5c72271dc" 

    @client = Twilio::REST::Client.new account_sid, auth_token
    @account = @client.account

    @message = @account.sms.messages.create({:body => @body, :to => append_plus_to_number(@to_number), :from => append_plus_to_number("12052676367")})
  end

  def append_plus_to_number(number)
    number.first == "+" ? number : number.prepend("+")
  end
end
