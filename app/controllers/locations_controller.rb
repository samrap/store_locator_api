class LocationsController < ApplicationController
  before_action :set_location, only: [:show, :update, :destroy]
  before_action :set_search_query, only: :index
  
  def index
    if (@search_query)
      @locations = Location.near(@search_query)
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

  # Parse a potential search query within the request params.
  #
  # Two types of search queries are currently permitted:
  #   1. Coordinates set. This is useful for scenarios where the client has
  #      access to the user's location in coordinates and avoids the
  #      need to hit an API service for geocoding an address.
  #   2. Address query. This will require a request to a geocoding API in order
  #      to resolve the query's coordinates. This is handled by the geocoder.
  def set_search_query
    if (params[:search] === nil)
      @search_query = nil
    elsif (params[:search].match(/^[-+]?([1-8]?\d(\.\d+)?|90(\.0+)?),\s*[-+]?(180(\.0+)?|((1[0-7]\d)|([1-9]?\d))(\.\d+)?)$/))
      @search_query = params[:search].delete(' ').split(',')
    else (params[:search])
      @search_query = params[:search]
    end
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
