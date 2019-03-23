class Artwork < ApplicationRecord
  belongs_to :creator
  mount_uploader :image, ImageUploader
 
  # 公開設定になっているアートワークのみ取得するメソッドをscopeとして定義する
  scope :published, -> {where(is_published: true)}
end
