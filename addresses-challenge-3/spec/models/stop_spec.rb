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
#

require 'rails_helper'

RSpec.describe Stop, type: :model do
  let(:stop) { build(:stop) }

  describe 'validations' do
    context 'valid' do
      it 'has a valid factory' do
        expect(stop).to be_valid
      end
    end

    context 'invalid' do
      it 'without an address' do
        stop.address = nil
        expect(stop).to_not be_valid
      end

      it 'without a city' do
        stop.city = nil
        expect(stop).to_not be_valid
      end

      it 'without a state' do
        stop.state = nil
        expect(stop).to_not be_valid
      end

      it 'without a zipcode' do
        stop.zipcode = nil
        expect(stop).to_not be_valid
      end

      it 'without a stop_type' do
        stop.stop_type = nil
        expect(stop).to_not be_valid
      end
    end
  end

  describe 'geolocation' do
    before do
      @test_stop = Stop.create(address: '333 Las Olas Way',
                               city: 'Ft Lauderdale',
                               state: 'FL.',
                               zipcode: 333_01,
                               stop_type: 'Origin')
    end

    it 'generates latitude after validation' do
      expect(@test_stop.latitude).to eq(26.118305)
    end

    it 'generates longitude after validation' do
      expect(@test_stop.longitude).to eq(-80.141763)
    end
  end
end
