module GeocoderHelper
  # Stup out the Geocoder so we aren't making real requests
  # See: https://github.com/alexreisner/geocoder/issues/1258 for why we need to
  # define both the `coordinates` and `latitude`, `longitude`.
  def self.stub
    Geocoder.configure(lookup: :test)

    Geocoder::Lookup::Test.set_default_stub([
      {
        'coordinates'  => [33.6595, -117.9988],
        'latitude'     => 33.6595,
        'longitude'    => -117.9988,
        'address'      => 'Huntington Beach, CA, USA',
        'state'        => 'California',
        'state_code'   => 'CA',
        'country'      => 'United States',
        'country_code' => 'US'
      }
    ])

    Geocoder::Lookup::Test.add_stub('721 Pine St, Seattle, WA', [
      {
        'coordinates'  => [47.6062, -122.3321],
        'latitude'     => 47.6062,
        'longitude'    => -122.3321,
        'address'      => '721 Pine St, Seattle, WA, USA',
        'state'        => 'Washington',
        'state_code'   => 'WA',
        'country'      => 'United States',
        'country_code' => 'US'
      }
    ])
  end
end