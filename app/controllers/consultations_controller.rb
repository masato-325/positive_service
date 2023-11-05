class ConsultationsController < ApplicationController
  before_action :set_openai_client, only: [:create, :show]

  def new
    # 新しい質問のフォームを表示
  end

  def create
    # OpenAIに問い合わせて回答を取得
    character_info = {
      personality: params[:personality],
      speak_style: params[:speak_style],
      business: params[:business],
      given_name: params[:given_name],
      age: params[:age],
      gender: params[:gender]
    }
    ai_response = @openai_client.chat(params[:title], character_info)

    # Consultationレコードを作成して保存
    consultation = current_user.consultations.new(title: params[:title], message: ai_response)
    if consultation.save
      # 保存に成功したらそのConsultationの詳細ページへリダイレクト
      redirect_to consultation_path(consultation)
    else
      # 失敗したらnewテンプレートを再表示
      render :new
    end
  end

  def show
    # データベースから既に保存されたConsultationを取得
    @consultation = Consultation.find(params[:id])
    @response = @consultation.message
  end

  private

  def set_openai_client
    @openai_client = OpenAiClient.new
  end

  def consultation_params
    params.require(:consultation).permit(:title, :personality, :speak_style, :business, :given_name, :age, :gender)
  end
end
