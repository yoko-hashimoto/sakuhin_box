class Folder < ApplicationRecord
  belongs_to :creator
  has_many :artworks

  #親子関係にある関連モデル artworks を作成する
  accepts_nested_attributes_for :artworks
end
