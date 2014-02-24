class CommentsController < ApplicationController

  def create
    unless params[:card_id].blank? || params[:comment].blank? || current_user.blank?
      comment = Comment.new(:card_id => params[:card_id], :comment => params[:comment], :user_id => current_user.id)
      comment.save
      render :json => {:comment => comment.comment, :username => current_user.username}, :success => true and return
    else
      render :json => {:error => "error"}, :success => false and return
    end
  end
end