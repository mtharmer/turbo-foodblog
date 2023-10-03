require 'rails_helper'

RSpec.describe "recipes/show", type: :view do
  before(:each) do
    assign(:recipe, create(:recipe,
      title: "Title",
      ingredients: "Ingredients",
      instructions: "Instructions"
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Title/)
    expect(rendered).to match(/Ingredients/)
    expect(rendered).to match(/Instructions/)
  end
end
