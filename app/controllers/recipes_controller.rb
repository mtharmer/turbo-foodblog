# frozen_string_literal: true

class RecipesController < ApplicationController
  before_action :set_recipe, only: %i[show edit update destroy]
  before_action :authenticate_user!, except: %i[index show]

  # GET /recipes or /recipes.json
  def index
    @recipes = Recipe.all
  end

  # GET /recipes/1 or /recipes/1.json
  def show; end

  # GET /recipes/new
  def new
    @recipe = Recipe.new
  end

  # GET /recipes/1/edit
  def edit
    return unless @recipe.user_id != current_user.id

    respond_to do |format|
      format.html { redirect_to recipe_url(@recipe), alert: 'You do not have permissions to modify this recipe.' }
      format.json { render json: { message: 'unauthorized' }, status: :unauthorized }
    end
  end

  # POST /recipes or /recipes.json
  def create
    @recipe = Recipe.new(recipe_params)

    respond_to do |format|
      if @recipe.save
        format.html { redirect_to recipe_url(@recipe), notice: 'Recipe was successfully created.' }
        format.json { render :show, status: :created, location: @recipe }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @recipe.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /recipes/1 or /recipes/1.json
  def update
    respond_to do |format|
      if @recipe.update(recipe_params)
        format.html { redirect_to recipe_url(@recipe), notice: 'Recipe was successfully updated.' }
        format.json { render :show, status: :ok, location: @recipe }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @recipe.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /recipes/1 or /recipes/1.json
  def destroy
    respond_to do |format|
      if @recipe.user_id == current_user.id
        @recipe.destroy
        format.html { redirect_to recipes_url, notice: 'Recipe was successfully destroyed.' }
        format.json { head :no_content }
      else
        format.html { redirect_to recipe_url(@recipe), alert: 'You do not have permissions to delete this recipe.' }
        format.json { render json: { message: 'unauthorized' }, status: :unauthorized }
      end
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_recipe
    @recipe = Recipe.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def recipe_params
    params.require(:recipe).permit(:title, :ingredients, :instructions, :user_id)
  end
end
