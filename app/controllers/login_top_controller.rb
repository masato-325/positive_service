class LoginTopController < ApplicationController
  def index
    @search = Consultation.public_consultations.ransack(params[:q])
    @consultations = @search.result.includes(:character)
  end
  
  def policy; end
end
