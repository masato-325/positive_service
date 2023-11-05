module ConsultationsHelper
  def extract_quotes_from_message(message)
    message.scan(/「(.*?)」/).flatten
  end
end