class LoginTopController < ApplicationController
include Searchable

  def index
    @user = current_user
    @search = Consultation.public_consultations.ransack(search_params) # 検索オブジェクトを生成
    @consultations = @search.result.includes(:character) # 検索結果を取得
  end

  def policy; end

  private

  def search_params
    params.fetch(:q, {}).permit(:title_cont, :message_cont, :created_at_gteq, 
                                :character_name_cont, :character_personality_eq, 
                                :character_speak_type_eq, :character_business_eq, 
                                :character_given_name_eq, :character_age_eq)
  end

end
