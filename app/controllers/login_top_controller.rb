class LoginTopController < ApplicationController
  def index
    @search = Consultation.public_consultations.ransack(search_params) # 検索オブジェクトを生成
    @consultations = @search.result.includes(:character) # 検索結果を取得
  end

  def policy; end

  private

  def search_params
    params_q = params[:q]&.delete_if { |key, value| value.blank? } # 空の検索条件は削除

    # Characterモデルの全てのenum属性に対して変換を行う
    character_enums = Character.defined_enums # enum属性の一覧を取得
    character_enums.each do |enum_name, _| # enum属性名を取得
      key = "character_#{enum_name}_eq" # 検索パラメータのキーを生成
      if params_q&.key?(key) # 検索パラメータにキーが存在する場合
        enum_value = Character.send(enum_name.pluralize)[params_q[key]] # enumの値を取得
        params_q[key] = enum_value unless enum_value.nil? # enumの値が存在する場合は検索パラメータを変換
      end
    end

    params_q # 変換した検索パラメータを返す
  end
end
