FactoryBot.define do
  factory :comment do
    association :anime
    association :user
      comment { Faker::Lorem.characters(number: 100) }
  end
end  