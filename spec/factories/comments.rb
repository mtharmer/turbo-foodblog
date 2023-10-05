FactoryBot.define do
  factory :comment do
    message { Faker::GreekPhilosphers.quote }
    user factory: %i[user], strategy: :create
    recipe factory: %i[recipe], strategy: :create
  end
end
