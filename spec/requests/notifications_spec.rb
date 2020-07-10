require 'rails_helper'

RSpec.describe "Notifications", type: :request do
  let!(:user) { create(:user) }
  let!(:other_user) { create(:user) }
  let!(:dish) { create(:dish, user: user) }
  let!(:other_dish) { create(:dish, user: other_user) }

  context "通知一覧ページの表示" do
    context "ログインしているユーザーの場合" do
      before do
        login_for_request(user)
      end

      it "レスポンスが正常に表示されること" do
        get notifications_path
        expect(response).to render_template("notifications/index")
      end

      context "自分以外のユーザーの料理に対して" do
        it "お気に入り登録によって通知が作成されること" do
          post "/favorites/#{other_dish.id}/create"
          expect(user.reload.notification).to be_falsey
          expect(other_user.reload.notification).to be_truthy
        end
      end

      context "自分の料理に対して" do
        it "お気に入り登録によって通知が作成されないこと" do
          post "/favorites/#{dish.id}/create"
          expect(user.reload.notification).to be_falsey
        end
      end
    end

    context "ログインしていないユーザーの場合" do
      it "ログインページへリダイレクトすること" do
        get notifications_path
        expect(response).to have_http_status "302"
        expect(response).to redirect_to login_path
      end
    end
  end
end
