FactoryBot.define do
  factory :user, class: User do
    name { Faker::Lorem.characters(number: 8) }
    email { Faker::Internet.email }
    password { 'password' }
    password_confirmation { 'password' }
  end

  factory :another_user, class: User do
    name { Faker::Lorem.characters(number: 8) }
    email { Faker::Internet.email }
    password { 'password' }
    password_confirmation { 'password' }
  end
end