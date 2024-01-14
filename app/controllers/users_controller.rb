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
    @search = @user.consultations.ransack(search_params) # 検索オブジェクトを生成
    @results = @search.result.includes(:character) # 検索結果を取得
  end
  
  private

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end

  def search_params
    params.fetch(:q, {}).permit(:title_cont, :message_cont, :created_at_gteq, 
                                :character_name_cont, :character_personality_eq, 
                                :character_speak_type_eq, :character_business_eq, 
                                :character_given_name_eq, :character_age_eq)
  end

end
