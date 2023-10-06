# frozen_string_literal: true

class CommentsController < InheritedResources::Base
  belongs_to :recipe
  before_action :authenticate_user!
  actions :create

  def create
    super do
      respond_to do |format|
        format.html { redirect_to recipe_url(@recipe) and return }
      end
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:user_id, :recipe_id, :message)
  end
end