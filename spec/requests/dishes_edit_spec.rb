require "rails_helper"

RSpec.describe "レシピ編集", type: :request do
  let!(:user) { create(:user) }
  let!(:other_user) { create(:user) }
  let!(:dish) { create(:dish, user: user) }

  context "認可されたユーザーの場合" do
    it "レスポンスが正常に表示されること（フレンドリーフォワーディング）" do
      get edit_dish_path(dish)
      login_for_request(user)
      expect(response).to have_http_status "302"
      expect(response).to redirect_to edit_dish_url(dish)
      patch dish_path(dish), params: { dish: { name: "テスト料理",
                                               description: "テスト料理です",
                                               portion: 2.0,
                                               reference: "https://test.com",
                                               cooking_time: 40,
                                               popularity: 2 } }
      redirect_to dish
      follow_redirect!
      expect(response).to render_template("dishes/show")
    end
  end

  context "ログインしていないユーザーの場合" do
    it "ログイン画面にリダイレクトすること" do
      get edit_dish_path(dish)
      expect(response).to have_http_status "302"
      expect(response).to redirect_to login_path
      patch dish_path(dish), params: { dish: { name: "テスト料理",
                                               description: "テスト料理です",
                                               portion: 2.0,
                                               reference: "https://test.com",
                                               cooking_time: 40,
                                               popularity: 2 } }
      expect(response).to have_http_status "302"
      expect(response).to redirect_to login_path
    end
  end

  context "別アカウントのユーザーの場合" do
    it "ホーム画面にリダイレクトすること" do
      login_for_request(other_user)
      get edit_dish_path(dish)
      expect(response).to have_http_status "302"
      expect(response).to redirect_to root_path
      patch dish_path(dish), params: { dish: { name: "キムチ鍋",
                                               description: "あたたかいです",
                                               portion: 2.0,
                                               reference: "https://kimuti.test.com",
                                               cooking_time: 40,
                                               popularity: 3 } }
      expect(response).to have_http_status "302"
      expect(response).to redirect_to root_path
    end
  end
end
