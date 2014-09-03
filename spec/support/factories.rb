FactoryGirl.define do
  factory :user do
    sequence(:email) { |n| "jim#{n}@example.com" }
    password 'pass'
  end
end
