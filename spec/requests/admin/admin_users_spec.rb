# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'admin/admin_users', type: :request do
  let!(:admin) { create(:admin_user) }

  before do
    sign_in_admin admin
  end

  describe 'GET index' do
    before { get admin_admin_users_url }

    it { expect(response).to have_http_status :ok }
  end
end
