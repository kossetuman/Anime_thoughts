# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

user1 = User.find_by(email: "test1@gmail.com") == nil ? User.create!(name: "hoge1", email: "test1@gmail.com", password: "111111") : User.find_by(email: "test1@gmail.com")
user2 = User.find_by(email: "test2@gmail.com") == nil ? User.create!(name: "hoge2", email: "test2@gmail.com", password: "222222") : User.find_by(email: "test2@gmail.com")
user3 = User.find_by(email: "test3@gmail.com") == nil ? User.create!(name: "hoge3", email: "test3@gmail.com", password: "333333", image: File.open("./app/assets/images/chara.jpg")) : User.find_by(email: "test3@gmail.com")


Anime.create!(user: user1, title: "魔法少女まどかマギカ", thought: "最高でした。作品途中に若干のグダリはありますが、基本的にはスムーズに展開が進んでいきます。是非たくさんの人に見てみて貰いたい作品です。", rate: "3.0")
Anime.create!(user: user2, title: "魔法少女リリカルなのは")
Anime.create!(user: user3, title: "魔法使いサリー")




