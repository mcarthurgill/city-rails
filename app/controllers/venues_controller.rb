class VenuesController < ApplicationController
  # GET /venues
  # GET /venues.json
  def index
    @venues = Venue.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @venues }
    end
  end

  # GET /venues/1
  # GET /venues/1.json
  def show
    @venue = Venue.find_by_api_id_and_user_id(params[:id], params[:user_id])
    if !@venue
      @venue = Venue.find_by_api_id(params[:id])
      if @venue
        @venue.user_id_override = params[:user_id]
      end
    end

    respond_to do |format|
      format.json { render json: @venue }
    end
  end

  # GET /venues/new
  # GET /venues/new.json
  def new
    @venue = Venue.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @venue }
    end
  end

  # GET /venues/1/edit
  def edit
    @venue = Venue.find(params[:id])
  end

  # POST /venues
  # POST /venues.json
  def create
    @venue = Venue.find_by_api_id_and_user_id(params[:venue][:api_id], params[:venue][:user_id])
    if !@venue
      @venue = Venue.new(params[:venue])
    else
      @venue.updated_at = Time.now
    end

    respond_to do |format|
      if @venue.save
        format.html { redirect_to @venue, notice: 'Venue was successfully created.' }
        format.json { render json: @venue, status: :created, location: @venue }
      else
        format.html { render action: "new" }
        format.json { render json: @venue.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /venues/1
  # PUT /venues/1.json
  def update
    @venue = Venue.find(params[:id])

    respond_to do |format|
      if @venue.update_attributes(params[:venue])
        format.html { redirect_to @venue, notice: 'Venue was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @venue.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /venues/1
  # DELETE /venues/1.json
  def destroy
    @venue = Venue.find(params[:id])
    @venue.destroy

    respond_to do |format|
      format.html { redirect_to venues_url }
      format.json { head :no_content }
    end
  end
end
