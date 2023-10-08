# frozen_string_literal: true

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)
if Rails.env.development?
  emails = []
  5.times { |i| emails << "sample#{i+1}@example.com" }

  recipes = []
  10.times { |i| recipes << "Recipe #{i+1}" }

  comments = []
  10.times { |i| comments << "Comment #{i+1}" }

  User.where(email: emails).destroy_all
  AdminUser.find_by(email: 'admin@example.com').destroy

  AdminUser.create!(email: 'admin@example.com', password: 'password',
                    password_confirmation: 'password')

  emails.each do |email|
    user = User.create!(email: email, password: 'somepass')
    recipes.each do |title|
      recipe = user.recipes.create!(title: title)
      comments.each do |comment|
        recipe.comments.create!(message: comment, user: user)
      end
    end
  end
end
