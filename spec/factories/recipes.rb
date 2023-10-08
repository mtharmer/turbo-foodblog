# frozen_string_literal: true

FactoryBot.define do
  factory :recipe do
    title { Faker::Food.unique.dish }
    ingredients { Faker::Food.ingredient }
    instructions { Faker::Food.description }
    recipe_category { nil }
    user factory: %i[user], strategy: :create
  end
end
