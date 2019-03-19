class Creator < ApplicationRecord
  # 複数のクリエイターは一人のユーザーに保有されている。
  # optional: true を付けることで、バリデーションエラーを回避
  belongs_to :user, optional: true
  has_many :artworks

  validates :name, presence: true

  mount_uploader :icon, IconUploader
end
