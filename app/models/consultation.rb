class Consultation < ApplicationRecord
  belongs_to :user
  enum public_status: { "公開" => 0, "非公開" => 1 }, _prefix: :public_status

  # 公開された相談のみを取得するスコープ
  scope :public_consultations, -> { where(public_status: public_statuses["公開"]) }
end
