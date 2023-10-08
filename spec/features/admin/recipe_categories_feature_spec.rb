# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Admin::RecipeCategoriesController' do
  let!(:admin) { create(:admin_user, email: 'adminuser@example.com', password: 'password') }
  let!(:category) { create(:recipe_category, name: 'American Food') }
  let!(:category_id) { category.id.to_s }

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

  describe 'index' do
    before do
      visit admin_recipe_categories_path
    end

    it 'has a list of categories' do
      expect(page.find_by_id('index_table_recipe_categories')).to have_content 'American Food'
      expect(page).to have_css('table tbody tr', count: RecipeCategory.count)
    end

    it 'has the expected columns' do
      header = page.find('#index_table_recipe_categories thead')
      expect(header).to have_content 'Id'
      expect(header).to have_content 'Name'
      expect(header).to have_content 'Created At'
    end

    it 'filter Email works' do
      create(:recipe_category, name: 'Indian Food')
      create(:recipe_category, name: 'English Food')

      fill_in 'q_name', with: 'ind'
      click_button 'Filter'

      expect(page).to have_css 'table tbody tr', count: 1
    end
  end

  describe 'show' do
    context 'when navigating' do
      it 'can be accessed through the index page' do
        visit admin_recipe_categories_path
        table_row_by_id(category_id).click_link 'View'
        expect(page).to have_current_path admin_recipe_category_path(category)
        expect(page).to have_content 'Recipe Category Details'
      end

      it 'can be accessed directly' do
        visit admin_recipe_category_path(category)
        expect(page).to have_content 'Recipe Category Details'
      end
    end

    context 'when loading the page' do
      before do
        visit admin_recipe_category_url(category_id)
      end

      let(:attributes_element) { page.find "#attributes_table_recipe_category_#{category_id}" }

      it 'has a contents table' do
        expect(attributes_element).to be_truthy
      end

      it 'lists the expected fields' do
        expect(attributes_element).to have_content 'Name'
        expect(attributes_element).to have_content 'Created At'
      end

      it 'lists the expected values' do
        expect(attributes_element).to have_content 'American Food'
      end

      it 'has a comments section' do
        expect(comment_element(category_id)).to be_truthy
      end

      it 'can post a comment' do
        post_comment(category_id, 'Cool new comment')
        expect(page).to have_content 'Comment was successfully created.'
      end

      it 'lists any created comments' do
        post_comment(category_id, 'Cool new comment')
        content = comment_element(category_id)
        expect(content).to have_content 'Comments (1)'
        expect(content).to have_content 'Cool new comment'
      end
    end
  end

  describe 'create' do
    context 'when navigating' do
      it 'can route directly to the page' do
        visit new_admin_recipe_category_path
        expect(page.find_by_id('page_title')).to have_content 'New Recipe Category'
      end

      it 'can route through the index page' do
        visit admin_recipe_categories_path
        click_link 'New Recipe Category'
        expect(page.find_by_id('page_title')).to have_content 'New Recipe Category'
      end
    end

    context 'when loading the page' do
      before do
        visit new_admin_recipe_category_path
      end

      it 'has the expected fields' do
        expect(page).to have_css '#recipe_category_name_input'
      end

      it 'saves a user on submit' do
        expect { submit_form('Indian Cuisine', 'Create Recipe category') }.to change(RecipeCategory, :count).by(1)
      end
    end
  end

  describe 'edit' do
    context 'when navigating' do
      let(:expected_title) { 'Edit Recipe Category' }
      let(:expected_category) { 'American' }

      it 'can route directly to the page' do
        visit edit_admin_recipe_category_url(category_id)
        expect(page.find_by_id('page_title')).to have_content expected_title
        expect(page).to have_content expected_category
      end

      it 'can route through the index page' do
        click_link 'Recipe Categories'
        table_row_by_id(category_id).click_link 'Edit'
        expect(page.find_by_id('page_title')).to have_content expected_title
        expect(page).to have_content expected_category
      end

      it 'can route through the detail page' do
        visit admin_recipe_category_url(category_id)
        click_link expected_title
        expect(page.find_by_id('page_title')).to have_content expected_title
        expect(page).to have_content expected_category
      end
    end

    context 'when loading the page' do
      let!(:edit_category) { create(:recipe_category, name: 'German') }
      let!(:edit_id) { edit_category.id.to_s }

      before do
        visit edit_admin_recipe_category_url(edit_id)
      end

      it 'loads a form' do
        expect(page).to have_css '#edit_recipe_category'
      end

      it 'displays field options' do
        expect(page).to have_css '#recipe_category_name_input'
      end

      it 'displays a submit and cancel button' do
        expect(page.find_button('Update Recipe category')).to be_truthy
        expect(page.find_link('Cancel')).to be_visible
      end

      it 'redirects on cancel' do
        page.find_link('Cancel').click
        expect(page).to have_current_path admin_recipe_categories_path
      end

      it 'saves changes on submit' do
        fill_in 'Name', with: 'German Cuisine'
        click_button 'Update Recipe category'
        expect(edit_category.reload.name).to eq('German Cuisine')
        expect(page).to have_content 'Recipe category was successfully updated.'
      end
    end
  end

  describe 'delete', :js do
    let(:success_msg) { 'Recipe category was successfully destroyed' }

    context 'when navigating from the index view' do
      let!(:delete_category) { create(:recipe_category) }
      let!(:delete_id) { delete_category.id.to_s }

      before do
        visit admin_recipe_categories_path
      end

      it 'has a delete option in the table row' do
        row = table_row_by_id(delete_id)
        expect(row.find_link('Delete')).to be_truthy
      end

      it 'does not delete if user cancels' do
        row = table_row_by_id(delete_id)
        expect { delete_dismiss(row, 'Delete') }.not_to change(RecipeCategory, :count)
      end

      it 'deletes if user confirms' do
        row = table_row_by_id(delete_id)
        delete_accept(row, 'Delete')
        expect(page).to have_content success_msg
      end
    end

    context 'when navigating from the detailed view' do
      let(:delete_button) { 'Delete Recipe Category' }
      let!(:delete_category) { create(:recipe_category) }
      let!(:delete_id) { delete_category.id.to_s }

      before do
        visit admin_recipe_category_path(delete_category)
      end

      it 'has a delete link' do
        expect(page.find_link(delete_button)).to be_truthy
      end

      it 'does not delete if user cancels' do
        expect { delete_dismiss(page, delete_button) }.not_to change(RecipeCategory, :count)
      end

      it 'deletes if user confirms', retry_wait: 1 do
        delete_accept(page, delete_button)
        expect(page).to have_content success_msg
      end

      it 'routes to index page after delete' do
        delete_accept(page, delete_button)
        expect(page).to have_content success_msg
        expect(page).to have_current_path admin_recipe_categories_path
      end
    end
  end

  def table_row_by_id(id)
    page.find("#recipe_category_#{id}")
  end

  def comment_element(id)
    page.find("#active_admin_comments_for_recipe_category_#{id}")
  end

  def post_comment(id, message)
    within comment_element(id) do
      fill_in 'active_admin_comment_body', with: message
    end
    click_button 'Add Comment'
  end

  def name_field
    page.find_by_id('recipe_category_name')
  end

  def fill_form_fields(name)
    name_field.fill_in with: name
  end

  def submit_form(name, btn_title)
    fill_form_fields(name)
    click_button btn_title
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
