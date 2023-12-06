class ConsultationsController < ApplicationController
  before_action :set_openai_client, only: [:create, :show]

  def new
    # 新しい質問のフォームを表示
  end

  def create
    # フォームから送信されたデータを使用して Character の属性を取得
    character_info = {
      personality: params[:consultation][:personality],
      speak_style: params[:consultation][:speak_style],
      business: params[:consultation][:business],
      given_name: params[:consultation][:given_name],
      age: params[:consultation][:age],
      gender: params[:consultation][:gender]
    }
  
    # OpenAIに問い合わせて回答を取得
    ai_response = @openai_client.chat(params[:consultation][:title], character_info)
  
    # Consultationレコードを作成して保存
    consultation = current_user.consultations.new(consultation_params.merge(message: ai_response))
    if consultation.save
      # 保存に成功したらそのConsultationの詳細ページへリダイレクト
      flash[:notice] = '相談を投稿しました'
      redirect_to consultation_path(consultation)
    else
      # 失敗したらnewテンプレートを再表示
      render :new
    end
  end

  def show
    @consultation = Consultation.find(params[:id])
  end

  def destroy
    # データベースから既に保存されたConsultationを削除
    @consultation = Consultation.find(params[:id])
    @consultation.destroy
    redirect_to mypage_path
  end

  private

  def set_openai_client
    @openai_client = OpenAiClient.new
  end

  def consultation_params
    params.require(:consultation).permit(:title, :public_status)
  end
end
