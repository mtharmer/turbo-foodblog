# frozen_string_literal: true

FactoryBot.define do
  factory :admin_user do
    email { Faker::Internet.unique.email }
    password { Faker::Internet.password }
  end
end
