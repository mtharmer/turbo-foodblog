# frozen_string_literal: true

class Recipe < ApplicationRecord
  belongs_to :user

  validates :title, presence: true, uniqueness: { scope: :user_id }
end
