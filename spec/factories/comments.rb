# frozen_string_literal: true

FactoryBot.define do
  factory :comment do
    message { Faker::Lorem.sentence }
    user factory: %i[user], strategy: :create
    recipe factory: %i[recipe], strategy: :create
  end
end
