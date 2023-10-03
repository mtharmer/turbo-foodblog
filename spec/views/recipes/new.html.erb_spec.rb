# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'recipes/new', type: :view do
  before do
    assign(:recipe, build(:recipe))
  end

  describe 'renders new recipe form' do
    before do
      render
    end

    it 'shows the title' do
      assert_select 'form[action=?][method=?]', recipes_path, 'post' do
        assert_select 'input[name=?]', 'recipe[title]'
      end
    end

    it 'shows the ingredients' do
      assert_select 'form[action=?][method=?]', recipes_path, 'post' do
        assert_select 'textarea[name=?]', 'recipe[ingredients]'
      end
    end

    it 'shows the instructions' do
      assert_select 'form[action=?][method=?]', recipes_path, 'post' do
        assert_select 'textarea[name=?]', 'recipe[instructions]'
      end
    end

    it 'shows the user' do
      assert_select 'form[action=?][method=?]', recipes_path, 'post' do
        assert_select 'input[name=?]', 'recipe[user_id]'
      end
    end
  end
end
