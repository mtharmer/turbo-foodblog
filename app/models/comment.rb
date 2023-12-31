# frozen_string_literal: true

class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :recipe

  validates :message, presence: true, allow_blank: false
end
