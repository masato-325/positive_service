class Character < ApplicationRecord
  has_many :consultations, dependent: :destroy

  enum personality: { "指定しない" => 0, "優しい" => 1, "ツンデレ" => 2, "ナルシスト" => 3, "神々しい" => 4, "プライド高め" => 5 }, _prefix: :personality #性格
  enum speak_type: { "指定しない" => 0, "高圧的" => 1, "優しい" => 2, "上品" => 3, "関西弁" => 4, "やや否定的" => 5 }, _prefix: :speak_type #話し方
  enum business: { "指定しない" => 0, "王子様" => 1, "兄貴" => 2, "侍" => 3, "神様" => 4, "お嬢様" => 5 }, _prefix: :business #職業
  enum given_name: { "私" => 0, "俺" => 1, "僕" => 2, "俺様" => 3 ,"あたい" => 4, "うち" => 5 }, _prefix: :given_name #一人称
  enum age: { "指定しない" => 0, "10代" => 1, "20代" => 2, "30代" => 3 }, _prefix: :age #年齢
  enum gender: { "指定しない" => 0, "女性" => 1, "男性" => 2 }, _prefix: :gender  #性別

  def self.ransackable_attributes(auth_object = nil)
    ["age", "business", "created_at", "gender", "given_name", "icon", "id", "name", "personality", "speak_type", "updated_at"]
  end
end
