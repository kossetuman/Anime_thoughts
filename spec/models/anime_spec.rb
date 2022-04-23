require 'rails_helper'

RSpec.describe Anime, type: :model do
  describe 'Animeモデルのテスト' do
    
    subject { anime.valid? }
    let(:anime) { build(:anime) }
  
    context 'titleカラムのバリデーション' do
      it '存在していない場合は無効であること' do
        anime.title = nil
        is_expected.to eq false
      end

    end
    context 'thoughtカラムのバリデーション' do
      it '存在していない場合は無効であること' do
        anime.thought = nil
        is_expected.to eq false
      end
      it '2000文字以下であること' do
        anime.thought = Faker::Lorem.characters(number: 2000)
        is_expected.to eq true
      end  
    end
     context 'rateカラムのバリデーション' do
      it '存在していない場合は無効であること' do
        anime.rate = nil
        is_expected.to eq false
      end
    end
  end  
end