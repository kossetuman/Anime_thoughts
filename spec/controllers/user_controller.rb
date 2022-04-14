require 'rails_helper'

RSpec.describe UsersController, type: :controller do
   before do
     @user = FactoryBot.create(:user)
     @another_user = FactoryBot.create(:another_user)
   end
  describe '#index' do
    it '正常なレスポンスか？' do
      sign_in @user
      get :index
      expect(response).to be_success
    end
    it '200レスポンスが返ってきているか？' do
      sign_in @user
      expect(response).to have_http_status "200"
    end
  end
  describe '#show' do
    context 'ログイン済みユーザーの場合' do
      before do
        @user = FactoryBot.create(:user)
        @anime = @user.animes.create(
          title: "test",
          thought: "hoge",
          rate: "1",
          )
      end
      it '正常なレスポンスか？' do
        sign_in @user
        get :show, params: {id: @anime.id}
        expect(response).to be_success
      end
      it '200レスポンスが返ってきているか？' do
        sign_in @user
        expect(response).to have_http_status "200"
      end
    end
    context '非ログインユーザーの場合' do
      before do
        @anime = @user.animes.create(
          title: "test",
          thought: "hoge",
          rate: "1",
          )
      end
      it '正常なレスポンスが返ってきていないか？' do
        get :show, params: {id: @anime.id}
        expect(response).to_not be_success
      end
      it '302レスポンスが返ってきているか？' do
        get :show, params: {id: @anime.id}
        expect(response).to have_http_status "302"
      end
      it "ログイン画面にリダイレクトされているか？" do
        get :show, params: {id: @anime.id}
        expect(response).to redirect_to "/users/sign_in"
      end
    end
  end
  describe '#edit' do
    context 'ログイン済みユーザーの場合' do
      it '正常なレスポンスが返ってきているか？' do
        sign_in @user
        get :edit, params: {id: @user.id}
        expect(response).to be_success
      end
      it '200レスポンスが返ってきているか？' do
        sign_in @user
        get :edit, params: {id: @user.id}
        expect(response).to have_http_status "200"
      end
    end
    context '非ログインユーザーの場合' do
      it '正常なレスポンスが返ってきていないか？' do
        get :edit, params: {id: @user.id}
        expect(response).to_not be_success
      end
      it '302レスポンスが返ってきているか？' do
        get :edit, params: {id: @user.id}
        expect(response).to have_http_status "302"
      end
      # it '他のユーザーが編集しようとした場合,current_userのshowページへリダイレクトされるか？' do
      #   sign_in @another_user
      #   get :edit, params: {id: @another_user.id}
      #   expect(response).to redirect_to " /users/:id"
      # end
      it "ログイン画面にリダイレクトされているか？" do
        get :edit, params: {id: @user.id}
        expect(response).to redirect_to "/users/sign_in"
      end
    end
  end
  # describe '#update' do
  #   it '正常にユーザー情報を更新できるか？' do
  #     sign_in @user
  #     @user_params = { name: 'hoge' }
  #     patch :update, params: { id: @user.id }
  #     expect(@user.reload.name).to eq 'hoge'
  #   end
  # end
  describe '#profile' do
    context 'ログイン済みユーザーの場合' do
      it '正常なレスポンスか？' do
        sign_in @user
        get :profile, params: {id: @user.id}
        expect(response).to be_success
      end
      it '200レスポンスが返ってきているか' do
        sign_in @user
        get :profile, params: {id: @user.id}
        expect(response).to have_http_status "200"
      end
    end
    context '非ログインユーザーの場合' do
      it '正常なレスポンスが返ってきていないか？' do
        get :profile, params: {id: @user.id}
        expect(response).to_not be_success
      end
      it '302レスポンスが返ってきているか？' do
        get :profile, params: {id: @user.id}
        expect(response).to have_http_status "302"
      end 
      it "ログイン画面にリダイレクトされているか？" do
        get :profile, params: {id: @user.id}
        expect(response).to redirect_to "/users/sign_in"
      end
    end
  end  
end