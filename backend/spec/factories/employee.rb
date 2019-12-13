FactoryBot.define do
  factory :employee do
    name { Faker::Name.name }
    salary { Faker::Number.decimal }
    position
  end
end
