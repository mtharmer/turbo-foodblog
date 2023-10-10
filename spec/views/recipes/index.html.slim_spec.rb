# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'recipes/index', type: :view do
  before do
    assign(:recipes,
           build_list(:recipe, 2, { title: 'Title', ingredients: 'Ingredients', instructions: 'Instructions' }))
    render
  end

  it 'renders titles' do
    assert_select 'div.card-title', text: Regexp.new('Title'.to_s), count: 2
  end

  it 'renders a list of recipes' do
    assert_select 'div>p', text: Regexp.new('Author'.to_s), count: 2
  end
end
