class LikesController < ApplicationController
  def create
    like = Like.create!(user_id: params[:like][:user_id], gossip_id: params[:like][:gossip_id])
    redirect_to gossip_path(params[:like][:gossip_id]), notice: "You liked that gossip :)"
  end

  def delete
    like = Like.find_by(user_id: params[:like][:user_id], gossip_id: params[:like][:gossip_id])
    like.destroy
    redirect_to gossip_path(params[:like][:gossip_id]), alert: "You unliked that gossip :("
  end
end
