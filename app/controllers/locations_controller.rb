class LocationsController < ApplicationController
  before_action :set_location, only: [:show]
  
  def index
    @locations = Location.all
    json_response(@locations)
  end

  def show
    json_response(@location)
  end

  private

  def set_location
    @location = Location.find(params[:id])
  end
end
