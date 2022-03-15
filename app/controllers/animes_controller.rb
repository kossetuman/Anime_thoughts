class AnimesController < ApplicationController
  def index
    @anime = Anime.new
    @anime_index = Anime.all
  end

  def create
    @anime = Anime.new(anime_params)
    if @anime.save
      redirect_to anime_path
    end
  end

   private

    def anime_params
      params.require(:anime).permit(:title, :thought)
    end
end
