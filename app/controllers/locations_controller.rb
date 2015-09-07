class LocationsController < ApplicationController

  # GET /locations
  # GET /locations.json
  def index
    @locations = Location.all
    @hash = Gmaps4rails.build_markers(@locations) do |location, marker|
      marker.json ({day: location.day})
      marker.title location.title
      marker.lat location.latitude
      marker.lng location.longitude
      marker.infowindow location.title + '<br>' + location.description
      marker.picture({
       'url' => view_context.image_path('map-marker.png'),
       'width' =>  32,
       'height' => 32})
    end

    respond_to do |format|
      format.html
      format.json
    end
  end

  # GET /locations/1
  # GET /locations/1.json
  def show
  end

  # GET /locations/new
  def new
    @location = Location.new
  end

  # GET /locations/1/edit
  def edit
    @location = Location.find(params[:id])
  end

  # POST /locations
  # POST /locations.json
  def create
    @locations = Location.all
    @location = Location.create(location_params)
    respond_to do |format|
      format.html
      format.js
    end
  end

  # PATCH/PUT /locations/1
  # PATCH/PUT /locations/1.json
  def update
    @locations = Location.all
    @location = Location.find(params[:id])
    respond_to do |format|
      if @location.update(location_params)
        format.html { redirect_to @location }
        format.js

      else
        format.html { render :edit }
        format.json { render json: @location.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /locations/1
  # DELETE /locations/1.json
  def destroy
    @locations = Location.all
    @location = Location.find(params[:id])
    @location.destroy
    respond_to do |format|
      format.html
      format.js
    end
  end

  def manage_locations
    @locations = Location.all
  end

  private

    # Never trust parameters from the scary internet, only allow the white list through.
    def location_params
      params.require(:location).permit(:latitude, :longitude, :address, :description, :title, :day)
    end
end
