FactoryBot.define do
  factory :user do
    name { Faker::Name.name  }
    email  { Faker::Internet.email }
    total_orders_pln { rand(0..100000000) }
    total_orders_eur { 0 }
  end
end