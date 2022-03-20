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

  def edit
    @anime = Anime.find(params[:id])
    if @anime.user == current_user
      render :edit
    else
      redirect_to user_path(current_user)
    end
  end

  def update
    @anime = Anime.find(params[:id])
    if @anime.update(anime_params)
      redirect_to user_path(current_user)
    else
      render :edit
    end
  end

  def destroy
    anime = Anime.find(params[:id])
    if anime.destroy
      redirect_to user_path(anime.user.id)
    else
      render :show
    end
  end

   private

    def anime_params
      params.require(:anime).permit(:title, :thought, :anime_image)
    end
end
