class Folder < ApplicationRecord
  # optional: true を付けることで、バリデーションエラーを回避
  belongs_to :creator, optional: true
  has_many :artworks

  #親子関係にある関連モデル artworks を作成する
  accepts_nested_attributes_for :artworks
  
  # validates :folder_name, presence: true

  # 独自に作成したバリデーションを設定
  validate :folder_name_valid

  # folder_name に対するバリデーションをメソッドとして独自に作成
  def folder_name_valid
    # この creator は belongs_to :creator で紐付けている creator の事。最後の folder_name はフォームで入力された folder_name の事。
    if creator.folders.where(folder_name: folder_name).any?
      errors.add(:folder_name, "はすでに存在します。")
    end
  end

end
