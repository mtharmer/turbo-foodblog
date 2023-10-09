# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Admin::AdminUsersController, type: :routing do
  describe 'routing' do
    it 'routes to #index' do
      expect(get: '/admin/admin_users').to route_to('admin/admin_users#index')
    end

    it 'routes to #create' do
      expect(post: '/admin/admin_users').to route_to('admin/admin_users#create')
    end

    it 'routes to #new' do
      expect(get: '/admin/admin_users/new').to route_to('admin/admin_users#new')
    end

    it 'routes to #edit' do
      expect(get: '/admin/admin_users/1/edit').to route_to('admin/admin_users#edit', id: '1')
    end

    it 'routes to #show' do
      expect(get: '/admin/admin_users/1').to route_to('admin/admin_users#show', id: '1')
    end

    it 'routes to #update' do
      expect(patch: '/admin/admin_users/1').to route_to('admin/admin_users#update', id: '1')
      expect(put: '/admin/admin_users/1').to route_to('admin/admin_users#update', id: '1')
    end

    it 'routes to #destroy' do
      expect(delete: '/admin/admin_users/1').to route_to('admin/admin_users#destroy', id: '1')
    end

    it 'routes to #batch_action' do
      expect(post: '/admin/admin_users/batch_action').to route_to('admin/admin_users#batch_action')
    end
  end
end
