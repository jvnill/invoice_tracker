FactoryGirl.define do
  factory :client do
    sequence(:name) { |n| "Client #{n}" }
    sequence(:contact_person) { |n| "Contact#{n} Person" }
  end

  factory :invoice do
    association :project
    association :user
    currency '$'
    page_size 'A4'
    date Time.zone.today
    sequence(:number) { |n| n }

    after(:build) do |invoice|
      if invoice.invoice_items.empty?
        invoice.invoice_items = [build(:invoice_item, invoice: invoice)]
      end
    end
  end

  factory :invoice_item do
    association :invoice
    sequence(:name) { |n| "Invoice Item #{n}" }
    unit_amount 10
    quantity 1
  end

  factory :project do
    association :client
    sequence(:name) { |n| "Project #{n}" }
  end

  factory :user do
    sequence(:email) { |n| "jim#{n}@example.com" }
    password 'pass'
  end

  factory :user_option do
    association :user
    name 'password_token'
    value 'test'
  end

  factory :user_detail do
    association :user
  end
end
