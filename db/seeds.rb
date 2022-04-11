# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

user1 = User.find_by(email: "test1@gmail.com") == nil ? User.create!(name: "hoge1", email: "test1@gmail.com", password: "111111") : User.find_by(email: "test1@gmail.com")
user2 = User.find_by(email: "test2@gmail.com") == nil ? User.create!(name: "hoge2", email: "test2@gmail.com", password: "222222", image: File.open("./app/assets/images/man.png")) : User.find_by(email: "test2@gmail.com")
user3 = User.find_by(email: "test3@gmail.com") == nil ? User.create!(name: "hoge3", email: "test3@gmail.com", password: "333333", image: File.open("./app/assets/images/chara.jpg")) : User.find_by(email: "test3@gmail.com")


Anime.create!(user: user1, title: "魔法少女まどかマギカ", thought: "最高でした。作品途中に若干のグダリはありますが、基本的にはスムーズに展開が進んでいきます。本作品は見た目と内容のギャップがあるダークファンタジー的な内容のアニメです。是非たくさんの人に見てみて貰いたい作品です。作画も秀逸で短い時間の中に内容が凝縮されたすばらしい作品であすすめです！。", rate: "3.5", site_url: "https://www.madoka-magica.com/tv/" )
Anime.create!(user: user2, title: "ダンジョンに出会いを求めるのは間違っているだろうか", thought: "次々と続編が制作されているだけはある面白い作品ですね！ファンタジー、バトル好きにはもちろんラブコメ、ハーレム要素もあり、声優陣も豪華です。似たような作品も結構ありますが、この作品はそういった作品内容の作品の中でも特におすすめです！。", rate: "4.0", site_url: "https://danmachi.com/danmachi2/story/" )
Anime.create!(user: user3, title: "Angel Beats!", thought: "様々な要素を1クールに詰め込み過ぎたせいでとりわけ後半が超展開となり放映直後は賛美両論もあったが、その世界観設定自体は決して悪くなく、作画、音楽は今見ても第一級の極めて優れた出来である。本作のひとつの特徴として従来のKey作品をはじめとする美少女ゲーム的な「泣き」と「笑い」の快楽原則構造を脱構築するかのような展開が挙げられる。ある意味で本作のドラマツルギーは美少女ゲームのそれというよりも、むしろ日常系4コマ漫画のそれに近いように思える。それゆえに本作はある種の美少女ゲーム批評的な側面を持っており、また同時に美少女ゲーム的な「セカイ」から日常系的な「つながり」へと遷移したゼロ年代的想像力の総括的な側面をも持ち合わせた作品と言える。", rate: "5.0", site_url: "https://www.angelbeats.jp/chara/")




