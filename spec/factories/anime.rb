FactoryBot.define do
  factory :anime do
    title { Faker::Lorem.characters(number: 8) }
    thought { Faker::Lorem.characters(number: 10) }
    rate {Faker::Number.within(range: 1..5)}
    
  end
end