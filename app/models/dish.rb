class Dish < ApplicationRecord
  belongs_to :user
  has_many :favorites, dependent: :destroy
  has_many :ingredients, dependent: :destroy
  accepts_nested_attributes_for :ingredients
  default_scope -> { order(created_at: :desc) }
  mount_uploader :picture, PictureUploader
  validates :user_id, presence: true
  validates :name, presence: true, length: { maximum: 30 }
  validates :description, length: { maximum: 200 }
  validates :popularity, numericality: { only_integer: true,
                                         greater_than_or_equal_to: 1,
                                         less_than_or_equal_to: 5 }, allow_nil: true
  validate :picture_size

  private

    def picture_size
      if picture.size > 5.megabytes
        errors.add(:picture, ":5MBより大きい画像はアップロードできません。")
      end
    end
end
