# == Schema Information
#
# Table name: routes
#
#  id      :integer          not null, primary key
#  carrier :string
#

FactoryBot.define do
  factory :route do
    carrier 'YRC'
  end
end
