class ConsultationForm
  include ActiveModel::Model

  attr_accessor :title, :message, :public_status, :name, :personality, :speak_style, :business, :given_name, :age, :gender, :user_id

  def save
    return false unless valid?
    
    ActiveRecord::Base.transaction do
      character = Character.create!(name: name, personality: personality, speak_style: speak_style, business: business, given_name: given_name, age: age, gender: gender)
      @consultation = Consultation.create!(title: title, public_status: public_status, user_id: user_id, character_id: character.id, message: message)
    end
    true
  rescue ActiveRecord::RecordInvalid
    false
  end
end
