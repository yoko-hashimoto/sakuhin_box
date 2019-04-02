class Artwork < ApplicationRecord
  belongs_to :creator
  mount_uploader :image, ImageUploader

  
  acts_as_taggable_on :folders # artwork.folder_list が追加される
  
  acts_as_taggable # acts_as_taggable_on :tags のエイリアス
                   # つまり、artwork.tag_list が追加される
                   # tags のなかにIDやら名前などが入る。イメージ的には親情報。
 
  # 公開設定になっているアートワークのみ取得するメソッド where(is_published: true) をscopeとして定義する
  scope :published, -> {where(is_published: true)}
end
