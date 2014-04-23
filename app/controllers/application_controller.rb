class ApplicationController < ActionController::Base
  protect_from_forgery

  # before_filter :verify_token

  private

  def verify_token
    redirect_to :status => 404 unless params[:sk] == "foeiuh9q28734gfa9w8hfg92830rq892g0oaw8hf"  
  end

  def encrypt_password(string)
    return Digest::SHA1.hexdigest("jk12_~!la#{string}supYYYm03_!_3")
  end

  def format_phone(number)
    strip_whitespace!(number)
    strip_non_numeric!(number)
    strip_down_to_ten_digits!(number)
    return number
  end

  def strip_whitespace!(number)
    number.gsub!(/\s+/, "")
  end

  def strip_non_numeric!(number)
    number.gsub!(/\D/, '')
  end

  def strip_down_to_ten_digits!(number)
    while number.length > 10
      number.slice!(0...1)
    end
  end
end
