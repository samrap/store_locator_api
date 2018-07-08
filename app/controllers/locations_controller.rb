class LocationsController < ApplicationController
  def index
    @locations = Location.all
    json_response(@locations)
  end

  def show
    @location = Location.find(params['id'])
    json_response(@location)
  end
end
