require 'rails_helper'
require 'pp'

RSpec.describe 'Locations API', type: :request do
  let!(:locations) { create_list(:location, 5) }
  let(:location_id) { locations.first.id }

  describe 'GET /locations' do
    before { get '/locations' }

    it 'returns status code 200' do
      expect(response).to have_http_status(200)
    end

    it 'returns the locations' do
      expect(response.body).to eq(locations.to_json)
    end
  end

  describe 'GET /locations/:id' do
    before { get "/locations/#{location_id}" }

    context 'when the record exists' do
      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end

      it 'returns the location' do
        expect(response_json).not_to be_empty
        expect(response_json['id']).to eq(location_id)
      end
    end
  end
end