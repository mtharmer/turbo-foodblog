# frozen_string_literal: true

require 'rails_helper'

RSpec.describe RecipeCategory, type: :model do
  it 'allows a category to be created' do
    expect { create(:recipe_category) }.to change(described_class, :count).by(1)
  end

  context 'associations' do
    it { is_expected.to have_many(:recipes).dependent(:nullify) }
  end

  context 'validations' do
    subject { build(:recipe_category) }

    it { is_expected.to validate_presence_of(:name) }
    it { is_expected.to validate_uniqueness_of(:name) }
  end

  it 'does not delete recipes when a category is deleted' do
    category = create(:recipe_category)
    create(:recipe, recipe_category: category)
    expect { category.destroy }.not_to change(Recipe, :count)
  end
end
