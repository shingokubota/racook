require 'rails_helper'

RSpec.describe "Dishes", type: :system do
  let!(:user) { create(:user) }

  describe "料理登録ページ" do
    before do
      login_for_system(user)
      visit new_dish_path
    end

    context "ページレイアウト" do
      it "「レシピ登録」の文字列が存在すること" do
        expect(page).to have_content "レシピ登録"
      end

      it "正しいタイトルが表示されること" do
        expect(page).to have_title full_title('レシピ登録')
      end

      it "入力部分に適切なラベルが表示されること" do
        expect(page).to have_content "レシピ"
        expect(page).to have_content "説明"
        expect(page).to have_content "分量"
        expect(page).to have_content "参照用URL"
        expect(page).to have_content "調理時間"
        expect(page).to have_content "人気度"
      end
    end

    context "レシピ登録処理" do
      it "有効な情報でレシピ登録を行うとレシピ登録成功のフラッシュが表示されること" do
        fill_in "レシピ名", with: "テスト料理"
        fill_in "説明", with: "テスト料理でございます"
        fill_in "分量", with: 2.0
        fill_in "参照用URL", with: "http://test.com"
        fill_in "調理時間", with: 40
        fill_in "人気度", with: 3
        click_button "登録する"
        expect(page).to have_content "レシピを登録しました！"
      end

      it "無効な情報でレシピ登録を行うと料理登録失敗のフラッシュが表示されること" do
        fill_in "レシピ名", with: ""
        fill_in "説明", with: "テスト料理でございます"
        fill_in "分量", with: 2.0
        fill_in "参照用URL", with: "http://test.com"
        fill_in "調理時間", with: 40
        fill_in "人気度", with: 3
        click_button "登録する"
        expect(page).to have_content "レシピ名を入力してください"
      end
    end
  end
end
