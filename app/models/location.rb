class Location < ApplicationRecord
  validates :name, presence: true

  geocoded_by :full_address

  def full_address
    [address, address_2, city, state, zip].compact.join(', ')
  end
end
