class Creator < ApplicationRecord
  # 複数のクリエイターは一人のユーザーに保有されている
  belongs_to :user
  has_many :artworks
end
