class ConsultationsController < ApplicationController
  def new
    # 新しい質問のフォームを表示
  end

  def create
    # ここでデータを受け取り、showアクションへリダイレクト
    redirect_to consultation_show_path(params: consultation_params)
  end

  def show
    client = OpenAiClient.new
    input = params[:input]

    character_info = {
      personality: params[:personality],
      speak_style: params[:speak_style],
      business: params[:business],
      given_name: params[:given_name],
      age: params[:age],
      gender: params[:gender]
    }

    @response = client.chat(input, character_info)
  end

  private

  def consultation_params
    params.permit(:input, :personality, :speak_style, :business, :given_name, :age, :gender)
  end
end
