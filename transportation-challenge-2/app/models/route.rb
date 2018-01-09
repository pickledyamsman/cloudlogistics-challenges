# == Schema Information
#
# Table name: routes
#
#  id          :integer          not null, primary key
#  carrier     :string
#  destination :string
#  origin      :string
#
class Route < ActiveRecord::Base
  has_many :stops, dependent: :destroy

  validates :carrier, presence: true
  validates :destination, presence: true
  validates :origin, presence: true
end
