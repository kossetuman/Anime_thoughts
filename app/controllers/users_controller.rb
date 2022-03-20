class UsersController < ApplicationController
  before_action :authenticate_user!
  
  def index
    @user = current_user
    @user_index = User.where.not(id: current_user.id)
  end
  
  def followings
    user = User.find(params[:id])
    @user = user.followings
  end 
  
  def followers
    user = User.find(params[:id])
    @user = user.followers
  end  

  def profile
    @user = User.find(params[:id])
  end

  def show
    @user = User.find(params[:id])
    @anime = Anime.new
    @anime_show = Anime.where(user_id: @user)
  end

  def edit
    @user = User.find(params[:id])
    if @user != current_user
      redirect_to user_path(current_user)
    end
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      redirect_to user_path(@user.id), notice: "ユーザー情報を更新しました。"
    else
      render :edit
    end
  end

  def destroy
    @anime = Anime.find(params[:id])
    @anime.destroy
    redirect_to root_path
  end

  def create
  end

  private

    def user_params
      params.require(:user).permit(:name, :image, :birth_date, :sex, :introduction, :is_active)
    end
end
