require 'rails_helper'

RSpec.describe "Users", type: :system do
  let!(:user) { create(:user) }

  describe "ユーザー登録ページ" do
    before do
      visit signup_path
    end

    context "ページレイアウト" do
      it "「ユーザー登録」の文字列が存在することを確認" do
        expect(page).to have_content 'ユーザー登録'
      end

      it "正しいタイトルが表示されることを確認" do
        expect(page).to have_title full_title('ユーザー登録')
      end
    end

    context "ユーザー登録処理" do
      it "有効なユーザーでユーザー登録を行うとユーザー登録成功のフラッシュが表示されること" do
        fill_in "ユーザー名", with: "Example User"
        fill_in "メールアドレス", with: "user@example.com"
        fill_in "パスワード", with: "foobar"
        fill_in "パスワード（確認）", with: "foobar"
        click_button "登録する"
        expect(page).to have_content "ユーザー登録に成功しました！"
      end

      it "無効なユーザーでユーザー登録を行うとユーザー登録失敗のフラッシュが表示されること" do
        fill_in "ユーザー名", with: ""
        fill_in "メールアドレス", with: "example@example.com"
        fill_in "パスワード", with: "foobar"
        fill_in "パスワード（確認）", with: "barbaz"
        click_button "登録する"
        expect(page).to have_content "ユーザー名を入力してください"
        expect(page).to have_content "パスワード（確認）とパスワードの入力が一致しません"
      end
    end
  end

  describe "プロフィールページ" do
    context "ページレイアウト" do
      before do
        login_for_system(user)
        visit user_path(user)
      end

      it "「プロフィール」の文字列が存在することを確認" do
        expect(page).to have_content 'プロフィール'
      end

      it "正しいタイトルが表示されることを確認" do
        expect(page).to have_title full_title('プロフィール')
      end

      it "ユーザー情報が表示されることを確認" do
        expect(page).to have_content user.name
        expect(page).to have_content user.introduction
        expect(page).to have_content display_sex(user.sex)
      end

      it "プロフィール編集ページへのリンクが表示されていることを確認" do
        expect(page).to have_link "プロフィール編集", href: edit_user_path(user)
      end
    end
  end

  describe "プロフィール編集ページ" do
    before do
      login_for_system(user)
      visit user_path(user)
      click_link "プロフィール編集"
    end

    context "ページレイアウト" do
      it "正しいタイトルが表示されることを確認" do
        expect(page).to have_title full_title("プロフィール編集")
      end
    end

    it "有効なプロフィール更新を行うと、更新成功のフラッシュが表示されること" do
      fill_in "ユーザー名", with: "example user"
      fill_in "メールアドレス", with: "example@example.com"
      fill_in "自己紹介", with: "テスト"
      fill_in "性別", with: 0
      click_button "更新する"
      expect(page).to have_content "プロフィールを更新しました！"
      expect(user.reload.name).to eq "example user"
      expect(user.reload.email).to eq "example@example.com"
      expect(user.reload.introduction).to eq "テスト"
      expect(user.reload.sex).to eq 0
    end

    it "無効なプロフィール更新を行おうとすると、適切なエラーメッセージが表示されること" do
      fill_in "ユーザー名", with: ""
      fill_in "メールアドレス", with: ""
      click_button "更新する"
      expect(page).to have_content "ユーザー名を入力してください"
      expect(page).to have_content "メールアドレスを入力してください"
      expect(page).to have_content "メールアドレスは不正な値です"
      expect(user.reload.name).not.to eq ""
      expect(user.reload.email).not.to eq ""
      expect(flash[:success]).not_to be_empty
    end
  end
end
