FactoryGirl.define do
  factory :user do
    email 'austin@yankees.com'
    password 'password'
    first_name 'Austin'
    last_name 'Romine'
    city 'Bronx'
    state 'New York'
    zip '44444'
    phone '0000000000'
  end
end
