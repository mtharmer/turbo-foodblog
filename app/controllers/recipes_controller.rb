# frozen_string_literal: true

class RecipesController < InheritedResources::Base
  # rubocop:disable Rails/LexicallyScopedActionFilter
  before_action :set_recipe, only: %i[show edit update destroy]
  before_action :authenticate_user!, except: %i[index show]
  before_action :validate_user, only: %i[edit update destroy]
  # rubocop:enable Rails/LexicallyScopedActionFilter

  respond_to :html, :json
  actions :all

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_recipe
    @recipe = Recipe.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def recipe_params
    params.require(:recipe).permit(:title, :ingredients, :instructions, :user_id)
  end

  def validate_user
    return if @recipe.user == current_user

    respond_to do |format|
      format.html { redirect_to recipe_url(@recipe), alert: t('.alert') }
      format.json { render :show, status: :unauthorized, location: @recipe }
    end
  end
end
