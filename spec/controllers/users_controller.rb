require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  before do
    @user = FactoryBot.create(:user)
    @another_user = FactoryBot.create(:another_user)
  end

  describe 'FactoryBot' do
    it '適切に設定されているか？' do
      expect(FactoryBot.build(:user)).to be_valid
      expect(FactoryBot.build(:another_user)).to be_valid
    end
  end

  describe '#index' do
    context 'ログインユーザーの場合' do
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
    context '非ログインユーザーの場合' do
      it '正常なレスポンスが返ってきていないか？' do
        get :index
        expect(response).to_not be_success
      end
      it '302レスポンスが返ってきているか？' do
        get :index
        expect(response).to have_http_status "302"
      end
      it "ログイン画面にリダイレクトされているか？" do
        get :index
        expect(response).to redirect_to "/users/sign_in"
      end
    end
  end
  describe '#show' do
    context 'ログイン済みユーザーの場合' do
      it '正常なレスポンスか？' do
        sign_in @user
        get :show, params: {id: @user.id}
        expect(response).to be_success
      end
      it '200レスポンスが返ってきているか？' do
        sign_in @user
        expect(response).to have_http_status "200"
      end
    end
    context '非ログインユーザーの場合' do
      it '正常なレスポンスが返ってきていないか？' do
        get :show, params: {id: @user.id}
        expect(response).to_not be_success
      end
      it '302レスポンスが返ってきているか？' do
        get :show, params: {id: @user.id}
        expect(response).to have_http_status "302"
      end
      it "ログイン画面にリダイレクトされているか？" do
        get :show, params: {id: @user.id}
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
      it "ログイン画面にリダイレクトされているか？" do
        get :edit, params: {id: @user.id}
        expect(response).to redirect_to "/users/sign_in"
      end
    end
    context 'current_user以外の場合' do
      it '他のユーザーが編集ボタンを押した場合、current_userのshowページへリダイレクトされるか？' do
        sign_in @user
        get :edit, params: {id: @another_user.id}
        expect(response).to redirect_to "/users/#{@user.id}"
      end
    end
  end
  describe '#update' do
    context 'ログインユーザーの場合' do
      it '正常にユーザー情報を更新できるか？' do
        sign_in @user
        @user_params = { name: 'hoge' }
        patch :update, params: { id: @user.id, user: @user_params }
        expect(@user.reload.name).to eq 'hoge'
      end
      it 'ユーザー情報を更新した後、更新されたユーザー情報の詳細ページへリダイレクトされるか？' do
        sign_in @user
        @user_params = { name: 'hoge' }
        patch :update, params: { id: @user.id, user: @user_params }
        expect(response).to redirect_to "/users/profile/#{@user.id}"
      end
      it 'バリデーションに引っかかるユーザー情報の更新は弾かれてeditページへレンダーするか？' do
        sign_in @user
        get :edit, params: {id: @user.id}
        @user_params = { name: nil }
        patch :update, params: { id: @user.id, user: @user_params }
        expect(response).to render_template(:edit)
      end
    end
  end
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

  describe '#unsubscribe_confirmation' do
    context 'ログインユーザーの場合' do
      it '正常なレスポンスか？' do
        sign_in @user
        get :unsubscribe_confirmation
        expect(response).to be_success
      end
       it '200レスポンスが返ってきているか' do
        sign_in @user
        get :unsubscribe_confirmation
        expect(response).to have_http_status "200"
      end
    end
    context '非ログインユーザーの場合' do
      it '正常なレスポンスが返ってきていないか？' do
        get :unsubscribe_confirmation
        expect(response).to_not be_success
      end
      it '302レスポンスが返ってきているか？' do
        get :unsubscribe_confirmation
        expect(response).to have_http_status "302"
      end
      it "ログイン画面にリダイレクトされているか？" do
        get :unsubscribe_confirmation
        expect(response).to redirect_to "/users/sign_in"
      end
    end
  end

  describe '#withdrawal' do
    context 'ログインユーザーの場合' do
      it '退会処理(is_activeカラムはtrueに変更)されているか？' do
        sign_in @user
        @user_params = { is_active: true }
        patch :withdrawal, params: { id: @user.id, user: @user_params }
      end
      it '退会処理後にroot_pathへリダイレクトされているか？' do
         sign_in @user
        @user_params = { is_active: true }
        patch :withdrawal, params: { id: @user.id, user: @user_params }
        expect(response).to redirect_to root_path
      end
    end
  end
end