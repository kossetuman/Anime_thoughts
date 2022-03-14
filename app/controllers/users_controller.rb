class UsersController < ApplicationController
  def index
    @user = current_user
    @user_index = User.where.not(id: current_user.id)
  end

  def profile
    @user = User.find(params[:id])
  end

  def show

  end

  def edit
    @user = User.find(params[:id])
    if @user != current_user
      redirect_to users_show_path(current_user)
    end
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      redirect_to user_path(@user.id)
    end
  end

  def create
  end

  private

    def user_params
      params.require(:user).permit(:name, :image, :birth_date, :sex, :introduction)
    end
end
