# frozen_string_literal: true

FactoryBot.define do
  factory :recipe_category do
    name { Faker::Food.unique.ethnic_category }
  end
end
