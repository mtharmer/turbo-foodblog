# frozen_string_literal: true

class RecipeCategoriesController < ApplicationController
  before_action :set_recipe_category, only: %i[show]

  respond_to :html

  load_and_authorize_resource

  # GET /recipes_categories
  def index
    @recipe_categories = RecipeCategory.includes(:recipes).all
  end

  # GET /recipe_categories/1
  def show; end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_recipe_category
    @recipe_category = RecipeCategory.includes(:recipes).find(params[:id])
  end
end
