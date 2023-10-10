# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Recipe, type: :model do
  it 'allows a recipe to be created' do
    expect { create(:recipe) }.to change(described_class, :count).by 1
  end

  context 'associations' do
    subject { build(:recipe) }

    it { is_expected.to have_many(:comments) }
    it { is_expected.to belong_to(:user) }
  end

  context 'validations' do
    subject { build(:recipe) }

    it { is_expected.to validate_presence_of(:title) }
    it { is_expected.to validate_uniqueness_of(:title).scoped_to(:user_id) }

    it 'allows same titles for different users' do
      recipe = create(:recipe)
      expect { create(:recipe, title: recipe.title) }.to change(described_class, :count).by 1
    end
  end
end
