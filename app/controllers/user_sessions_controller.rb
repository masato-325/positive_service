class UserSessionsController < ApplicationController
  
  def new; end 

  def create
    @user = login(params[:email], params[:password])
    if @user
      flash[:notice] = 'ログインしました'
      redirect_back_or_to login_top_path
    else 
      flash.now[:alert] = 'メールアドレスまたはパスワードが正しくありません。'
      render :new 
    end
  end

  def destroy
    logout
    redirect_to root_path, notice: 'ログアウトしました', status: :see_other
  end
end
