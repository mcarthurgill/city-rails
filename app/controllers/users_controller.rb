class UsersController < ApplicationController
  # GET /users/1
  # GET /users/1.json
  def show
    @user = User.find_by_id_and_password(params[:id], params[:user][:password])
    
    respond_to do |format|
      if @user
        format.json { render json: @user.as_json }
      else
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # POST /users
  # POST /users.json
  def create
    phone_number = format_phone(params[:user][:phone])
    @user = User.find_or_initialize_by_phone(phone_number)

    respond_to do |format|
      if @user.new_record?
        @user.password = encrypt_password(params[:user][:password])
        @user.name = params[:user][:name].strip
        if phone_number.length > 0 && @user.password.length > 0 && @user.name.length > 0 && @user.save
          format.json { render json: @user.as_json }
        else
          format.json { render json: { :user_error => "Not all the fields were filled out!" } }
        end
      else
        if encrypt_password(params[:user][:password]) == @user.password
          format.json { render json: @user.as_json }
        else
          format.json { render json: { :user_error => "The password did not match the one on file." } }
        end
      end
    end
  end

  # PUT /users/1
  # PUT /users/1.json
  def update
    @user = User.find_by_id_and_password(params[:id], params[:user][:password])
    city_id = @user.city_id

    respond_to do |format|
      if @user && @user.update_attributes(params[:user])
        new_city_id = @user.city_id
        if city_id != new_city_id
          @user.notify_friends_of_location_change
        end
        format.json { render json: @user.as_json }
      else
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    @user = User.find(params[:id])
    @user.destroy

    respond_to do |format|
      format.html { redirect_to users_url }
      format.json { head :no_content }
    end
  end

  def all_friends
    user = User.find(params[:id])

    respond_to do |format|
      if user 
        format.json { render json: user.all_friends.as_json }
      else
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  def friends_by_city
    user = User.find(params[:id])
    friends_grouped_by_city = user.friends_by_city if user

    respond_to do |format|
      if user
        format.json { render json: friends_grouped_by_city.as_json }
      else
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  def friends_in_my_city
    user = User.find(params[:id])

    respond_to do |format|
      if user
        format.json { render json: user.friends_in_my_city.as_json }
      else
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  def friends_in_city
    user = User.find(params[:id])

    respond_to do |format|
      if user
        format.json { render json: user.friends_in_city(City.find_by_id(params[:city_id])).as_json }
      else
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  def create_contacts
    #create contacts for this user
    user = User.find_by_id(params[:id])

    user.delay.create_contacts(params[:contacts])

    respond_to do |format|
      if user
        format.json { render json: user.as_json(:methods => []) }
      else
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end

  end

  def venues
    user = User.find_by_id(params[:id])
    
    respond_to do |format|
      if user
        format.json { render json: user.favorites(0).as_json({}) }
      else
        format.json { render json: user.errors, status: :unprocessable_entity }
      end
    end

  end

  def reset_password
    user = User.find_by_phone(format_phone(params[:phone]))
    new_password_number = 1000 + rand(10000)
    new_password = "#{new_password_number}"

    user.update_attribute(:password, encrypt_password(new_password))

    message = "Your new Zround passcode: #{new_password}"
    invite_msg = Kptwilio.new(user.phone, "+12052676367", message)
    invite_msg.send

    respond_to do |format|
      format.json { render json: user }
    end
  end

  def friend_favorites_for_city
    user = User.find(params[:id])
    city = City.find(params[:city_id])
    recs = user.friends_recommendations(city)

    respond_to do |format|
      format.json { render json: recs }
    end
  end

  def privacy_policy
  end

  def block_user
    user = User.find(params[:id])
    block_user = User.find(params[:block_id])

    contacts_to_block = block_user.contacts.where("phone_number = ?", user.phone)
    contacts_to_block.each do |c|
      c.blocked = !c.blocked
      c.save!
    end

    respond_to do |format|
      format.json { render json: contacts_to_block }
    end
  end
end
