
class CommentsController < ApplicationController
 before_action :authenticate_user!
 
  def create
    @anime = Anime.find(params[:anime_id])
    @comment = current_user.comments.new(comment_params)
    @comment.anime_id = @anime.id
    @comment.save
    redirect_back(fallback_location: root_path)
  
  end

  def edit
    @anime = Anime.find(params[:anime_id])
    @comment = Comment.find(params[:id])
    if @comment.user != current_user
      redirect_to user_path(current_user)
    end
  end  

  def update
    @anime = Anime.find(params[:anime_id])
    @comment = Comment.find(params[:id])
    if @comment.update(comment_params)
      redirect_to anime_path(@anime.id), notice: 'コメントを編集しました。'
    else
      render :edit
    end
  end

  def destroy
    Comment.find_by(id: params[:id], anime_id: [params[:anime_id]]).destroy
    redirect_to anime_path(params[:anime_id])
  end

  private

  def comment_params
    params.require(:comment).permit(:comment, :parent_id, :user_id, :anime_id)
  end

end
