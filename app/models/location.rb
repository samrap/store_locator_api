class Location < ApplicationRecord
  validates :name, presence: true
  geocoded_by :full_address

  # We only need to geocode 
  after_validation :geocode, if: ->(obj) {
    obj.address.present? and obj.address_changed?
  }

  def full_address
    [address, address_2, city, state, zip].compact.join(', ')
  end
end
