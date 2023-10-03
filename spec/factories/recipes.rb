FactoryBot.define do
  factory :recipe do
    title { Faker::Food.unique.dish }
    ingredients { Faker::Food.ingredient }
    instructions { Faker::Food.description }
    association :user, factory: :user, strategy: :create
  end
end
