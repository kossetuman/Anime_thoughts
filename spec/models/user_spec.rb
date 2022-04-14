require 'rails_helper'

RSpec.describe User, type: :model do
    describe 'Userモデルのテスト' do
      subject {user.valid? }

      let(:user) { build(:user) }

    #   it "名がない場合、無効である"
    #   it "メールアドレスがない場合、無効である"
    #   it "重複したメールアドレスの場合、無効である"
    #   it "パスワードがない場合、無効である"


    context 'nameカラム' do
      it '空欄でないこと' do
        user.name=''
        is_expected.to eq false
     end
     it '8文字以下であること: 8文字は〇' do
        user.name = Faker::Lorem.characters(number: 8)
        is_expected.to eq true
     end
    end

     context 'emailカラム' do
      it '空欄でないこと' do
        user.email=''
        is_expected.to eq false
      end
      it '重複していない' do
        User.create(
      email: "user1@user.com",
      password: "user1pass",
      )
      user = User.new(
        email: "user1@user.com",
        password: "user2pass",
      )
      user.valid?
      end
    end

    context 'passwordカラム' do
      it 'パスワードがない場合は無効' do
        user.password = ''
        is_expected.to eq false
      end
    end
  end


  describe 'アソシエーションのテスト' do
    context 'Animeモデルとの関係' do
      it '1:Nになっている' do
        expect(User.reflect_on_association(:animes).macro).to eq :has_many
      end
    end
    context 'Commentモデルとの関係' do
      it '1:Nになっている' do
        expect(User.reflect_on_association(:comments).macro).to eq :has_many
      end
    end
    context 'Likeモデルとの関係' do
      it '1:Nになっている' do
        expect(User.reflect_on_association(:likes).macro).to eq :has_many
      end
    end
    context 'Relationshipモデルとの関係' do
      it 'rerashionshipモデルと1:Nになっている' do
        expect(User.reflect_on_association(:relationships).macro).to eq :has_many
      end
      it 'followingsモデルと1:Nになっている' do
        expect(User.reflect_on_association(:followings).macro).to eq :has_many
      end
      it 'reverse_of_relationshipsモデルと1:Nになっている' do
        expect(User.reflect_on_association(:reverse_of_relationships).macro).to eq :has_many
      end
      it 'followersモデルと1:Nになっている' do
        expect(User.reflect_on_association(:reverse_of_relationships).macro).to eq :has_many
      end
    end
    
    context 'Notificationモデルとの関係' do
      it ':active_notificationsモデルと1:Nになっている' do
        expect(User.reflect_on_association(:active_notifications).macro).to eq :has_many
      end
       it 'passive_notifications1:Nになっている' do
        expect(User.reflect_on_association(:passive_notifications).macro).to eq :has_many
      end
    end
 
  end
end