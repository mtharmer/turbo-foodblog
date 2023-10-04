# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Recipe, type: :model do
  it 'allows a recipe to be created' do
    expect { create(:recipe) }.not_to raise_error
  end

  it 'persists a created recipe' do
    create(:recipe)
    expect(described_class.first).not_to be_nil
  end

  context 'with validation' do
    it 'requires a title' do
      expect { create(:recipe, title: nil) }.to raise_error(
        ActiveRecord::RecordInvalid,
        "Validation failed: Title can't be blank"
      )
    end

    it 'requires unique titles per user' do
      recipe = create(:recipe)
      expect { create(:recipe, title: recipe.title, user: recipe.user) }.to raise_error(
        ActiveRecord::RecordInvalid,
        'Validation failed: Title has already been taken'
      )
    end

    it 'allows same titles for different users' do
      user1 = create(:user)
      user2 = create(:user)
      recipe = create(:recipe, user: user1)
      expect { create(:recipe, title: recipe.title, user: user2) }.not_to raise_error
    end
  end
end
