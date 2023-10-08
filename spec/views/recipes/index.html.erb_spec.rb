# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'recipes/index', type: :view do
  before do
    assign(:recipes,
           create_list(:recipe, 2, { title: 'Title', ingredients: 'Ingredients', instructions: 'Instructions' }))
  end

  it 'renders titles' do
    render
    assert_select 'div>h3', text: Regexp.new('Title'.to_s), count: 2
  end

  it 'renders a list of recipes' do
    render
    assert_select 'div>p', text: Regexp.new('Author'.to_s), count: 2
  end
end
