class CommentsController < ApplicationController

  def create
    user = current_user
    @comment = Comment.new(content: params[:comment][:content], gossip_id: params[:comment][:gossip_id])
    if user.nil?
      redirect_to gossip_path(@comment.gossip_id), alert: 'Please log in to add a comment! 2'
    else
      @comment.user_id = user.id
      @comment.related_comment_id = params[:comment][:related_comment_id] unless params[:comment][:related_comment_id].nil?
      if @comment.save!
        redirect_to gossip_path(@comment.gossip_id), notice: 'New comment successfuly added'
      else
        render :new, alert: "Something went wrong. Comment couldn't be added"
      end
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:content, :user)
  end

  def current_user
    @current_user ||= User.find_by(is_logged: true) if !User.find_by(is_logged: true).nil?
  end
end
