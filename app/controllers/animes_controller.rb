class AnimesController < ApplicationController
  def index
    @anime = Anime.new
    @animes_index = Anime.page(params[:page]).per(10)
  end

  def create
    @anime = Anime.new(anime_params)
    @anime.user_id = current_user.id
    if @anime.save
      redirect_to user_path(@anime.user.id)
    end
  end

  def show
    @anime = Anime.find(params[:id])
  end

  def destroy
    anime = Anime.find(params[:id])
    anime.destroy
    redirect_to root_path
  end

   private

    def anime_params
      params.require(:anime).permit(:title, :thought, :anime_image)
    end
end
