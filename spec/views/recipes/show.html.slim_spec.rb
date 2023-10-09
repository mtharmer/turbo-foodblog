# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'recipes/show', type: :view do
  before do
    assign(:recipe, build(:recipe,
                         title: 'Title',
                         ingredients: 'Ingredients',
                         instructions: 'Instructions'))
    render
  end

  it 'renders attributes in <p>' do
    expect(rendered).to match(/Title/)
    expect(rendered).to match(/Ingredients/)
    expect(rendered).to match(/Instructions/)
  end
end
