require 'rails_helper'

RSpec.describe "recipes/index", type: :view do
  before(:each) do
    assign(:recipes, create_list(:recipe, 2, {title: "Title", ingredients: "Ingredients", instructions: "Instructions"}))
  end

  it "renders a list of recipes" do
    render
    cell_selector = Rails::VERSION::STRING >= '7' ? 'div>p' : 'tr>td'
    assert_select cell_selector, text: Regexp.new("Title".to_s), count: 2
    assert_select cell_selector, text: Regexp.new("Ingredients".to_s), count: 2
    assert_select cell_selector, text: Regexp.new("Instructions".to_s), count: 2
  end
end
