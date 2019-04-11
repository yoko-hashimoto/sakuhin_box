class Artwork < ApplicationRecord
  belongs_to :creator
  mount_uploader :image, ImageUploader
 
  # 公開設定になっているアートワークのみ取得するメソッド where(is_published: true) をscopeとして定義する
  scope :published, -> {where(is_published: true)}
end
