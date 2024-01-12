class LoginTopController < ApplicationController
include Searchable

  def index
    @user = current_user
    @search = Consultation.public_consultations.ransack(search_params) # 検索オブジェクトを生成
    @consultations = @search.result.includes(:character) # 検索結果を取得
  end

  def policy; end

end
