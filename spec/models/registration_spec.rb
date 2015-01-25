require 'spec_helper'

describe Registration do
  describe 'instance methods' do

    before :each do
      @account = FactoryGirl.create(:account)
      @user = FactoryGirl.create(:user, account_id: @account.id)
      @activity = FactoryGirl.create(:activity, account_id: @account.id)
      @fee = FactoryGirl.create(:fee, activity_id: @activity.id)
      @registration = FactoryGirl.build(:registration, activity_id: @activity.id, user_id: @user.id)
    end

    describe 'save' do
      it 'should set group name to users last name if no group name' do
        @registration.save
        expect(@registration.group_name).to eq(@user.last_name)
      end

      it 'should save registration record' do
        @registration.save
        expect(@registration.id).not_to be_nil
      end
    end

    describe 'process' do
      it 'should set charge_id and paid attributes' do
        VCR.use_cassette 'stripe_charge' do
          @registration.process
        end
        expect(@registration.charge_id).not_to be_nil
        expect(@registration.paid).not_to be_nil
      end
    end

  end
end
