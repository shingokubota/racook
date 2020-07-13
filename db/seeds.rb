User.create!(
  [
    {
      name: "テスト　花子",
      email: "test_hanako@example.com",
      password: "foobar",
      password_confirmation: "foobar",
      admin: true,
    },
    {
      name: "採用ご担当者様用",
      email: "saiyou@example.com",
      password: "password",
      password_confirmation: "password",
    },
    {
      name: "テスト　太郎",
      email: "test@example.com",
      password: "foobar",
      password_confirmation: "foobar",
    }
  ]
)

# フォロー
user1 = User.find(1)
user2 = User.find(2)
user3 = User.find(3)
user3.follow(user1)
user3.follow(user2)

# レシピ
portion = 2
description1 = "とても美味しいレシピです!"
description2 = "さっぱりした味わいでやみつきです！"
description3 = "レッツ時短！"

Dish.create!(
  [
    {
      name: "肉じゃが",
      user_id: 1,
      description: description1,
      portion: portion,
      reference: "https://cookpad.com/recipe/2766130",
      cooking_time: 30,
      popularity: 3,
      picture: open("#{Rails.root}/public/images/dish1.jpg"),
      ingredients_attributes: [
                                { name: "豚ロース肉", quantity: "300g" },
                                { name: "じゃがいも", quantity: "2個" },
                                { name: "にんじん", quantity: "1本" },
                                { name: "玉ねぎ", quantity: "1個" },
                                { name: "しょうゆ", quantity: "大さじ2" },
                                { name: "みりん", quantity: "大さじ2" },
                                { name: "酒", quantity: "大さじ2" },
                                { name: "", quantity: "" },
                                { name: "", quantity: "" },
                                { name: "", quantity: "" }
                              ],
    },
    {
      name: "焼きとうもろこし",
      user_id: 2,
      description: description2,
      portion: portion,
      reference: "https://cookpad.com/recipe/6308200",
      cooking_time: 20,
      popularity: 4,
      picture: open("#{Rails.root}/public/images/dish2.jpg"),
      ingredients_attributes: [
                                { name: "とうもろこし", quantity: "2本" },
                                { name: "オリーブオイル又はサラダ油", quantity: "小さじ1" },
                                { name: "醤油", quantity: "大さじ２分の１" },
                                { name: "砂糖", quantity: "大さじ２分の１" },
                                { name: "みりん", quantity: "大さじ２分の１" },
                                { name: "", quantity: "" },
                                { name: "", quantity: "" },
                                { name: "", quantity: "" },
                                { name: "", quantity: "" },
                                { name: "", quantity: "" }
                              ],
    },
    {
      name: "きゅうりの浅漬け",
      user_id: 3,
      description: description3,
      portion: portion,
      reference: "https://cookpad.com/recipe/6342055",
      cooking_time: 15,
      popularity: 4,
      picture: open("#{Rails.root}/public/images/dish3.jpg"),
      ingredients_attributes: [
                                { name: "キュウリ", quantity: "1本" },
                                { name: "キャベツ", quantity: "お好みの量" },
                                { name: "塩", quantity: "小さじ1/2" },
                                { name: "桜の塩漬け", quantity: "2つ" },
                                { name: "酢", quantity: "小さじ1" },
                                { name: "輪切り唐辛子", quantity: "" },
                                { name: "", quantity: "" },
                                { name: "", quantity: "" },
                                { name: "", quantity: "" },
                                { name: "", quantity: "" }
                              ],
    },
    {
      name: "バターチキンカレー",
      user_id: 1,
      description: description2,
      portion: portion,
      reference: "https://cookpad.com/recipe/6345264",
      cooking_time: 20,
      popularity: 3,
      picture: open("#{Rails.root}/public/images/dish4.jpg"),
      ingredients_attributes: [
                                { name: "鳥もも肉", quantity: "3枚（1000g）" },
                                { name: "ヨーグルト", quantity: "大さじ6" },
                                { name: "にんにく", quantity: "3片" },
                                { name: "バター（無塩）", quantity: "150g" },
                                { name: "クミンシード", quantity: "小さじ2" },
                                { name: "", quantity: "" },
                                { name: "", quantity: "" },
                                { name: "", quantity: "" },
                                { name: "", quantity: "" },
                                { name: "", quantity: "" }
                              ],
    },
    {
      name: "鶏肉となすの梅炒め",
      user_id: 2,
      description: description3,
      portion: portion,
      reference: "https://cookpad.com/recipe/6345131",
      cooking_time: 40,
      popularity: 5,
      picture: open("#{Rails.root}/public/images/dish5.jpg"),
      ingredients_attributes: [
                                { name: "鶏肉", quantity: "3本" },
                                { name: "なす", quantity: "1枚" },
                                { name: "白だし", quantity: "大さじ１" },
                                { name: "料理酒", quantity: "大さじ1/2" },
                                { name: "片栗粉", quantity: "適量" },
                                { name: "ししとう", quantity: "6本" },
                                { name: "本みりん", quantity: "大さじ2" },
                                { name: "ねり梅", quantity: "大さじ1" },
                                { name: "", quantity: "" },
                                { name: "", quantity: "" }
                              ],
    },
    {
      name: "ツナと高菜の沖縄油ソーメン",
      user_id: 3,
      description: description2,
      portion: portion,
      reference: "https://cookpad.com/recipe/6340460",
      cooking_time: 30,
      popularity: 3,
      picture: open("#{Rails.root}/public/images/dish6.jpg"),
      ingredients_attributes: [
                                { name: "ソーメン", quantity: "150g" },
                                { name: "ごま油", quantity: "60g" },
                                { name: "葱油", quantity: "10g" },
                                { name: "粗挽き黒胡麻", quantity: "少々" },
                                { name: "白だし", quantity: "20g" },
                                { name: "ツナ", quantity: "100g" },
                                { name: "揚げエシャロット", quantity: "10g" },
                                { name: "水菜カットボイル", quantity: "15g" },
                                { name: "万能ネギカット", quantity: "15g" },
                                { name: "", quantity: "" }
                              ],
    },
    {
      name: "ほうれん草とエリンギのソテー",
      user_id: 1,
      description: description3,
      portion: portion,
      reference: "https://cookpad.com/recipe/6339915",
      cooking_time: 20,
      popularity: 5,
      picture: open("#{Rails.root}/public/images/dish7.jpg"),
      ingredients_attributes: [
                                { name: "ほうれん草", quantity: "1わ" },
                                { name: "エリンギ", quantity: "オリーブ油" },
                                { name: "塩、胡椒", quantity: "適宜" },
                                { name: "醤油", quantity: "大さじ１〜" },
                                { name: "", quantity: "" },
                                { name: "", quantity: "" },
                                { name: "", quantity: "" },
                                { name: "", quantity: "" },
                                { name: "", quantity: "" },
                                { name: "", quantity: "" }
                              ],
    },
    {
      name: "コマ切れでフライパン焼肉",
      user_id: 2,
      description: description2,
      portion: portion,
      reference: "https://cookpad.com/recipe/6265051",
      cooking_time: 30,
      popularity: 4,
      picture: open("#{Rails.root}/public/images/dish8.jpg"),
      ingredients_attributes: [
                                { name: "細切れ肉", quantity: "300g" },
                                { name: "焼肉のタレ", quantity: "大さじ3" },
                                { name: "玉ねぎ", quantity: "1/3玉" },
                                { name: "ピーマン", quantity: "2個" },
                                { name: "エリンギ", quantity: "1~2本" },
                                { name: "キャベツ", quantity: "3~4枚" },
                                { name: "もやし", quantity: "1/3袋" },
                                { name: "", quantity: "" },
                                { name: "", quantity: "" },
                                { name: "", quantity: "" }
                              ],
    },
    {
      name: "サバ缶と三つ葉のスモークチーズサラダ",
      user_id: 3,
      description: description3,
      portion: portion,
      reference: "https://cookpad.com/recipe/6333100",
      cooking_time: 20,
      popularity: 5,
      picture: open("#{Rails.root}/public/images/dish9.jpg"),
      ingredients_attributes: [
                                { name: "サバの水煮缶", quantity: "1缶（200g前後）" },
                                { name: "三つ葉", quantity: "1束" },
                                { name: "スモークチーズ", quantity: "2個" },
                                { name: "醤油", quantity: "小さじ1" },
                                { name: "みりん、酢、ごま油", quantity: "小さじ1/2" },
                                { name: "ワサビ", quantity: "小さじ1/4弱" },
                                { name: "塩", quantity: "少々" },
                                { name: "砕いたアーモンドやくるみ", quantity: "好みで少し" },
                                 { name: "", quantity: "" },
                                { name: "", quantity: "" }
                              ],
    },
    {
      name: "インドのサラダ　カチュンバ",
      user_id: 1,
      description: description3,
      portion: portion,
      reference: "https://cookpad.com/recipe/6260480",
      cooking_time: 20,
      popularity: 5,
      picture: open("#{Rails.root}/public/images/dish10.jpg"),
      ingredients_attributes: [
                                { name: "きゅうり", quantity: "1/2本" },
                                { name: "にんじん", quantity: "1/6本" },
                                { name: "玉ねぎ", quantity: "1/8個" },
                                { name: "トマト", quantity: "1/2個" },
                                { name: "クミンパウダー", quantity: "小さじ１" },
                                { name: "塩", quantity: "小さじ１" },
                                { name: "マヨネーズ", quantity: "小さじ１" },
                                { name: "レモン汁", quantity: "大さじ１" },
                                { name: "ブラックペッパー", quantity: "ひとつまみ" },
                                { name: "一味唐辛子", quantity: "ひとつまみ" }
                              ],
    },
    {
      name: "タラのホイル焼き",
      user_id: 2,
      description: description1,
      portion: portion,
      reference: "https://cookpad.com/recipe/6345713",
      cooking_time: 40,
      popularity: 3,
      picture: open("#{Rails.root}/public/images/dish11.jpg"),
      ingredients_attributes: [
                                { name: "たら", quantity: "2切れ" },
                                { name: "塩胡椒", quantity: "適量" },
                                { name: "えのき", quantity: "1/4束" },
                                { name: "インゲン", quantity: "適量" },
                                { name: "ポン酢", quantity: "適量" },
                                { name: "", quantity: "" },
                                { name: "", quantity: "" },
                                { name: "", quantity: "" },
                                { name: "", quantity: "" },
                                { name: "", quantity: "" }
                              ],
    },
    {
      name: "カニと卵白の餡掛け豆腐",
      user_id: 3,
      description: description1,
      portion: portion,
      reference: "https://cookpad.com/recipe/6335371",
      cooking_time: 40,
      popularity: 4,
      picture: open("#{Rails.root}/public/images/dish12.jpg"),
      ingredients_attributes: [
                                { name: "豆腐", quantity: "150g" },
                                { name: "酒", quantity: "1" },
                                { name: "みりん", quantity: "1" },
                                { name: "醤油", quantity: "0.5" },
                                { name: "白だし", quantity: "1" },
                                { name: "塩", quantity: "すこし" },
                                { name: "カニ缶", quantity: "2/3" },
                                { name: "卵白", quantity: "ひとつ" },
                                { name: "ワケギ", quantity: "適量" },
                                { name: "片栗粉", quantity: "適量" }
                              ],
    },
    {
      name: "やみつき！無限！ネギツナご飯",
      user_id: 1,
      description: description1,
      portion: portion,
      reference: "https://cookpad.com/recipe/6327977",
      cooking_time: 20,
      popularity: 5,
      picture: open("#{Rails.root}/public/images/dish13.jpg"),
      ingredients_attributes: [
                                { name: "小葱", quantity: "1袋" },
                                { name: "ツナ缶", quantity: "1つ" },
                                { name: "ごま油", quantity: "大さじ２" },
                                { name: "めんつゆ", quantity: "小さじ１と半分" },
                                { name: "さしみ醤油", quantity: "小さじ１と半分" },
                                { name: "", quantity: "" },
                                { name: "", quantity: "" },
                                { name: "", quantity: "" },
                                { name: "", quantity: "" },
                                { name: "", quantity: "" }
                              ],
    },
    {
      name: "ラムラック",
      user_id: 2,
      description: description2,
      portion: portion,
      reference: "https://cookpad.com/recipe/6309229",
      cooking_time: 40,
      popularity: 4,
      picture: open("#{Rails.root}/public/images/dish14.jpg"),
      ingredients_attributes: [
                                { name: "羊", quantity: "5本" },
                                { name: "羊名人", quantity: "大さじ1.5" },
                                { name: "塩胡椒", quantity: "適宜" },
                                { name: "油", quantity: "大さじ1.5" },
                                { name: "", quantity: "" },
                                { name: "", quantity: "" },
                                { name: "", quantity: "" },
                                { name: "", quantity: "" },
                                { name: "", quantity: "" },
                                { name: "", quantity: "" }
                              ],
    },
    {
      name: "えのきのベーコン巻き入りおでん",
      user_id: 3,
      description: description1,
      portion: portion,
      reference: "https://cookpad.com/recipe/6335607",
      cooking_time: 50,
      popularity: 5,
      picture: open("#{Rails.root}/public/images/dish15.jpg"),
      ingredients_attributes: [
                                { name: "えのき", quantity: "1/2袋" },
                                { name: "ベーコン", quantity: "1枚" },
                                { name: "大根", quantity: "2枚" },
                                { name: "茹で卵", quantity: "2個" },
                                { name: "さつま揚げ", quantity: "2枚" },
                                { name: "ちくわ", quantity: "1本" },
                                { name: "結びしらたき", quantity: "2本" },
                                { name: "結び昆布", quantity: "2枚" },
                                { name: "", quantity: "" },
                                { name: "", quantity: "" }
                              ],
    }
  ]
)

dish3 = Dish.find(3)
dish6 = Dish.find(6)
dish12 = Dish.find(12)
dish13 = Dish.find(13)
dish14 = Dish.find(14)
dish15 = Dish.find(15)

# お気に入り登録
user3.favorite(dish13)
user3.favorite(dish14)
user1.favorite(dish15)
user2.favorite(dish12)

# 通知
user3.notifications.create(user_id: user3.id, dish_id: dish15.id,
                           from_user_id: user1.id)
user3.notifications.create(user_id: user3.id, dish_id: dish12.id,
                              from_user_id: user2.id)

