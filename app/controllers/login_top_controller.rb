# app/controllers/login_top_controller.rb
class LoginTopController < ApplicationController
include Searchable

  def index
    @user = current_user
    @search = Consultation.public_consultations.ransack(search_params) # 検索オブジェクトを生成
    @search_results = @search.result.includes(:character).order(created_at: :desc) # 検索結果を取得し、降順に並び替える
  end

  def policy; end

end