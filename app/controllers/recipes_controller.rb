# frozen_string_literal: true

class RecipesController < ApplicationController
  before_action :set_recipe, only: %i[show edit update destroy]
  before_action :authenticate_user!, except: %i[index show]

  respond_to :html

  load_and_authorize_resource

  # GET /recipes or /recipes.json
  def index
    @recipes = base_recipes_query
  end

  # GET /recipes/1 or /recipes/1.json
  def show; end

  # GET /recipes/new
  def new
    @recipe = Recipe.new(user_id: current_user&.id)
  end

  # GET /recipes/1/edit
  def edit; end

  # POST /recipes or /recipes.json
  def create
    @recipe = Recipe.new(recipe_params)

    if @recipe.save
      redirect_to recipe_url(@recipe), notice: t('.notice')
    else
      render :new, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /recipes/1 or /recipes/1.json
  def update
    if @recipe.update(recipe_params)
      redirect_to recipe_url(@recipe), notice: t('.notice')
    else
      render :edit, status: :unprocessable_entity
    end
  end

  # DELETE /recipes/1 or /recipes/1.json
  def destroy
    @recipe.destroy
    redirect_to recipes_url, notice: t('.notice')
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_recipe
    @recipe = base_recipes_query.find(params[:id])
  end

  def base_recipes_query
    Recipe.includes(:user, comments: :user)
  end

  # Only allow a list of trusted parameters through.
  def recipe_params
    params.require(:recipe).permit(:title, :ingredients, :instructions, :user_id, :recipe_category_id)
  end
end
