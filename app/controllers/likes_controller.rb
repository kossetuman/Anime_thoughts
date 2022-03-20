class LikesController < ApplicationController
  def create
    @like = current_user.likes.create(anime_id: params[:anime_id])
    redirect_back(fallback_location: user_path(current_user))
  end
  
  def destroy
    @anime = Anime.find(params[:anime_id])
    @like = current_user.likes.find_by(anime_id: @anime.id)
    @like.destroy
    redirect_back(fallback_location: user_path(current_user))
  end  
end
