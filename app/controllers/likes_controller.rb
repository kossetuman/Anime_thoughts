class LikesController < ApplicationController
  before_action :authenticate_user!
  def create
    @like = current_user.likes.create(anime_id: params[:anime_id])
    #binding.irb
    @anime = Anime.find(params[:anime_id])
    @anime.create_notification_by(current_user)
    #binding.irb
    redirect_back(fallback_location: user_path(current_user))
  end

  def destroy
    @anime = Anime.find(params[:anime_id])
    @like = current_user.likes.find_by(anime_id: @anime.id)
    #binding.pry
    @like.destroy
    redirect_back(fallback_location: user_path(current_user))
  end
end
