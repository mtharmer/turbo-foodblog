# frozen_string_literal: true

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)
require 'factory_bot_rails'
require 'faker'
include FactoryBot::Syntax::Methods # rubocop:disable Style/MixinUsage

# Do not seed unless we're in development
if Rails.env.development?
  # Destroy all users except our test user
  User.where.not(email: 'user@example.com').destroy_all

  # Attempt to create our active admin user (ok if it fails)
  AdminUser.create(email: 'admin@example.com', password: 'password',
                   password_confirmation: 'password')

  # Attempt to create our active admin user (ok if it fails)
  User.create(email: 'user@example.com', password: 'somepass')

  # Find our test user
  user = User.find_by(email: 'user@example.com')

  # Create a list of 50 recipes, each of which will create its own new user
  recipes = create_list(:recipe, 50)

  # Iterate over the new list of recipes to create comments on all the recipes.
  recipes.each do |recipe|
    # Create a batch of comments from the receipe's user;
    FactoryBot.create_list(:comment, 10, recipe: recipe, user: recipe.user)
    # Our test user;
    FactoryBot.create_list(:comment, 5, recipe: recipe, user: user)
    # And from newly created users
    FactoryBot.create_list(:comment, 5, recipe: recipe)
  end
end
