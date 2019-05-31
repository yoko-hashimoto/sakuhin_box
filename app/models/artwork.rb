class Artwork < ApplicationRecord
  belongs_to :creator

  # 複数のartworkは１つのfolderに属している
  # optional: true を記述する事でバリデーションエラーを回避
  belongs_to :folder, optional: true

  validates :image, presence: true
  validates :caption, presence: true
  validates :created_date, presence: true
  validates :is_published, inclusion: {in: [true, false]}

  # validateに定義したいメソッドを設定
  validate :created_date_cannot_be_in_the_future

  # 制作年月日の未来日のチェックメソッド
  def created_date_cannot_be_in_the_future
    # 制作年月日が入力済かつ未来日(現在日付より未来)
    if created_date.present? && created_date > Date.today
      # エラー対象とするプロパティ(created_date)とエラーメッセージを設定
      errors.add(:created_date, "を未来の日付で登録する事はできません")
    end
  end

  mount_uploader :image, ImageUploader
 
  # 公開設定になっているアートワークのみ取得するメソッド where(is_published: true) をscopeとして定義する
  scope :published, -> {where(is_published: true)}
end
