require 'rails_helper'

RSpec.describe "Dishes", type: :system do
  let!(:user) { create(:user) }
  let!(:other_user) { create(:user) }
  let!(:dish) { create(:dish, :picture, :ingredients, user: user) }

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
        expect(page).to have_css 'label[for=dish_ingredients_attributes_0_name]',
                                 text: "材料（10種類まで）", count: 1
        expect(page).to have_css 'label[for=dish_ingredients_attributes_0_quantity]',
                                 text: "量", count: 1
      end

      it "材料入力部分が10行表示されること" do
        expect(page).to have_css "input.ingredient_name", count: 10
        expect(page).to have_css "input.ingredient_quantity", count: 10
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
        attach_file "dish[picture]", "#{Rails.root}/spec/fixtures/test_dish.jpg"
        fill_in "dish[ingredients_attributes][0][name]", with: "豆腐"
        fill_in "dish[ingredients_attributes][0][quantity]", with: "2個"
        click_button "登録する"
        expect(page).to have_content "レシピを登録しました！"
      end

      it "画像無しで登録すると、デフォルト画像が割り当てられること" do
        fill_in "レシピ名", with: "テストレシピ"
        fill_in "調理時間", with: 30
        click_button "登録する"
        expect(page).to have_link(href: dish_path(Dish.first))
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
        expect(page).to have_content "★" * dish.popularity + "☆" * (5 - dish.popularity)
        dish.ingredients.each do |i|
          expect(page).to have_content i.name
          expect(page).to have_content i.quantity
        end
        expect(page).to have_link nil, href: dish_path(dish), class: "dish-picture"
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
        expect(page).to have_css "p.title-ingredient-name", text: "材料（10種類まで）", count: 1
        expect(page).to have_css "p.title-ingredient-quantity", text: "量", count: 1
      end

      it "材料入力部分が10行表示されること" do
        expect(page).to have_css "input.ingredient_name", count: 10
        expect(page).to have_css "input.ingredient_quantity", count: 10
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
        fill_in "dish[ingredients_attributes][0][name]", with: "編集-イカ"
        fill_in "dish[ingredients_attributes][0][quantity]", with: "編集-3枚"
        attach_file "dish[picture]", "#{Rails.root}/spec/fixtures/test_dish.jpg"
        click_button "更新する"
        expect(page).to have_content "レシピ情報を更新しました！"
        expect(dish.reload.name).to eq "編集：テスト"
        expect(dish.reload.description).to eq "編集：テスト説明"
        expect(dish.reload.portion).to eq 4
        expect(dish.reload.reference).to eq "http://test.hensyuu.com"
        expect(dish.reload.cooking_time).to eq 50
        expect(dish.reload.popularity).to eq 3
        expect(dish.reload.picture.url).to include "test_dish.jpg"
        expect(dish.reload.ingredients.first.name).to eq "編集-イカ"
        expect(dish.reload.ingredients.first.quantity).to eq "編集-3枚"
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

  context "検索機能" do
    context "ログインしている場合" do
      before do
        login_for_system(user)
        visit root_path
      end

      it "ログイン後の各ページに検索窓が表示されていること" do
        expect(page).to have_css "form#dish_search"
        visit about_path
        expect(page).to have_css "form#dish_search"
        visit terms_path
        expect(page).to have_css "form#dish_search"
        visit users_path
        expect(page).to have_css "form#dish_search"
        visit user_path(user)
        expect(page).to have_css "form#dish_search"
        visit edit_user_path(user)
        expect(page).to have_css "form#dish_search"
        visit following_user_path(user)
        expect(page).to have_css "form#dish_search"
        visit followers_user_path(user)
        expect(page).to have_css "form#dish_search"
        visit dishes_path
        expect(page).to have_css "form#dish_search"
        visit dish_path(dish)
        expect(page).to have_css "form#dish_search"
        visit new_dish_path
        expect(page).to have_css "form#dish_search"
        visit edit_dish_path(dish)
        expect(page).to have_css "form#dish_search"
      end

      it "フィードの中から検索ワードに該当する結果が表示されること" do
        create(:dish, name: "肉じゃが", user: user)
        create(:dish, name: "肉炒め", user: other_user)
        create(:dish, name: "もやし料理", user: user)
        create(:dish, name: "もやし炒め", user: other_user)
        # 誰もフォローしない場合
        fill_in "q_name_or_ingredients_name_cont", with: "肉"
        click_button "検索"
        expect(page).to have_css "h3", text: "\"肉\"の検索結果：2件"
        within find(".dishes") do
          expect(page).to have_css "li", count: 2
        end
        fill_in "q_name_or_ingredients_name_cont", with: "もやし"
        click_button "検索"
        expect(page).to have_css "h3", text: "\"もやし\"の検索結果：1件"
        within find(".dishes") do
          expect(page).to have_css "li", count: 1
        end

        # othre_userをフォローする場合
        user.follow(other_user)
        fill_in "q_name_or_ingredients_name_cont", with: "肉"
        click_button "検索"
        expect(page).to have_css "h3", text: "\"肉\"の検索結果：3件"
        within find(".dishes") do
          expect(page).to have_css "li", count: 3
        end
        fill_in "q_name_or_ingredients_name_cont", with: "もやし"
        click_button "検索"
        expect(page).to have_css "h3", text: "\"もやし\"の検索結果：2件"
        within find(".dishes") do
          expect(page).to have_css "li", count: 2
        end

        # 材料も含めて検索に引っかかること
        create(:ingredient, name: "豚肉", dish: Dish.first)
        fill_in "q_name_or_ingredients_name_cont", with: "豚"
        click_button "検索"
        expect(page).to have_css "h3", text: "\"豚\"の検索結果：1件"
        within find(".dishes") do
          expect(page).to have_css "li", count: 1
        end
      end

      it "検索ワードを入れずに検索ボタンを押した場合、レシピ一覧が表示されること" do
        fill_in "q_name_or_ingredients_name_cont", with: ""
        click_button "検索"
        expect(page).to have_css "h3", text: "レシピ一覧"
        within find(".dishes") do
          expect(page).to have_css "li", count: Dish.count
        end
      end
    end

    context "ログインしていない場合" do
      it "検索窓が表示されないこと" do
        visit root_path
        expect(page).not_to have_css "form.dish_search"
      end
    end
  end
end
