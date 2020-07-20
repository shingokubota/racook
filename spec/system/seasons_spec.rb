require "rails_helper"

RSpec.describe "Seasons", type: :system do
  let!(:user) { create(:user) }

  describe "季節選択ページ" do
    before do
      login_for_system(user)
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
        expect(page).to have_link "ほうれん草"
        expect(page).to have_content "ミズナ"
        expect(page).to have_content "ダイコン"
      end

      it "１月野菜のリンクを押すと選択した野菜名で検索されること" do
        click_link '１月'
        click_link 'ほうれん草'
        expect(page).to have_content "ほうれん草"
        click_button '検索'
        expect(page).to have_content "\"ほうれん草\"の検索結果："
      end

      it "２月野菜のリンクを押すと選択した野菜名で検索されること" do
        click_link '２月'
        click_link '芽キャベツ'
        expect(page).to have_content "芽キャベツ"
        click_button '検索'
        expect(page).to have_content "\"芽キャベツ\"の検索結果："
      end

      it "３月野菜のリンクを押すと選択した野菜名で検索されること" do
        click_link '３月'
        click_link 'ふきのとう'
        expect(page).to have_content "ふきのとう"
        click_button '検索'
        expect(page).to have_content "\"ふきのとう\"の検索結果："
      end

      it "４月野菜のリンクを押すと選択した野菜名で検索されること" do
        click_link '４月'
        click_link 'ニラ'
        expect(page).to have_content "ニラ"
        click_button '検索'
        expect(page).to have_content "\"ニラ\"の検索結果："
      end

      it "５月野菜のリンクを押すと選択した野菜名で検索されること" do
        click_link '５月'
        click_link 'わらび'
        expect(page).to have_content "わらび"
        click_button '検索'
        expect(page).to have_content "\"わらび\"の検索結果："
      end

      it "６月野菜のリンクを押すと選択した野菜名で検索されること" do
        click_link '６月'
        click_link 'アスパラ'
        expect(page).to have_content "アスパラ"
        click_button '検索'
        expect(page).to have_content "\"アスパラ\"の検索結果："
      end

      it "７月野菜のリンクを押すと選択した野菜名で検索されること" do
        click_link '７月'
        click_link 'オクラ'
        expect(page).to have_content "オクラ"
        click_button '検索'
        expect(page).to have_content "\"オクラ\"の検索結果："
      end

      it "８月野菜のリンクを押すと選択した野菜名で検索されること" do
        click_link '８月'
        click_link 'しそ'
        expect(page).to have_content "しそ"
        click_button '検索'
        expect(page).to have_content "\"しそ\"の検索結果："
      end

      it "９月野菜のリンクを押すと選択した野菜名で検索されること" do
        click_link '９月'
        click_link 'くうしんさい'
        expect(page).to have_content "くうしんさい"
        click_button '検索'
        expect(page).to have_content "\"くうしんさい\"の検索結果："
      end

      it "１０月野菜のリンクを押すと選択した野菜名で検索されること" do
        click_link '１０月'
        click_link 'さといも'
        expect(page).to have_content "さといも"
        click_button '検索'
        expect(page).to have_content "\"さといも\"の検索結果："
      end

      it "１１月野菜のリンクを押すと選択した野菜名で検索されること" do
        click_link '１１月'
        click_link 'さつまいも'
        expect(page).to have_content "さつまいも"
        click_button '検索'
        expect(page).to have_content "\"さつまいも\"の検索結果："
      end

      it "１２月野菜のリンクを押すと選択した野菜名で検索されること" do
        click_link '１２月'
        click_link 'ハクサイ'
        expect(page).to have_content "ハクサイ"
        click_button '検索'
        expect(page).to have_content "\"ハクサイ\"の検索結果："
      end
    end
  end
end
