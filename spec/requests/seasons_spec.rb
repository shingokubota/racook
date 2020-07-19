require "rails_helper"

RSpec.describe "季節選択", type: :request do
  let!(:user) { create(:user) }

  context "ログインしている場合" do
    before do
      login_for_request(user)
    end

    it "季節選択ページが表示されること" do
      expect(response).to redirect_to season_index_path
    end

    it "野菜を選択するとリダイレクトされること" do
      get season_path(:season_name => "january")
      expect(response).to render_template('seasons/january')
    end
  end
end
