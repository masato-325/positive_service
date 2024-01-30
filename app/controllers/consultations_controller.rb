class ConsultationsController < ApplicationController
  before_action :set_openai_client, only: [:create, :show]
  before_action :set_consultation, only: [:show, :destroy]
  before_action :require_login, only: [:new, :create, :destroy]
  before_action :require_ownership, only: [:destroy]

  def new
    @consultation_form = ConsultationForm.new
  end

  def create
    # ConsultationForm オブジェクトを初期化
    @consultation_form = ConsultationForm.new(consultation_form_params.merge(user_id: current_user.id))
  
    # フォームから送信されたデータを使用して Character の属性を取得
    character_info = {
      name: @consultation_form.name,
      personality: @consultation_form.personality,
      speak_type: @consultation_form.speak_type,
      business: @consultation_form.business,
      given_name: @consultation_form.given_name,
      age: @consultation_form.age,
      gender: @consultation_form.gender
    }
  
    # OpenAIに問い合わせて回答を取得
    ai_response = @openai_client.chat(@consultation_form.title, character_info)
  
    # ConsultationForm オブジェクトにAIのレスポンスを追加
    @consultation_form.message = ai_response
  
    # ConsultationForm オブジェクトの保存
    if @consultation_form.save
      # 保存に成功したらそのConsultationの詳細ページへリダイレクト
      flash[:notice] = 'AIが回答しました'
      redirect_to consultation_path(@consultation_form.consultation)
    else
      # 失敗したらnewテンプレートを再表示
      render :new, status: :unprocessable_entity
    end
  end
  

  def show
    @consultation = Consultation.find(params[:id])
    @character = @consultation.character
  end

  def destroy
    # データベースから既に保存されたConsultationを削除
    @consultation = Consultation.find(params[:id])
    @consultation.destroy
    redirect_to mypage_path, notice: '相談を削除しました'
  end

  private

  def set_openai_client
    @openai_client = OpenAiClient.new
  end

  def consultation_form_params
    params.require(:consultation_form).permit(:title, :public_status, :name, :personality, :speak_type, :business, :given_name, :age, :gender)
  end
  
  def set_consultation
    @consultation = Consultation.find(params[:id])
  end

  def require_ownership
    redirect_to root_path, alert: '不正なアクセスです' unless current_user == @consultation.user
  end
end
