# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Admin::RecipeCategoriesController', type: :feature do
  comment_message = 'Cool new comment'
  edit_page_title = 'Edit Recipe Category'
  delete_success_msg = 'Recipe category was successfully destroyed'
  delete_button_text = 'Delete Recipe Category'

  RecipeCategory.destroy_all
  let!(:admin) { create(:admin_user, email: 'adminuser@example.com', password: 'password') }
  let!(:category) { create(:recipe_category, name: 'American Food') }
  let!(:edit_category) { create(:recipe_category, name: 'German') }
  let!(:index_delete_category) { create(:recipe_category, name: 'Delete Me') }
  let!(:detail_delete_category) { create(:recipe_category, name: 'No, Delete Me') }

  before do
    sign_in_admin admin
    visit admin_root_path
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
        table_row_by_id(category.id).click_link 'View'
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
        visit admin_recipe_category_url(category.id.to_s)
      end

      it 'has a contents table' do
        expect(attributes_element(category.id)).to be_truthy
      end

      it 'lists the expected fields' do
        expect(attributes_element(category.id)).to have_content 'Name'
        expect(attributes_element(category.id)).to have_content 'Created At'
      end

      it 'lists the expected values' do
        expect(attributes_element(category.id)).to have_content 'American Food'
      end

      it 'has a comments section' do
        expect(comment_element(category.id)).to be_truthy
      end

      it 'can post a comment' do
        post_comment(category.id, comment_message)
        expect(page).to have_content 'Comment was successfully created.'
      end

      it 'lists any created comments' do
        post_comment(category.id, comment_message)
        content = comment_element(category.id)
        expect(content).to have_content 'Comments (1)'
        expect(content).to have_content comment_message
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
      it 'can route directly to the page' do
        visit edit_admin_recipe_category_url(category.id.to_s)
        expect(page.find_by_id('page_title')).to have_content edit_page_title
        expect(page).to have_content category.name
      end

      it 'can route through the index page' do
        click_link 'Recipe Categories'
        table_row_by_id(category.id).click_link 'Edit'
        expect(page.find_by_id('page_title')).to have_content edit_page_title
        expect(page).to have_content category.name
      end

      it 'can route through the detail page' do
        visit admin_recipe_category_url(category.id.to_s)
        click_link edit_page_title
        expect(page.find_by_id('page_title')).to have_content edit_page_title
        expect(page).to have_content category.name
      end
    end

    context 'when loading the page' do
      before do
        visit edit_admin_recipe_category_url(edit_category.id.to_s)
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

  describe 'delete' do
    context 'when navigating from the index view' do
      before { visit admin_recipe_categories_path }

      it 'has a delete option in the table row' do
        row = table_row_by_id(index_delete_category.id)
        expect(row.find_link('Delete')).to be_truthy
      end

      it 'does not delete if user cancels', :js do
        row = table_row_by_id(index_delete_category.id)
        expect { delete_dismiss(row, 'Delete') }.not_to change(RecipeCategory, :count)
      end

      it 'deletes if user confirms', :js do
        row = table_row_by_id(index_delete_category.id)
        delete_accept(row, 'Delete')
        expect(page).to have_content delete_success_msg
      end
    end

    context 'when navigating from the detailed view' do
      before do
        visit admin_recipe_category_path(detail_delete_category)
      end

      it 'has a delete link' do
        expect(page.find_link(delete_button_text)).to be_truthy
      end

      it 'does not delete if user cancels', :js do
        expect { delete_dismiss(page, delete_button_text) }.not_to change(RecipeCategory, :count)
      end

      it 'deletes if user confirms', :js, retry_wait: 1 do
        delete_accept(page, delete_button_text)
        expect(page).to have_content delete_success_msg
      end

      it 'routes to index page after delete', :js do
        delete_accept(page, delete_button_text)
        expect(page).to have_content delete_success_msg
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

  def post_comment(id, comment_message)
    within comment_element(id) do
      fill_in 'active_admin_comment_body', with: comment_message
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

  def attributes_element(id)
    page.find "#attributes_table_recipe_category_#{id}"
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
