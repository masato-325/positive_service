class Consultation < ApplicationRecord
  belongs_to :user
  has_many :comments, dependent: :destroy
  belongs_to :character
  enum public_status: { "公開" => 0, "非公開" => 1 }, _prefix: :public_status

  validates :title, presence: true # タイトルは必須

  def self.ransackable_attributes(auth_object = nil)
    %w[title message public_status created_at updated_at]
  end

  def self.ransackable_associations(auth_object = nil)
    # 検索可能な関連付けを設定
    super + ['character', 'comments', 'user']
  end

  # 公開された相談のみを取得するスコープ
  scope :public_consultations, -> { where(public_status: public_statuses["公開"]) }
end