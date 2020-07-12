require 'rails_helper'

RSpec.describe Dish, type: :model do
  let!(:dish_yesterday) { create(:dish, :yesterday) }
  let!(:dish_one_month_ago) { create(:dish, :one_month_ago) }
  let!(:dish_one_year_ago) { create(:dish, :one_year_ago) }
  let!(:dish) { create(:dish) }

  context "バリデーション" do
    it "有効な状態であること" do
      expect(dish).to be_valid
    end

    it "ユーザーidがなければ無効な状態であること" do
      dish = build(:dish, user_id: nil)
      dish.valid?
      expect(dish.errors[:user_id]).to include("を入力してください")
    end

    it "名前がなければ無効な状態であること" do
      dish = build(:dish, name: nil)
      dish.valid?
      expect(dish.errors[:name]).to include("を入力してください")
    end

    it "名前が30文字以内であること" do
      dish = build(:dish, name: "a" * 31)
      dish.valid?
      expect(dish.errors[:name]).to include("は30文字以内で入力してください")
    end

    it "説明が200文字以内であること" do
      dish = build(:dish, description: "a" * 201)
      dish.valid?
      expect(dish.errors[:description]).to include("は200文字以内で入力してください")
    end

    it "人気度が数値であること" do
      dish = build(:dish, popularity: "３０")
      dish.valid?
      expect(dish.errors[:popularity]).to include("は数値で入力してください")
    end

    it "人気度が1以上でなければ無効な状態であること" do
      dish = build(:dish, popularity: 0)
      dish.valid?
      expect(dish.errors[:popularity]).to include("は1以上の値にしてください")
    end

    it "人気度が5以下でなければ無効な状態であること" do
      dish = build(:dish, popularity: 6)
      dish.valid?
      expect(dish.errors[:popularity]).to include("は5以下の値にしてください")
    end
  end

  context "並び順" do
    it "投稿が時間の早い時間順になっていること" do
      expect(dish).to eq Dish.first
    end
  end
end
