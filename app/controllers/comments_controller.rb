# frozen_string_literal: true

class CommentsController < ApplicationController
  before_action :authenticate_user!
  respond_to :html

  def create
    @comment = Comment.new(comment_params)
    # binding.break
    if @comment.save
      redirect_to recipe_url(params[:recipe_id]), notice: t('.notice')
    else
      redirect_to recipe_url(params[:recipe_id]), alert: t('.alert')
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:user_id, :recipe_id, :message)
  end
end
