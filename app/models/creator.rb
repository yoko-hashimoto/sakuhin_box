class Creator < ApplicationRecord
  # 複数のクリエイターは一人のユーザーに保有されている。
  # optional: true を付けることで、バリデーションエラーを回避
  belongs_to :user, optional: true
  # クリエイターは複数の作品を保有している
  has_many :artworks

  validates :name, presence: true

  mount_uploader :icon, IconUploader
end
