require 'rails_helper'

RSpec.describe "recipes/edit", type: :view do
  let(:recipe) { create(:recipe) }

  before(:each) do
    assign(:recipe, recipe)
  end

  it "renders the edit recipe form" do
    render

    assert_select "form[action=?][method=?]", recipe_path(recipe), "post" do

      assert_select "input[name=?]", "recipe[title]"

      assert_select "textarea[name=?]", "recipe[ingredients]"

      assert_select "textarea[name=?]", "recipe[instructions]"

      assert_select "input[name=?]", "recipe[user_id]"
    end
  end
end
