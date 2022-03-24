class AnimesController < ApplicationController
   before_action :authenticate_user!
  def index
    @anime = Anime.new
    @animes_index = Anime.page(params[:page]).per(10)
  end

  def create
    @anime = Anime.new(anime_params)
    @anime.user_id = current_user.id
    if @anime.save
      redirect_to user_path(@anime.user.id), notice: '投稿に成功しました。'
    end
  end

  def show
    @anime = Anime.find(params[:id])
    @comment = Comment.new
    @user = User.find_by(id: @comment.user_id)
    @comments = @anime.comments.page(params[:page]).per(5)
  end

  def edit
    @anime = Anime.find(params[:id])
    if @anime.user != current_user
      redirect_to user_path(current_user), alear: '不正なアクセスです。'
    end
  end

  def update
    @anime = Anime.find(params[:id])
    if @anime.update(anime_params)
      redirect_to user_path(current_user), notice: '更新に成功しました。'
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
      params.require(:anime).permit(:title, :thought, :anime_image, :rate)
    end
end
