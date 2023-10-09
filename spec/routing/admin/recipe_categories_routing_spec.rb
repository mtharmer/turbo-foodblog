# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Admin::RecipeCategoriesController, type: :routing do
  describe 'routing' do
    it 'routes to #index' do
      expect(get: '/admin/recipe_categories').to route_to('admin/recipe_categories#index')
    end

    it 'routes to #create' do
      expect(post: '/admin/recipe_categories').to route_to('admin/recipe_categories#create')
    end

    it 'routes to #new' do
      expect(get: '/admin/recipe_categories/new').to route_to('admin/recipe_categories#new')
    end

    it 'routes to #edit' do
      expect(get: '/admin/recipe_categories/1/edit').to route_to('admin/recipe_categories#edit', id: '1')
    end

    it 'routes to #show' do
      expect(get: '/admin/recipe_categories/1').to route_to('admin/recipe_categories#show', id: '1')
    end

    it 'routes to #update' do
      expect(patch: '/admin/recipe_categories/1').to route_to('admin/recipe_categories#update', id: '1')
      expect(put: '/admin/recipe_categories/1').to route_to('admin/recipe_categories#update', id: '1')
    end

    it 'routes to #destroy' do
      expect(delete: '/admin/recipe_categories/1').to route_to('admin/recipe_categories#destroy', id: '1')
    end

    it 'routes to #batch_action' do
      expect(post: '/admin/recipe_categories/batch_action').to route_to('admin/recipe_categories#batch_action')
    end
  end
end
