class TopController < ApplicationController
  def index
    @public_consultations = Consultation.public_consultations
  end

  def policy; end
end
