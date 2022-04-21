require 'rails_helper'

RSpec.describe CommentsController, type: :controller do
  before do
    @comment = FactoryBot.create(:comment)
    @anime = FactoryBot.create(:anime)
    @user = FactoryBot.create(:user)
  end

  describe 'FactoryBot' do
    it "適切に設定されているか？" do
      expect(FactoryBot.build(:comment)).to be_valid
    end
  end

  describe "#create" do
    context "ログインユーザーの場合" do
      it "正常に作成出来ているか?" do
        sign_in @comment.user
        expect {
          post :create, params: {
            anime_id: @comment.anime.id,
            comment: {
            user_id: @comment.user.id,
            comment: "test"
            }
          }
        }.to change(Comment, :count).by(1)
      end
      # it "作成後にanimes/showにリダイレクトされているか？" do
      #   sign_in @comment.user
      #   post :create, params: {
      #       anime_id: @comment.anime.id,
      #       comment: {
      #       user_id: @comment.user.id,
      #       comment: "test"
      #       }
      #     }
      #   expect(response).to redirect_to "where_i_came_from"
      # end  
    end
    # context "非ログインユーザーの場合" do
    #   it "302レスポンスが返ってきているか？" do
    #     post :create
    #     expect(response).to redirect_to "/users/sign_in"
    #   end  
    # end
  end  
    
  describe "#edit" do
    it "正常なレスポンスか？" do
      sign_in @comment.user
      get :edit, params: { anime_id: @comment.anime.id, id: @comment.id }
      expect(response).to be_success
    end 
    it "200レスポンスが返ってきているか？" do
      sign_in @comment.user
      get :edit, params: { anime_id: @comment.anime.id, id: @comment.id }
      expect(response).to have_http_status "200"
    end  
  end
  
  describe "#update" do
    context "ログインユーザーの場合" do
      it "正常に更新できるか？" do
        sign_in @comment.user
        comment_params = { comment: "hoge" }
        patch :update, params: { anime_id: @comment.anime.id, id: @comment.id, comment: comment_params }
        expect(@comment.reload.comment).to eq "hoge"
      end 
      it "更新後にanimes/showへリダイレクトされるか？" do
        sign_in @comment.user
        comment_params = { comment: "hoge" }
        patch :update, params: { anime_id: @comment.anime.id, id: @comment.id, comment: comment_params }
        expect(response).to redirect_to "/animes/#{@comment.anime.id}"
      end  
      it "validateに引っかかる不正な更新は弾かれてcomments/editへレンダーされるか？" do
        sign_in @comment.user
        comment_params = { comment: nil }
        patch :update, params: { anime_id: @comment.anime.id, id: @comment.id, comment: comment_params }
        expect(response).to render_template(:edit)
      end 
    end
    context "非ログインユーザーの場合" do
      it "302レスポンスを返すか？" do
        comment_params = { comment: "hoge" }
        patch :update, params: { anime_id: @comment.anime.id, id: @comment.id, comment: comment_params }
        expect(response).to have_http_status "302"
      end 
      it "ログイン画面へリダイレクトされるか？" do
        comment_params = { comment: "hoge" }
        patch :update, params: { anime_id: @comment.anime.id, id: @comment.id, comment: comment_params }
        expect(response).to redirect_to "/users/sign_in"
      end  
    end  
  end
  
  describe "#destroy" do
    context "ログインユーザーの場合" do
      it "正常にコメントを削除できるか？" do
        sign_in @comment.user
        expect {
          delete :destroy, params: { anime_id: @comment.anime.id, id: @comment.id}
        }.to change(@comment.user.comments, :count).by(-1)
      end 
      it "削除後にanimes/showへリダイレクトされるか？" do
        sign_in @comment.user
        delete :destroy, params: { anime_id: @comment.anime.id, id: @comment.id }
        expect(response).to redirect_to "/animes/#{@comment.anime.id}"
      end 
      # it "自身が投稿したコメントだけが削除出来るようになっているか？" do
      #   sign_in @comment.user
      #   expect {
      #     delete :destroy, params: { anime_id: @comment.anime.id, id: @comment.another_user.commnet.id }
      #   }.to_not change(Anime, :count)
      # end  
    end  
  end  
end