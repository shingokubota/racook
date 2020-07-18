require "rails_helper"

RSpec.describe "Seasons", type: :system do
  let!(:user) { create(:user) }

  describe "季節選択ページ" do
    before do
      login_for_system(user)
      visit root_path
    end

    context "ページレイアウト" do
      it "正しいタイトルが表示されること" do
        expect(page).to have_title full_title("季節選択")
      end

      it "各月が表示されること" do
        expect(page).to have_content "１月"
        expect(page).to have_content "２月"
        expect(page).to have_content "３月"
        expect(page).to have_content "４月"
        expect(page).to have_content "５月"
        expect(page).to have_content "６月"
        expect(page).to have_content "７月"
        expect(page).to have_content "８月"
        expect(page).to have_content "９月"
        expect(page).to have_content "１０月"
        expect(page).to have_content "１１月"
        expect(page).to have_content "１２月"
        expect(page).to have_link "１月"
        expect(page).to have_link "２月"
        expect(page).to have_link "３月"
        expect(page).to have_link "４月"
        expect(page).to have_link "５月"
        expect(page).to have_link "６月"
        expect(page).to have_link "７月"
        expect(page).to have_link "８月"
        expect(page).to have_link "９月"
        expect(page).to have_link "１０月"
        expect(page).to have_link "１１月"
        expect(page).to have_link "１２月"
      end

      it "各月のリンクをクリックすると各月のページへ飛ぶこと" do
        click_link '１月'
        expect(page).to have_content "ほうれん草"
      end
    end
  end
end
