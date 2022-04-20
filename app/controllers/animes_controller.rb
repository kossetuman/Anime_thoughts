class AnimesController < ApplicationController
   before_action :authenticate_user!
  def index
    @search = Anime.search(params[:q])
    @animes = @search.result(distinct: true).page(params[:page])
  end

  def create
    @anime = Anime.new(anime_params)
    @anime.user_id = current_user.id
    #byebug
    if @anime.save
      redirect_to anime_path(@anime.id), notice: '投稿に成功しました'
    else
      @user = User.find(params[:anime][:user_id])
      @anime_show = Anime.where(user_id: @user)
      @anime_show = @anime_show.page(params[:page]).per(10)
      respond_to do |format|
        format.html {render :html => "show.h"}
        format.js
      end

    end
  end

  def show
    @anime = Anime.find(params[:id]) #animeのid取得
    @comment = @anime.comments.build
    @user = User.find_by(id: @comment.user_id) #@comment(投稿コメント)に紐づいたuserのidを取得
    @comments = @anime.comments #@animeに紐づいたコメント全件取得
    @comment_reply = @anime.comments.build
    # binding.irb
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
      redirect_to anime_path(@anime.id), notice: '更新に成功しました。'
    else
      render :edit
    end
  end

  def destroy
    anime = Anime.find(params[:id])
    if anime.user == current_user
      anime.destroy
      redirect_to user_path(anime.user.id)
    else
      redirect_to user_path(current_user)
    end
  end

   private

    def anime_params
      params.require(:anime).permit(:title, :thought, :anime_image, :rate, :site_url)
    end
end
