class CommentsController < InheritedResources::Base
  belongs_to :recipe, :finder => :find_by_id!, :param => :recipe_id
  before_action :set_comment, only: %i[show edit update destroy]
  before_action :authenticate_user!, except: %i[index show]
  # actions :index, :new, :create
  actions :all

  private

  def set_comment
    @comment = Comment.find(params[:id])
  end

  def comment_params
    params.require(:comment).permit(:user_id, :recipe_id, :message)
  end

  def validate_user
    return if @recipe.user == current_user

    respond_to do |format|
      format.html { redirect_to recipe_url(@recipe), alert: t('.alert') }
      format.json { render :show, status: :unauthorized, location: @recipe }
    end
  end
end
