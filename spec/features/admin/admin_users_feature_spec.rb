require 'rails_helper'

RSpec.describe 'Admin::AdminUsersController' do
  email = 'adminuser@example.com'
  password = 'password'
  let!(:admin) { build(:admin_user, email: email, password: password) }

  def log_in_admin_user(email = 'adminuser@example.com', password = 'password')
    visit new_admin_user_session_path
    fill_in 'Email', with: email
    fill_in 'Password', with: password
    click_button 'Login'
  end

  before do
    admin.save
    log_in_admin_user
  end

  it 'logs in' do
    expect(page).to have_content 'Signed in successfully'
  end

  describe "GET index" do
    before do
      click_link 'Admin Users'
    end

    it 'has a list of admin users' do
      expect(page.find('#index_table_admin_users')).to have_content 'adminuser@example.com'
      expect(page).to have_selector('table tbody tr', count: AdminUser.count)
    end

    it 'has the expected columns' do
      header = page.find('#index_table_admin_users thead')
      expect(header).to have_content 'Id'
      expect(header).to have_content 'Email'
      expect(header).to have_content 'Sign In Count'
      expect(header).to have_content 'Created At'
    end

    it "filter Email works" do
      matching_person = create(:admin_user, email: 'user1@example.com')
      non_matching_person = create(:admin_user, email: 'user2@example.com')

      fill_in 'q_email', with: 'user1'
      click_button 'Filter'

      expect(page).to have_selector 'table tbody tr', count: 1
    end
  end

  describe 'GET show' do
    let(:admin_id) { admin.id.to_s }
    it 'can route directly to the page' do
      visit admin_admin_user_url(admin_id)
      expect(page).to have_content 'Admin User Details'
      expect(page).to have_content 'adminuser@example.com'
    end

    it 'can route through the index page' do
      click_link 'Admin Users'
      page.find("#admin_user_#{admin_id}").click_link 'View'
      expect(page).to have_content 'Admin User Details'
      expect(page).to have_content 'adminuser@example.com'
    end

    context 'loading the page' do
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
        within "#active_admin_comments_for_admin_user_#{admin_id}" do
          fill_in 'active_admin_comment_body', with: 'Cool new comment'
        end
        click_button 'Add Comment'
        expect(page).to have_content 'Comment was successfully created.'
      end

      it 'lists any created comments' do
        within "#active_admin_comments_for_admin_user_#{admin_id}" do
          fill_in 'active_admin_comment_body', with: 'Cool new comment'
        end
        click_button 'Add Comment'
        content = page.find "#active_admin_comments_for_admin_user_#{admin_id}"
        expect(content).to have_content 'Comments (1)'
        expect(content).to have_content 'Cool new comment'
      end
    end
  end

  describe 'create' do
    it 'can route directly to the page' do
      visit new_admin_admin_user_path
      expect(page.find('#page_title')).to have_content 'New Admin User'
    end

    it 'can route through the index page' do
      visit admin_admin_users_path
      click_link 'New Admin User'
      expect(page.find('#page_title')).to have_content 'New Admin User'
    end

    context 'loading the page' do
      before do
        visit new_admin_admin_user_path
      end

      it 'has the expected fields' do
        expect(page).to have_selector '#admin_user_email_input'
        expect(page).to have_selector '#admin_user_password_input'
        expect(page).to have_selector '#admin_user_password_confirmation_input'
      end

      let!(:f_email)    { page.find('#admin_user_email') }
      let!(:f_password) { page.find('#admin_user_password') }
      let!(:f_confirm)  { page.find('#admin_user_password_confirmation') }

      it 'saves a user on submit' do
        expect do
          f_email.fill_in with: 'cool@example.com'
          f_password.fill_in with: 'password'
          f_confirm.fill_in with: 'password'
          click_button 'Create Admin user'
        end.to change(AdminUser, :count).by(1)
      end
    end
  end

  describe 'edit' do
    let(:admin_id) { admin.id.to_s }
    it 'can route directly to the page' do
      visit edit_admin_admin_user_url(admin_id)
      expect(page.find('#page_title')).to have_content 'Edit Admin User'
      expect(page).to have_content 'adminuser@example.com'
    end

    it 'can route through the index page' do
      click_link 'Admin Users'
      page.find("#admin_user_#{admin_id}").click_link 'Edit'
      expect(page.find('#page_title')).to have_content 'Edit Admin User'
      expect(page).to have_content 'adminuser@example.com'
    end

    it 'can route through the detail page' do
      visit admin_admin_user_url(admin_id)
      click_link 'Edit Admin User'
      expect(page.find('#page_title')).to have_content 'Edit Admin User'
      expect(page).to have_content 'adminuser@example.com'
    end

    context 'loading the page' do
      let!(:new_admin) { create(:admin_user, email: 'newadmin@example.com', password: 'password') }
      let!(:new_id) { new_admin.id.to_s }
      before do
        visit edit_admin_admin_user_url(new_id)
      end

      it 'loads a form' do
        expect(page).to have_selector '#edit_admin_user'
      end

      it 'displays field options' do
        expect(page).to have_selector '#admin_user_email_input'
        expect(page).to have_selector '#admin_user_password_input'
        expect(page).to have_selector '#admin_user_password_confirmation_input'
      end

      it 'displays a submit and cancel button' do
        expect(page.find_button('Update Admin user')).to be_truthy
        expect(page.find_link('Cancel')).visible?).to be_truthy
      end

      it 'redirects on cancel' do
        page.find_link('Cancel').click
        expect(page).to have_current_path admin_admin_users_path
      end
    end

    context 'editing an admin user' do
      let!(:new_admin) { create(:admin_user, email: 'newadmin@example.com', password: 'password') }
      let!(:new_id) { new_admin.id.to_s }
      before do
        visit edit_admin_admin_user_url(new_id)
      end

      let!(:f_email)    { page.find('#admin_user_email') }
      let!(:f_password) { page.find('#admin_user_password') }
      let!(:f_confirm)  { page.find('#admin_user_password_confirmation') }

      it 'creates a user on submit' do
        f_email.fill_in with: 'newadmin@example.com'
        f_password.fill_in with: 'newpassword'
        f_confirm.fill_in with: 'newpassword'
        click_button 'Update Admin user'
        expect(page).to have_content 'Admin user was successfully updated.'
        expect(page).to have_current_path admin_admin_user_path(new_id)
      end

      it 'requires new login if admin changes own password' do
        visit edit_admin_admin_user_url(admin_id)
        f_email.fill_in with: 'adminuser@example.com'
        f_password.fill_in with: 'newpassword'
        f_confirm.fill_in with: 'newpassword'
        click_button 'Update Admin user'
        expect(page).to have_content 'You need to sign in or sign up before continuing'
        expect(page).to have_current_path new_admin_user_session_path
      end
    end
  end

  describe 'delete', :js do
    let(:admin_id) { admin.id.to_s }
    let!(:index_admin) { create(:admin_user, email: 'newadmin1@example.com', password: 'password') }
    let!(:direct_admin) { create(:admin_user, email: 'newadmin2@example.com', password: 'password') }
    let!(:index_admin_id) { index_admin.id.to_s }
    let!(:direct_admin_id) { direct_admin.id.to_s }

    context 'from the index view' do
      before do
        visit admin_admin_users_path
      end

      it 'has a delete option in the table row' do
        expect(page.find("#admin_user_#{index_admin_id}").find_link('Delete')).to be_truthy
      end

      it 'does not delete if user cancels' do
        expect do
          dismiss_confirm do
            page.find("#admin_user_#{index_admin_id}").click_link 'Delete'
          end
        end.not_to change(AdminUser, :count)
      end

      it 'deletes if user confirms' do
        expect do
          accept_confirm do
            page.find("#admin_user_#{index_admin_id}").click_link 'Delete'
          end
        end.to change(AdminUser, :count).by(-1)
        expect(page).to have_content 'Admin user was successfully destroyed.'
      end
    end

    context 'from the detail view' do
      before do
        visit admin_admin_user_path(direct_admin)
      end

      it 'has a delete link' do
        expect(page.find_link('Delete Admin User')).to be_truthy
      end

      it 'does not delete if user cancels' do
        expect do
          dismiss_confirm do
            click_link('Delete Admin User')
          end
        end.not_to change(AdminUser, :count)
      end

      it 'deletes if user confirms', retry_wait: 1 do
        expect do
          accept_confirm do
            click_link('Delete Admin User')
          end
        end.to change(AdminUser, :count).by(-1)
        expect(page).to have_content 'Admin user was successfully destroyed.'
      end

      it 'routes to index page after delete' do
        accept_confirm do
          click_link('Delete Admin User')
        end
        expect(page).to have_content 'Admin user was successfully destroyed.'
        expect(page).to have_current_path admin_admin_users_path
      end
    end
  end
end
