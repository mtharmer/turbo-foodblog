
RSpec.describe 'recipe_categories/index', type: :view do
  before do
    assign(:recipe_categories, build_list(:recipe_category, 2, name: 'Good food'))
    render
  end

  it 'renders the title' do
    assert_select 'div>h1', text: /recipes by category/i
  end

  it 'renders a list of categories' do
    assert_select 'h3#card-title', text: /good food/i, count: 2
  end

  it 'renders counts of the recipes' do
    assert_select 'p#recipe-count', count: 2
  end

  it 'renders links for each category' do
    assert_select 'p#recipe-link', count: 2
  end
end
