class CommentsController < ApplicationController

  def create
    anime = Anime.find(params[:anime_id])
    comment = current_user.comments.new(comment_params)
    comment.anime_id = anime.id
    comment.save
    redirect_to anime_path(anime.id)  
  end

  def edit
    anime = Anime.find(params[:anime_id])
    @comment = Comment.find(params[:id])
  end

  def update
  end

  def destroy
    Comment.find_by(id: params[:id], anime_id: [params[:anime_id]]).destroy
    redirect_to anime_path(params[:anime_id])
  end

  private

  def comment_params
    params.require(:comment).permit(:comment)
  end

end
