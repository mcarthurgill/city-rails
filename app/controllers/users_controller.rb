class UsersController < ApplicationController
  # GET /users/1
  # GET /users/1.json
  def show
    # verify_authenticity ? nil : return

    @user = User.find_by_id_and_password(params[:id], params[:user][:password])
    
    respond_to do |format|
      if @user
        format.json { render json: { :user => @user.as_json } }
      else
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # POST /users
  # POST /users.json
  def create
    # verify_authenticity ? nil : return

    phone_number = format_phone(params[:user][:phone])
    @user = User.find_or_initialize_by_phone(phone_number)

    respond_to do |format|
      if @user.new_record?
        @user.password = encrypt_password(params[:user][:password])
        @user.name = params[:user][:name].strip
        if phone_number.length > 0 && @user.password.length > 0 && @user.name.length > 0 && @user.save
          format.json { render json: { :user => @user.as_json } }
        else
          format.json { render json: { :user_error => "filled forms" } }
        end
      else
        if encrypt_password(params[:user][:password]) == @user.password
          format.json { render json: { :user => @user.as_json } }
        else
          format.json { render json: { :user_error => "password match" } }
        end
      end
    end
  end

  # PUT /users/1
  # PUT /users/1.json
  def update
    # verify_authenticity ? nil : return

    @user = User.find_by_id_and_password(params[:id], params[:user][:password])

    respond_to do |format|
      if @user.update_attribute(:name, params[:user][:name].strip)
        format.json { render json: { :user => @user.as_json } }
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
    # verify_authenticity ? nil : return

    user = User.find(params[:id])

    respond_to do |format|
      if user 
        format.json { render json: { :user => user.as_json(:methods => [:all_friends]) } }
      else
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  def friends_in_my_city
    # verify_authenticity ? nil : return

    user = User.find(params[:id])

    respond_to do |format|
      if user && city
        format.json { render json: { :user => user.as_json(:methods => [:friends_in_my_city]) } }
      else
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  def create_contacts
    #create contacts for this user
  end
end
