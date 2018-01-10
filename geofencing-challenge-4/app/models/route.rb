# == Schema Information
#
# Table name: routes
#
#  id      :integer          not null, primary key
#  carrier :string
#
class Route < ActiveRecord::Base
  has_many :stops, dependent: :destroy

  validates :carrier, presence: true
end
