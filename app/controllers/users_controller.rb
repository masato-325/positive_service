# app/controllers/users_controller.rb
class UsersController < ApplicationController
include Searchable
  
  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to login_path, notice: 'ユーザー登録が完了しました'
    else
      render 'new', status: :unprocessable_entity
    end
  end

  def show # マイページ
    @user = current_user
    @consultations = @user.consultations
    @search = @consultations.ransack(search_params) # 検索オブジェクトを生成
    @search_results = @search.result.includes(:character).order(created_at: :desc) # 検索結果を取得
  end
  
  private

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end

end
