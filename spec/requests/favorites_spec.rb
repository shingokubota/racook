require 'rails_helper'

RSpec.describe "Favorites", type: :request do
  let(:user) { create(:user) }
  let(:dish) { create(:dish) }

  context "お気に入り登録処理" do
    context "ログインしていない場合" do
      it "ログインページへリダイレクトすること" do
        expect {
          post "/favorites/#{dish.id}/create"
        }.not_to change(Favorite, :count)
        expect(response).to redirect_to login_path
      end

      it "お気に入りの解除かできず、ログインページへリダイレクトすること" do
        expect {
          delete "/favorites/#{dish.id}/destroy"
        }.not_to change(Favorite, :count)
        expect(response).to redirect_to login_path
      end
    end
  end
end