# frozen_string_literal: true

require 'rails_helper'

RSpec.describe '/recipe_categories', type: :request do
  describe 'GET /index' do
    it 'renders a successful response' do
      create(:recipe_category)
      get recipe_categories_url
      expect(response).to be_successful
    end
  end

  describe 'GET /show' do
    it 'renders a successful response' do
      recipe = create(:recipe)
      get recipe_url(recipe)
      expect(response).to be_successful
    end
  end
end
