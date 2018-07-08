require 'rails_helper'
require 'pp'

RSpec.describe 'Locations API', type: :request do
  let!(:locations) { create_list(:location, 5) }

  describe 'GET /locations' do
    before { get '/locations' }

    it 'returns status code 200' do
      expect(response).to have_http_status(200)
    end

    it 'returns the locations' do
      expect(response.body).to eq(locations.to_json)
    end
  end
end