FactoryBot.define do
  factory :anime, class: Anime do
    association :user
      title { Faker::Lorem.characters(number: 2000) }
      thought { Faker::Lorem.characters(number: 10) }
      rate {Faker::Number.within(range: 1..5)}
  end

   factory :another_anime, class: Anime do
    association :user
      title { Faker::Lorem.characters(number: 2000) }
      thought { Faker::Lorem.characters(number: 10) }
      rate {Faker::Number.within(range: 1..5)}
  end
end