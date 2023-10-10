# frozen_string_literal: true

RSpec.describe 'recipe_categories/show', type: :view do
  before do
    assign(:recipe_category, build(:recipe_category, name: 'Good food'))
    render
  end

  it 'renders the title' do
    assert_select 'div>h1', text: /good food/i
  end

  it 'renders a recipes section' do
    assert_select 'div>h2', text: /recipes/i
  end
end
