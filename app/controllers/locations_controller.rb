class LocationsController < ApplicationController
  before_action :set_location, only: [:show, :update, :destroy]
  
  def index
    if (params[:search])
      @locations = Location.near(params[:search])
    else
      @locations = Location.all
    end

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

  def destroy
    @location.destroy
    head :no_content
  end

  private

  def set_location
    @location = Location.find(params[:id])
  end

  def location_params
    params.permit(
      :name,
      :address,
      :address_2,
      :city,
      :state,
      :zip,
      :latitude,
      :longitude
    )
  end
end
