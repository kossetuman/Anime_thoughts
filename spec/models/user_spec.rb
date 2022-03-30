require 'rails_helper'

RSpec.describe User, type: :model do
    describe 'バリデーションのテスト' do
      subject {user.valid? }

      let(:user) { build(:user) }

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
      it '1:Nになっている' do
        expect(User.reflect_on_association(:relationships).macro).to eq :has_many
      end
    end
  end
end