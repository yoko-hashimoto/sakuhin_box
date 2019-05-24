class Artwork < ApplicationRecord
  belongs_to :creator

  # 複数のartworkは１つのfolderに属している
  # optional: true を記述する事でバリデーションエラーを回避
  belongs_to :folder, optional: true

  validates :image, presence: true
  validates :caption, presence: true
  validates :created_date, presence: true
  
  mount_uploader :image, ImageUploader
 
  # 公開設定になっているアートワークのみ取得するメソッド where(is_published: true) をscopeとして定義する
  scope :published, -> {where(is_published: true)}
end
