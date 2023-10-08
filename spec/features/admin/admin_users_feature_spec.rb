# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Admin::AdminUsersController' do
  delete_text = 'Delete'
  delete_link = 'Delete Admin User'
  delete_success = 'Admin user was successfully destroyed.'
  edit_title = 'Edit Admin User'
  new_title = 'New Admin User'
  update_button_text = 'Update Admin user'

  AdminUser.destroy_all
  let!(:admin) { create(:admin_user, email: 'adminuser@example.com', password: 'password') }
  let(:admin_id) { admin.id.to_s }

  let!(:edit_admin) { create(:admin_user, email: 'editadmin@example.com', password: 'password') }

  let!(:index_delete_admin) { create(:admin_user, email: 'index_delete_admin@example.com', password: 'password') }
  let!(:direct_delete_admin) { create(:admin_user, email: 'direct_delete_admin@example.com', password: 'password') }

  def log_in_admin_user
    visit new_admin_user_session_path
    fill_in 'Email', with: admin.email
    fill_in 'Password', with: admin.password
    click_button 'Login'
  end

  before do
    log_in_admin_user
  end

  it 'logs in' do
    expect(page).to have_content 'Signed in successfully'
  end

  describe 'GET index' do
    before do
      click_link 'Admin Users'
    end

    it 'has a list of admin users' do
      expect(page.find_by_id('index_table_admin_users')).to have_content 'adminuser@example.com'
      expect(page).to have_css('table tbody tr', count: AdminUser.count)
    end

    it 'has the expected columns' do
      header = page.find('#index_table_admin_users thead')
      expect(header).to have_content 'Id'
      expect(header).to have_content 'Email'
      expect(header).to have_content 'Sign In Count'
      expect(header).to have_content 'Created At'
    end

    it 'filter Email works' do
      create(:admin_user, email: 'user1@example.com')
      create(:admin_user, email: 'user2@example.com')

      fill_in 'q_email', with: 'user1'
      click_button 'Filter'

      expect(page).to have_css 'table tbody tr', count: 1
    end
  end

  describe 'GET show' do
    it 'can route directly to the page' do
      visit admin_admin_user_url(admin_id)
      expect(page).to have_content 'Admin User Details'
      expect(page).to have_content 'adminuser@example.com'
    end

    it 'can route through the index page' do
      click_link 'Admin Users'
      table_row_by_id(admin_id).click_link 'View'
      expect(page).to have_content 'Admin User Details'
      expect(page).to have_content 'adminuser@example.com'
    end

    context 'when loading the page' do
      before do
        visit admin_admin_user_url(admin_id)
      end

      it 'has a contents table' do
        expect(page).to have_selector "#attributes_table_admin_user_#{admin_id}"
      end

      it 'lists the expected fields' do
        content = page.find "#attributes_table_admin_user_#{admin_id}"
        expect(content).to have_content 'Email'
        expect(content).to have_content 'Created At'
      end

      it 'lists the expected values' do
        content = page.find "#attributes_table_admin_user_#{admin_id}"
        expect(content).to have_content 'adminuser@example.com'
      end

      it 'has a comments section' do
        expect(page).to have_selector "#active_admin_comments_for_admin_user_#{admin_id}"
      end

      it 'can post a comment' do
        post_comment(admin_id, 'Cool new comment')
        expect(page).to have_content 'Comment was successfully created.'
      end

      it 'lists any created comments' do
        post_comment(admin_id, 'Cool new comment')
        content = page.find "#active_admin_comments_for_admin_user_#{admin_id}"
        expect(content).to have_content 'Comments (1)'
        expect(content).to have_content 'Cool new comment'
      end
    end
  end

  describe 'create' do
    it 'can route directly to the page' do
      visit new_admin_admin_user_path
      expect(page.find_by_id('page_title')).to have_content new_title
    end

    it 'can route through the index page' do
      visit admin_admin_users_path
      click_link 'New Admin User'
      expect(page.find_by_id('page_title')).to have_content new_title
    end

    context 'when loading the page' do
      before do
        visit new_admin_admin_user_path
      end

      it 'has the expected fields' do
        expect(page).to have_css '#admin_user_email_input'
        expect(page).to have_css '#admin_user_password_input'
        expect(page).to have_css '#admin_user_password_confirmation_input'
      end

      it 'saves a user on submit' do
        expect do
          fill_form_fields('cool@example.com', 'password')
          click_button 'Create Admin user'
        end.to change(AdminUser, :count).by(1)
      end
    end
  end

  describe 'edit' do
    it 'can route directly to the page' do
      visit edit_admin_admin_user_url(admin)
      expect(page.find_by_id('page_title')).to have_content edit_title
      expect(page).to have_content 'adminuser@example.com'
    end

    it 'can route through the index page' do
      click_link 'Admin Users'
      table_row_by_id(admin_id).click_link 'Edit'
      expect(page.find_by_id('page_title')).to have_content edit_title
      expect(page).to have_content 'adminuser@example.com'
    end

    it 'can route through the detail page' do
      visit admin_admin_user_url(admin)
      click_link 'Edit Admin User'
      expect(page.find_by_id('page_title')).to have_content edit_title
      expect(page).to have_content 'adminuser@example.com'
    end

    context 'when loading the page' do
      before do
        visit edit_admin_admin_user_url(edit_admin)
      end

      it 'loads a form' do
        expect(page).to have_css '#edit_admin_user'
      end

      it 'displays field options' do
        expect(page).to have_css '#admin_user_email_input'
        expect(page).to have_css '#admin_user_password_input'
        expect(page).to have_css '#admin_user_password_confirmation_input'
      end

      it 'displays a submit and cancel button' do
        expect(page.find_button(update_button_text)).to be_truthy
        expect(page.find_link('Cancel')).to be_visible
      end

      it 'redirects on cancel' do
        page.find_link('Cancel').click
        expect(page).to have_current_path admin_admin_users_path
      end
    end

    context 'when editing an admin user' do
      before do
        visit edit_admin_admin_user_url(edit_admin)
      end

      it 'updates the user on submit' do
        fill_form_fields(edit_admin.email, edit_admin.password)
        click_button update_button_text
        expect(page).to have_content 'Admin user was successfully updated.'
        expect(page).to have_current_path admin_admin_user_path(edit_admin)
      end

      it 'requires new login if admin changes own password' do
        visit edit_admin_admin_user_url(admin)
        fill_form_fields('adminuser@example.com', 'newpassword')
        click_button update_button_text
        expect(page).to have_content 'You need to sign in or sign up before continuing'
        expect(page).to have_current_path new_admin_user_session_path
      end
    end
  end

  describe 'delete' do
    context 'when coming from the index view' do
      before do
        visit admin_admin_users_path
      end

      it 'has a delete option in the table row' do
        row = table_row_by_id(index_delete_admin.id)
        expect(row.find_link(delete_text)).to be_truthy
      end

      it 'does not delete if user cancels', :js do
        row = table_row_by_id(index_delete_admin.id)
        expect { delete_dismiss(row, delete_text) }.not_to change(AdminUser, :count)
      end

      it 'deletes if user confirms', :js do
        row = table_row_by_id(index_delete_admin.id)
        delete_accept(row, delete_text)
        expect(page).to have_content delete_success
      end
    end

    context 'when coming from the detail view' do
      before do
        visit admin_admin_user_path(direct_delete_admin)
      end

      it 'has a delete link' do
        expect(page.find_link(delete_link)).to be_truthy
      end

      it 'does not delete if user cancels', :js do
        expect { delete_dismiss(page, delete_link) }.not_to change(AdminUser, :count)
      end

      it 'deletes and redirects if user confirms', :js, retry_wait: 1 do
        delete_accept(page, delete_link)
        expect(page).to have_content delete_success
        expect(page).to have_current_path admin_admin_users_path
      end
    end
  end

  def table_row_by_id(admin_id)
    page.find("#admin_user_#{admin_id}")
  end

  def email_field
    page.find_by_id('admin_user_email')
  end

  def password_field
    page.find_by_id('admin_user_password')
  end

  def password_confirm_field
    page.find_by_id('admin_user_password_confirmation')
  end

  def fill_form_fields(email, password)
    email_field.fill_in with: email
    password_field.fill_in with: password
    password_confirm_field.fill_in with: password
  end

  def post_comment(admin_id, message)
    within "#active_admin_comments_for_admin_user_#{admin_id}" do
      fill_in 'active_admin_comment_body', with: message
    end
    click_button 'Add Comment'
  end

  def delete_dismiss(element, title)
    dismiss_confirm do
      element.click_link title
    end
  end

  def delete_accept(element, title)
    accept_confirm do
      element.click_link title
    end
  end
end
