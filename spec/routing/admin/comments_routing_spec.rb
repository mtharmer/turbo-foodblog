# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Admin::CommentsController, type: :routing do
  describe 'routing' do
    it 'routes to #index' do
      expect(get: '/admin/comments').to route_to('admin/comments#index')
    end

    it 'routes to #create' do
      expect(post: '/admin/comments').to route_to('admin/comments#create')
    end

    it 'routes to #show' do
      expect(get: '/admin/comments/1').to route_to('admin/comments#show', id: '1')
    end

    it 'routes to #destroy' do
      expect(delete: '/admin/comments/1').to route_to('admin/comments#destroy', id: '1')
    end
  end
end
