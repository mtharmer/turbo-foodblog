# frozen_string_literal: true

require 'rails_helper'

RSpec.describe CommentsController, type: :routing do
  describe 'routing' do
    it 'routes to comments#create' do
      expect(post: '/recipes/1/comments').to route_to('comments#create', recipe_id: '1')
    end
  end
end
