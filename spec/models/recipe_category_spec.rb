# frozen_string_literal: true

require 'rails_helper'

RSpec.describe RecipeCategory, type: :model do
  it 'allows a category to be created' do
    expect { create(:recipe_category) }.to change(described_class, :count).by(1)
  end

  it 'requires a name to be specified' do
    expect { create(:recipe_category, name: nil) }.to raise_error(
      ActiveRecord::RecordInvalid,
      "Validation failed: Name can't be blank"
    )
  end

  it 'requires unique names' do
    category = create(:recipe_category)
    expect { create(:recipe_category, name: category.name) }.to raise_error(
      ActiveRecord::RecordInvalid,
      'Validation failed: Name has already been taken'
    )
  end

  it 'associates with recipes' do
    category = create(:recipe_category)
    expect { create(:recipe, recipe_category: category) }.to change(category.recipes, :count).by(1)
  end

  it 'does not delete recipes when a category is deleted' do
    category = create(:recipe_category)
    create(:recipe, recipe_category: category)
    expect { category.destroy }.not_to change(Recipe, :count)
  end
end
