class Folder < ApplicationRecord
  # optional: true を付けることで、バリデーションエラーを回避
  belongs_to :creator, optional: true
  has_many :artworks

  #親子関係にある関連モデル artworks を作成する
  accepts_nested_attributes_for :artworks
  
  validates :folder_name, presence: true
end
