require 'rails_helper'

RSpec.describe 'Locations API', type: :request do
  let!(:locations) { create_list(:location, 5) }
  let(:location_id) { locations.first.id }

  # Stub out requests so we aren't hitting the API
  GeocoderHelper.stub

  describe 'GET /locations' do
    before { get '/locations' }

    it 'returns status code 200' do
      expect(response).to have_http_status(200)
    end

    it 'returns the locations' do
      expect(response.body).to eq(locations.to_json)
    end
  end

  describe 'GET /locations search by address' do
    let!(:seattle_locations) do
      create_list(:seattle_location, 2)
    end

    before { get '/locations?search=721+Pine+St,+Seattle,+WA' }

    it 'returns locations near seattle' do
      # Ensure only two items are returned and that they are the geocoded
      # locations we just created.
      expect(response_json.length).to eq(2)
      expect(response_json[0]['name']).to match(seattle_locations[0]['name'])
      expect(response_json[1]['name']).to match(seattle_locations[1]['name'])
    end
  end

  describe 'GET /locations search by coordinates' do
    let!(:seattle_locations) { create_list(:seattle_location, 2) }

    before { get '/locations?search=47.6062,-122.3321' }

    it 'returns locations near seattle' do
      # Ensure only two items are returned and that they are the geocoded
      # locations we just created.
      expect(response_json.length).to eq(2)
      expect(response_json[0]['name']).to match(seattle_locations[0]['name'])
      expect(response_json[1]['name']).to match(seattle_locations[1]['name'])
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

    context 'when the record does not exist' do
      let(:location_id) { 47 }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns an error message' do
        expect(response.body).to match(/Couldn't find Location/)
      end
    end
  end

  describe 'POST /locations' do
    let(:valid_attributes) do
      {
        name: 'Stripe',
        address: '721 Pine St',
        city: 'Seattle',
        state: 'WA'
      }
    end

    context 'when the request is valid' do
      before { post '/locations', params: valid_attributes }

      it 'creates a location' do
        expect(response_json['name']).to eq(valid_attributes[:name])
      end

      it 'geocodes the location' do
        expect(response_json['latitude']).not_to be_nil
        expect(response_json['longitude']).not_to be_nil
      end

      it 'returns status code 201' do
        expect(response).to have_http_status(201)
      end
    end

    context 'when the request is invalid' do
      # The `name` field is required
      before { post '/locations' }

      it 'returns status code 422' do
        expect(response).to have_http_status(422)
      end

      it 'returns an error message' do
        expect(response.body).to match(/Name can't be blank/)
      end
    end
  end

  describe 'PATCH /locations/:id' do
    let(:valid_attributes) { { name: 'Stripe' } }

    context 'when the record exists' do
      before { patch "/locations/#{location_id}", params: valid_attributes }

      it 'updates the record' do
        expect(Location.find(location_id).name).to eq(valid_attributes[:name])
      end

      it 'returns status code 204' do
        expect(response).to have_http_status(204)
      end
    end

    context 'when the record does not exist' do
      before { put "/locations/47", params: valid_attributes }

      it 'returns status code 422' do
        expect(response).to have_http_status(404)
      end
    end
  end

  describe 'DELETE /locations/:id' do
    before { delete "/locations/#{location_id}" }

    it 'deletes the location' do
      expect(Location.exists?(location_id)).to be(false)
    end

    it 'returns status code 204' do
      expect(response).to have_http_status(204)
    end
  end
end