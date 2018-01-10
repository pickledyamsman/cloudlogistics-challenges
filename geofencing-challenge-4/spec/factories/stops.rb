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

FactoryBot.define do
  factory :stop do
    address '222 Lakeviw Ave'
    city 'West Palm Beach'
    state 'FL'
    zipcode '33401'
    country 'USA'
    longitude 26.705673
    latitude -80.050996
    stop_type 'Origin'
    route
  end
end
