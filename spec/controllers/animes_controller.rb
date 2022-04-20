require 'rails_helper'

RSpec.describe AnimesController, type: :controller do
  before do
    @anime = FactoryBot.create(:anime)
    @another_anime = FactoryBot.create(:another_anime)
  end

  describe 'FactoryBot' do
    it '適切に設定されているか？' do
      expect(FactoryBot.build(:anime)).to be_valid
      expect(FactoryBot.build(:another_anime)).to be_valid
    end
  end

  describe '#index' do
    context 'ログインユーザーの場合' do
      it '正常なレスポンスか？' do
        sign_in @anime.user
        get :index
        expect(response).to be_success
      end
      it '200レスポンスが返ってきているか？' do
        sign_in @anime.user
        get :index
        expect(response).to have_http_status '200'
      end
    end
    context '非ログインユーザーの場合' do
      it '正常なレスポンスが返ってきていないか？' do
        get :index
        expect(response).to_not be_success
      end
      it '302レスポンスが返ってきているか？' do
        get :index
        expect(response).to have_http_status '302'
      end
       it "ログイン画面にリダイレクトされているか？" do
        get :index
        expect(response).to redirect_to "/users/sign_in"
      end
    end
  end

  describe '#create' do
    context 'ログインユーザーの場合' do
      it '正常にアニメを新規投稿できるか？' do
        sign_in @anime.user
        expect {
          post :create, params: {
            anime: {
              title: "test",
              thought: "hoge",
              rate: 1,
              user_id: 1
            }
          }
        }.to change(Anime, :count).by(1)
      end
      it '新規投稿後にanime/show画面にリダイレクトされているか？' do
        sign_in @anime.user
        post :create, params: {
          anime: {
            title: "test",
            thought: "hoge",
            rate: 1,
            user_id: 1,
          }
        }
        @animetest = Anime.last
        # p '--------'
        # p @animetest
        # p "--------"
        expect(response).to redirect_to "/animes/#{@animetest.id}"
      end
      it '不正な投稿は作成できなくなっているか？' do
        sign_in @anime.user
        expect {
          post :create, params: {
            anime: {
              title: '',
              thought: "hoge",
              rate: 1,
              user_id: 1
            }
          }
        }.to_not change(Anime, :count)
      end
      it "302レスポンスが返ってきているか？" do
        get :create
        expect(response).to have_http_status "302"
      end
    end
  end

  describe "#show" do
    context 'ログインユーザーの場合' do
      it '正常なレスポンスか？' do
        sign_in @anime.user
        get :show, params: { id: @anime.id }
        expect(response).to be_success
      end
      it '200レスポンスが返ってきているか？' do
        sign_in @anime.user

        expect(response).to have_http_status "200"
      end
    end
    context '非ログインユーザーの場合' do
       it '正常なレスポンスが返ってきていないか？' do
        get :show, params: { id: @anime.id }
        expect(response).to_not be_success
      end
      it '302レスポンスが返ってきているか？' do
        get :show, params: { id: @anime.id }
        expect(response).to have_http_status "302"
      end
      it "ログイン画面にリダイレクトされているか？" do
        get :show, params: { id: @anime.id }
        expect(response).to redirect_to "/users/sign_in"
      end
    end
  end

  describe '#edit' do
     context 'ログインユーザーの場合' do
      it '正常なレスポンスか？' do
        sign_in @anime.user
        get :edit, params: { id: @anime.id }
        expect(response).to be_success
      end
      it '200レスポンスが返ってきているか？' do
        sign_in @anime.user
        get :edit, params: { id: @anime.id }
        expect(response).to have_http_status "200"
      end
    end
    context '非ログインユーザーの場合' do
       it '正常なレスポンスが返ってきていないか？' do
        get :edit, params: { id: @anime.id }
        expect(response).to_not be_success
      end
      it '302レスポンスが返ってきているか？' do
        get :edit, params: { id: @anime.id }
        expect(response).to have_http_status "302"
      end
      it "ログイン画面にリダイレクトされているか？" do
        get :edit, params: { id: @anime.id }
        expect(response).to redirect_to "/users/sign_in"
      end
    end
    describe 'current_user以外の場合' do
      it '他のユーザーが編集ボタンを押した場合、自身のUsers/showページへリダイレクトされるか？' do
        sign_in @anime.user
        get :edit, params: { id: @another_anime.id }
        expect(response).to redirect_to "/users/#{@anime.user.id}"
      end
    end
  end

  describe 'update' do
    context 'ログインユーザーの場合' do
      it '正常に投稿を更新できるか？' do
        sign_in @anime.user
        @anime_params = { title: "hoge" }
        patch :update, params: { id: @anime.id, anime: @anime_params }
        expect(@anime.reload.title).to eq "hoge"
        end
      it '投稿更新後にanimes/showにリダイレクトされるか？' do
        sign_in @anime.user
        @anime_params = { title: "hoge" }
        patch :update, params: { id: @anime.id, anime: @anime_params }
        expect(response).to redirect_to "/animes/#{@anime.id}"
      end
      it '不正な更新は出来なくなっていてanimes/editにrenderされているか？' do
        sign_in @anime.user
        @anime_params = { title: " " }
        patch :update, params: { id: @anime.id, anime: @anime_params }
        expect(response).to render_template(:edit)
      end
    end
    context '非ログインユーザーの場合' do
      it '302レスポンスが返ってきているか？' do
        get :create
        expect(response).to have_http_status "302"
      end
      it 'ログイン画面にリダイレクトされているか？' do
        get :create
        expect(response).to redirect_to "/users/sign_in"
      end
    end
  end

  describe "#destroy" do
    context "ログインユーザーの場合" do
      it "正常に投稿を削除できるか？" do
        sign_in @anime.user
        expect {
          delete :destroy, params: { id: @anime.id }
        }.to change(Anime, :count).by(-1)
      end
      it "記事の削除後にusers/showへリダイレクトされるか？" do
        sign_in @anime.user
        delete :destroy, params: { id: @anime.id }
        expect(response).to redirect_to "/users/#{@anime.user.id}"
      end
      it "投稿したユーザーだけが投稿を削除できるようになっているか？" do
        sign_in @anime.user
        expect {
          delete :destroy, params: { id: @another_anime.id }
        }.to_not change(Anime, :count)
      end
      it "投稿したユーザー以外が投稿を削除しようとすると、自身のusers/showへリダイレクトされるか？" do
        sign_in @anime.user
        delete :destroy, params: { id: @another_anime.id }
        expect(response).to redirect_to "/users/#{@anime.user.id}"
      end
      context '非ログインユーザーの場合' do
        it "302レスポンスを返すか？" do
          delete :destroy, params: { id: @anime.id }
          expect(response).to have_http_status "302"
        end
        it "ログイン画面へリダイレクトされるか？" do
          delete :destroy, params: { id: @anime.id }
          expect(response).to redirect_to "/users/sign_in"
        end
      end
    end
  end
end
