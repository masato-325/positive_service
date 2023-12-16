class UsersController < ApplicationController
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

  def show
    @user = current_user
    @consultations = @user.consultations
    @search = @consultations.ransack(params[:q])
    @results = @search.result
  end
  
  private

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end
end
