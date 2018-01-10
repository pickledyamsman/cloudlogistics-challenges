# == Schema Information
#
# Table name: routes
#
#  id      :integer          not null, primary key
#  carrier :string
#

require 'rails_helper'

RSpec.describe Route, type: :model do
  let(:route) { build(:route) }

  describe 'validations' do
    context 'valid' do
      it 'has a valid factory' do
        expect(route).to be_valid
      end

      it 'has a valid carrier' do
        expect(route.carrier).to eq('YRC')
      end
    end

    context 'invalid' do
      it 'without a carrier' do
        route.carrier = nil
        expect(route).to_not be_valid
      end
    end
  end
end
