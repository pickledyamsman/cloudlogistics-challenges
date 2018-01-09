# == Schema Information
#
# Table name: stops
#
#  id       :integer          not null, primary key
#  address  :string
#  route_id :integer
#
class Stop < ActiveRecord::Base
  belongs_to :route

  validates :address, presence: true
end
