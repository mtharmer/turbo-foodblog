# frozen_string_literal: true

class RecipeCategory < ApplicationRecord
  validates :name, presence: true, uniqueness: true
  has_many :recipes, dependent: :nullify

  def self.ransackable_attributes(_auth_object = nil)
    %w[id name created_at updated_at]
  end
end
