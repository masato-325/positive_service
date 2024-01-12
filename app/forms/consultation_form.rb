class ConsultationForm
  include ActiveModel::Model

  attr_accessor :title, :message, :public_status, :name, :personality, :speak_type, :business, :given_name, :age, :gender, :user_id
  attr_reader :consultation

  def save
    return false unless valid?
    
    ActiveRecord::Base.transaction do
      character = Character.create(name: name, personality: personality, speak_type: speak_type, business: business, given_name: given_name, age: age, gender: gender)
      @consultation = Consultation.create(title: title, public_status: public_status, user_id: user_id, character_id: character.id, message: message)
    end
    true
  rescue ActiveRecord::RecordInvalid
    false
  end

  def consultation
    @consultation
  end
end
