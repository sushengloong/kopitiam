class CommentsController < ApplicationController
  before_action :authenticate_user!

  def new
  end

  def create
    @comment = current_user.comments.create comment_params
    render 'create.js'
  end

  def edit
  end

  def update
  end

  def destroy
  end

  private
  def comment_params
    params.require(:comment).permit(:content, :topic_id, :user_id)
  end
end
