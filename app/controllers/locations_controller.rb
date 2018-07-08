class LocationsController < ApplicationController
  before_action :set_location, only: [:show, :update]
  
  def index
    @locations = Location.all
    json_response(@locations)
  end

  def create
    @location = Location.create!(location_params)
    json_response(@location, :created)
  end

  def show
    json_response(@location)
  end

  def update
    @location.update!(location_params)
    head :no_content
  end

  private

  def set_location
    @location = Location.find(params[:id])
  end

  def location_params
    params.permit(:name)
  end
end
