# frozen_string_literal: true

class Recipe < ApplicationRecord
  include ImageUploader::Attachment(:image)

  belongs_to :user
  has_many :comments, dependent: :destroy
  belongs_to :recipe_category, optional: true

  validates :title, presence: true, uniqueness: { scope: :user_id }
end
