class Character < ApplicationRecord
  has_many :consultations, dependent: :destroy

  enum personality: { "指定しない" => 0, "優しい" => 1, "ツンデレ" => 2, "ナルシスト" => 3, "神々しい" => 4, "プライド高め" => 5, "クレイジー" => 6 }, _prefix: :personality #性格
  enum speak_type: { "指定しない" => 0, "高圧的" => 1, "〜ですわ" => 2, "上品" => 3, "関西弁" => 4, "侍風" => 5 }, _prefix: :speak_type #話し方
  enum business: { "指定しない" => 0, "王子様" => 1, "兄" => 2, "姉" => 3, "神様" => 4, "お嬢様" => 5 , "親友" => 6 , "子分" => 7}, _prefix: :business #職業
  enum given_name: { "私" => 0, "俺" => 1, "僕" => 2, "俺様" => 3 ,"あたい" => 4, "うち" => 5, "妾" => 6 }, _prefix: :given_name #一人称
  enum age: { "指定しない" => 0, "10代" => 1, "20代" => 2, "30代" => 3, "40代"=> 4, "50代以上"=> 5 }, _prefix: :age #年齢
  enum gender: { "指定しない" => 0, "女性" => 1, "男性" => 2 }, _prefix: :gender  #性別

  def self.ransackable_attributes(auth_object = nil)
    ["age", "business", "created_at", "gender", "given_name", "icon", "id", "name", "personality", "speak_type", "updated_at"]
  end
end