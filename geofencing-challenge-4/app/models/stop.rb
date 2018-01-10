# == Schema Information
#
# Table name: stops
#
#  id        :integer          not null, primary key
#  address   :string
#  route_id  :integer
#  city      :string
#  state     :string
#  zipcode   :integer
#  country   :string
#  latitude  :decimal(10, 6)
#  longitude :decimal(10, 6)
#  stop_type :string
#  visited   :boolean          default(FALSE)
#
class Stop < ActiveRecord::Base
  belongs_to :route

  validates :address, presence: true
  validates :city, presence: true
  validates :state, presence: true
  validates :zipcode, presence: true
  validates :stop_type, presence: true

  # methods used by the geocoder gem
  geocoded_by :full_street_address
  after_validation :geocode, if: ->(obj) { obj.address.present? && obj.address_changed? }

  def full_street_address
    [address, city, state].join(', ')
  end
end
