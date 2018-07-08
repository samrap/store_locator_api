class LocationsController < ApplicationController
  def index
    @locations = Location.all

    render json: @locations, status: 200
  end
end
