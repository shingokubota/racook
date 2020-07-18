require "rails_helper"

RSpec.describe "季節選択", type: :request do
  let!(:user) { create(:user) }

  context "ログインしている場合" do
    before do
      login_for_request(user)
    end

    it "季節選択ページが表示されること" do
      get root_path
      expect(response).to render_template("shared/_seasons")
    end
  end
end
