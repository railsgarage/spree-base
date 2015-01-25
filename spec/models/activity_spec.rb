require 'spec_helper'

describe Activity do
  describe 'instance methods' do

    before :each do
      @activity = FactoryGirl.create(:activity)
    end

    describe 'days_array' do
      it 'assigns days string from array' do
        @activity.days_array = ['Wednesday', 'Friday']
        expect(@activity.days).to eq 'Wednesday, Friday'
      end

      it 'returns days array from string' do
        expect(@activity.days_array).to eq ['Monday', 'Tuesday']
      end
    end

    describe 'register' do
      it 'registers a user with no activity fees' do
        reg = @activity.register({})
        expect(reg[:success]).to eq true
      end
    end

    describe ''

  end
end
