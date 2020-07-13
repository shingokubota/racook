require 'rails_helper'

RSpec.describe "静的ページ", type: :system do
  describe "トップページ" do
    context "ページ全体" do
      before do
        visit root_path
      end

      it "ラクックの文字列が存在することを確認" do
        expect(page).to have_content 'ラクック'
      end

      it "正しいタイトルが表示されることを確認" do
        expect(page).to have_content full_title
      end

      it "利用規約の文字列が存在することを確認" do
        expect(page).to have_content "利用規約"
      end
    end
  end

  describe "ヘルプページ" do
    before do
      visit about_path
    end

    it "「ラクックとは」の文字列が存在することを確認" do
      expect(page).to have_content 'ラクックとは'
    end

    it "正しいタイトルが表示されることを確認" do
      expect(page).to have_title full_title('ラクックとは')
    end
  end

  describe "利用規約ページ" do
    before do
      visit terms_path
    end

    it "利用規約の文字列が存在することを確認" do
      expect(page).to have_content '利用規約'
    end

    it "正しいタイトルが表示されることを確認" do
      expect(page).to have_title full_title('利用規約')
    end

    it "正しく内容が表示されること" do
      expect(page).to have_content "第1条（適用）"
    end
  end

  context "料理のフィード", js: true do
    let!(:user) { create(:user) }
    let!(:dish) { create(:dish, user: user) }
    before do
      login_for_system(user)
    end

    it "料理のページネーションが表示されること" do
      create_list(:dish, 6, user: user)
      visit root_path
      expect(page).to have_content "みんなの料理（#{user.dishes.count}）"
      expect(page).to have_css "div.pagination"
      Dish.take(5).each do |d|
        expect(page).to have_link d.name
      end
    end

    it "「レシピを登録する」リンクが登録されること" do
      visit root_path
      expect(page).to have_link "レシピを登録する", href: new_dish_path
    end

    it "レシピを削除後、削除成功のフラッシュが表示されること" do
      visit root_path
      click_on "削除"
      page.driver.browser.switch_to.alert.accept
      expect(page).to have_content "レシピを削除しました！"
    end
  end
end
