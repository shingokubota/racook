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

    it "月を選択すると月の野菜ページが表示されること" do
      get season_path(:season_name => "january")
      expect(response).to render_template('seasons/january')
      get season_path(:season_name => "february")
      expect(response).to render_template('seasons/february')
      get season_path(:season_name => "march")
      expect(response).to render_template('seasons/march')
      get season_path(:season_name => "april")
      expect(response).to render_template('seasons/april')
      get season_path(:season_name => "may")
      expect(response).to render_template('seasons/may')
      get season_path(:season_name => "june")
      expect(response).to render_template('seasons/june')
      get season_path(:season_name => "july")
      expect(response).to render_template('seasons/july')
      get season_path(:season_name => "august")
      expect(response).to render_template('seasons/august')
      get season_path(:season_name => "september")
      expect(response).to render_template('seasons/september')
      get season_path(:season_name => "october")
      expect(response).to render_template('seasons/october')
      get season_path(:season_name => "november")
      expect(response).to render_template('seasons/november')
      get season_path(:season_name => "december")
      expect(response).to render_template('seasons/december')
    end
  end
end
