require 'rails_helper'

RSpec.describe "Dishes", type: :system do
  let!(:user) { create(:user) }
  let!(:dish) { create(:dish, user: user) }

  describe "レシピ登録ページ" do
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
        expect(page).to have_content "難易度"
      end
    end

    context "レシピ登録処理" do
      it "有効な情報でレシピ登録を行うとレシピ登録成功のフラッシュが表示されること" do
        fill_in "レシピ名", with: "テスト料理"
        fill_in "説明", with: "テスト料理でございます"
        fill_in "分量", with: 2.0
        fill_in "参照用URL", with: "http://test.com"
        fill_in "調理時間", with: 40
        fill_in "難易度", with: 3
        click_button "登録する"
        expect(page).to have_content "レシピを登録しました！"
      end

      it "無効な情報でレシピ登録を行うと料理登録失敗のフラッシュが表示されること" do
        fill_in "レシピ名", with: ""
        fill_in "説明", with: "テスト料理でございます"
        fill_in "分量", with: 2.0
        fill_in "参照用URL", with: "http://test.com"
        fill_in "調理時間", with: 40
        fill_in "難易度", with: 3
        click_button "登録する"
        expect(page).to have_content "レシピ名を入力してください"
      end
    end
  end

  describe "レシピ詳細ページ" do
    context "ページレイアウト" do
      before do
        login_for_system(user)
        visit dish_path(dish)
      end

      it "正しいタイトルが表示されること" do
        expect(page).to have_title full_title("#{dish.name}")
      end

      it "レシピ情報が表示されること" do
        expect(page).to have_content dish.name
        expect(page).to have_content dish.description
        expect(page).to have_content dish.portion
        expect(page).to have_content dish.reference
        expect(page).to have_content dish.cooking_time
        expect(page).to have_content dish.popularity
      end
    end

    context "レシピの削除", js: true do
      it "削除成功のフラッシュが表示されること" do
        login_for_system(user)
        visit dish_path(dish)
        page.accept_confirm do
          click_link "削除"
        end
        expect(page).to have_content "レシピを削除しました！"
      end

      it "confirmダイアログ でキャンセルを選択した場合" do
        login_for_system(user)
        visit dish_path(dish)
        page.dismiss_confirm do
          click_link "削除"
        end
        expect(page).not_to have_content "レシピを削除しました！"
      end
    end
  end

  describe "レシピ編集ページ" do
    before do
      login_for_system(user)
      visit dish_path(dish)
      click_link "編集"
    end

    context "ページレイアウト" do
      it "正しいタイトルが表示されること" do
        expect(page).to have_title full_title("レシピ編集")
      end

      it "入力部分に適切なラベルが表示されること" do
        expect(page).to have_content "レシピ名"
        expect(page).to have_content "説明"
        expect(page).to have_content "分量[人分]"
        expect(page).to have_content "参照用URL"
        expect(page).to have_content "調理時間 [分]"
        expect(page).to have_content "難易度 [1~5]"
      end
    end

    context "レシピの更新処理" do
      it "有効な更新" do
        fill_in "レシピ名", with: "編集：テスト"
        fill_in "説明", with: "編集：テスト説明"
        fill_in "分量", with: 4
        fill_in "参照用URL", with: "http://test.hensyuu.com"
        fill_in "調理時間", with: 50
        fill_in "難易度", with: 3
        click_button "更新する"
        expect(page).to have_content "レシピ情報を更新しました！"
        expect(dish.reload.name).to eq "編集：テスト"
        expect(dish.reload.description).to eq "編集：テスト説明"
        expect(dish.reload.portion).to eq 4
        expect(dish.reload.reference).to eq "http://test.hensyuu.com"
        expect(dish.reload.cooking_time).to eq 50
        expect(dish.reload.popularity).to eq 3
      end

      it "無効な更新" do
        fill_in "レシピ名", with: ""
        click_button "更新する"
        expect(page).to have_content "レシピ名を入力してください"
        expect(dish.reload.name).not_to eq ""
      end
    end

    context "レシピの削除処理", js: true do
      it "削除成功のフラッシュが表示されること" do
        click_on "削除"
        page.driver.browser.switch_to.alert.accept
        expect(page).to have_content "レシピを削除しました！"
      end
    end
  end
end
