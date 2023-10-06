# frozen_string_literal: true

class CommentsController < ApplicationController
  before_action :authenticate_user!
  respond_to :html
  load_and_authorize_resource

  def create
    redirect_to recipe_url(params[:recipe_id]),
                Comment.create(comment_params).persisted? ? { notice: t('.notice') } : { alert: t('.alert') }
  end

  private

  def comment_params
    params.require(:comment).permit(:user_id, :recipe_id, :message)
  end
end
