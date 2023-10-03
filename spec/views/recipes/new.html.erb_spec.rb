require 'rails_helper'

RSpec.describe "recipes/new", type: :view do
  before(:each) do
    assign(:recipe, build(:recipe))
  end

  it "renders new recipe form" do
    render

    assert_select "form[action=?][method=?]", recipes_path, "post" do

      assert_select "input[name=?]", "recipe[title]"

      assert_select "textarea[name=?]", "recipe[ingredients]"

      assert_select "textarea[name=?]", "recipe[instructions]"

      assert_select "input[name=?]", "recipe[user_id]"
    end
  end
end
