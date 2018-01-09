require 'rails_helper'

RSpec.describe Stop, type: :model do
  let(:stop) { build(:stop) }

  describe 'validations' do
    context 'valid' do
      it 'has a valid factory' do
        expect(stop).to be_valid
      end

      it 'has a valid address' do
        expect(stop.address).to eq('West Palm Beach')
      end
    end

    context 'invalid' do
      it 'without an address' do
        stop.address = nil
        expect(stop).to_not be_valid
      end
    end
  end
end
