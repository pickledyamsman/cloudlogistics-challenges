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

      it 'has a valid destination' do
        expect(route.destination).to eq('Orlando')
      end

      it 'has a valid origin' do
        expect(route.origin).to eq('Ft Lauderdale')
      end
    end

    context 'invalid' do
      it 'without a carrier' do
        route.carrier = nil
        expect(route).to_not be_valid
      end

      it 'without a destination' do
        route.destination = nil
        expect(route).to_not be_valid
      end

      it 'without an origin' do
        route.origin = nil
        expect(route).to_not be_valid
      end
    end
  end
end
