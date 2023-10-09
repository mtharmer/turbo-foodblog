# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'recipes/edit', type: :view do
  let(:recipe) { create(:recipe) }
  let(:user) { create(:user) }

  before do
    assign(:recipe, recipe)
    sign_in user
  end

  describe 'renders the edit recipe form' do
    before do
      render
    end

    it 'shows the title' do
      assert_select 'form[action=?][method=?]', recipe_path(recipe), 'post' do
        assert_select 'input[name=?]', 'recipe[title]'
      end
    end

    it 'shows the ingredients' do
      assert_select 'form[action=?][method=?]', recipe_path(recipe), 'post' do
        assert_select 'textarea[name=?]', 'recipe[ingredients]'
      end
    end

    it 'shows the instructions' do
      assert_select 'form[action=?][method=?]', recipe_path(recipe), 'post' do
        assert_select 'textarea[name=?]', 'recipe[instructions]'
      end
    end

    it 'shows the user' do
      assert_select 'form[action=?][method=?]', recipe_path(recipe), 'post' do
        assert_select 'input[name=?]', 'recipe[user_id]'
      end
    end
  end
end
