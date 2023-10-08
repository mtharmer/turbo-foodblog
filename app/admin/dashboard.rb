# frozen_string_literal: true

ActiveAdmin.register_page 'Dashboard' do
  menu priority: 1, label: proc { I18n.t('active_admin.dashboard') }

  content title: proc { I18n.t('active_admin.dashboard') } do
    # div class: 'blank_slate_container', id: 'dashboard_default_message' do
    #   span class: 'blank_slate' do
    #     span I18n.t('active_admin.dashboard_welcome.welcome')
    #     small I18n.t('active_admin.dashboard_welcome.call_to_action')
    #   end
    # end

    columns id: 'dashboard_columns' do
      column id: 'dashboard_column_1' do
        panel 'Recent Recipes', id: 'recent_recipes_panel' do
          ul do
            Recipe.limit(5).map do |recipe|
              li link_to recipe.title, recipe_path(recipe)
            end
          end
        end
      end
      column id: 'dashboard_column_2' do
        panel 'Comments', id: 'comments_panel' do
          span Comment.count
        end
        panel 'Users', id: 'users_panel' do
          span User.count
        end
        panel 'Recipes', id: 'recipes_panel' do
          span Recipe.count
        end
      end
    end

    # Here is an example of a simple dashboard with columns and panels.
    #
    # columns do
    #   column do
    #     panel "Recent Posts" do
    #       ul do
    #         Post.recent(5).map do |post|
    #           li link_to(post.title, admin_post_path(post))
    #         end
    #       end
    #     end
    #   end

    #   column do
    #     panel "Info" do
    #       para "Welcome to ActiveAdmin."
    #     end
    #   end
    # end
  end
end
