FactoryGirl.define do
  factory :client do
    sequence(:name) { |n| "Client #{n}" }
    sequence(:contact_person) { |n| "Contact#{n} Person" }
  end

  factory :user do
    sequence(:email) { |n| "jim#{n}@example.com" }
    password 'pass'
  end
end
