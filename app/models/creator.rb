class Creator < ApplicationRecord
  # 複数のクリエイターは一人のユーザーに保有されている。
  # optional: true を付けることで、バリデーションエラーを回避
  belongs_to :user, optional: true
  
  # クリエイターは複数の作品を保有している
  has_many :artworks, dependent: :destroy
  has_many :folders, ->{ order(:id) }, dependent: :destroy

  validates :name, presence: true, length: { maximum: 50 }

  mount_uploader :icon, IconUploader
end
