FactoryGirl.define do
  factory :activity do
    name 'Mens Softball'
    start_date Date.today + 1.month
    end_date Date.today + 2.months
    registration_start Date.today
    registration_end Date.today + 1.month
    days 'Monday,Tuesday'

    trait :has_fees do
      fee
    end
  end
end
