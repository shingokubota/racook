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
  end
end
