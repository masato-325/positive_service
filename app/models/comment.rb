class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :consultation

  validates :content, presence: true # メッセージは必須
end
