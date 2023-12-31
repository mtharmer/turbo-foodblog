# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Admin::DashboardController', type: :feature do
  let!(:admin) { create(:admin_user, email: 'adminuser@example.com', password: 'password') }

  before do
    create(:comment)
    sign_in_admin admin
    visit admin_root_path
  end

  it 'has a main content page' do
    expect(main_content).to be_truthy
  end

  it 'has a panel for Recent Recipes' do
    expect(main_content).to have_text 'Recent Recipes'
  end

  it 'has a panel for Comments' do
    expect(main_content).to have_text 'Comments'
  end

  it 'shows a count of total comments' do
    expect(page.find_by_id('comments_panel')).to have_text Comment.count
  end

  it 'has a panel for Recipes' do
    expect(main_content).to have_text 'Recipes'
  end

  it 'shows a count of total recipes' do
    expect(page.find_by_id('recipes_panel')).to have_text Recipe.count
  end

  it 'has a panel for Users' do
    expect(main_content).to have_text 'Users'
  end

  it 'shows a count of total users' do
    expect(page.find_by_id('users_panel')).to have_text User.count
  end

  def main_content
    page.find_by_id('main_content')
  end
end
