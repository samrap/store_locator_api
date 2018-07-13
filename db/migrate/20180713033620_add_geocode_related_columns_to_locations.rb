class AddGeocodeRelatedColumnsToLocations < ActiveRecord::Migration[5.2]
  def change
    # Add `address`, `address_2`, `city`, `state`, `zip`, `latitude`,
    # and `longitude`
    add_column :locations, :address, :string
    add_column :locations, :address_2, :string
    add_column :locations, :city, :string, limit: 64
    add_column :locations, :state, :string, limit: 2
    # Support full 9-digit zip code
    add_column :locations, :zip, :string, limit: 10
    add_column :locations, :latitude, :float
    add_column :locations, :longitude, :float
  end
end
