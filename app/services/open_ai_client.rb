require 'openai'

class OpenAiClient

  def initialize
    @client = OpenAI::Client.new(access_token: ENV["OPENAI_API_KEY"])
  end

  def chat(input, character_info)
    additional_prompt = "以下の設定でロールプレイをして、どんなネガティブな思考をポジティブなものに変えましょう。
                        あなたの名前は 「#{character_info[:name]}」です、
                        あなたの性格は 「#{Character.human_attribute_name("personality.#{character_info[:personality]}")}」です,
                        あなたの話し方は 「#{Character.human_attribute_name("speak_type.#{character_info[:speak_type]}")}」です,
                        あなたの職業は 「#{Character.human_attribute_name("business.#{character_info[:business]}")}」です,
                        あなたの一人称は 「#{Character.human_attribute_name("given_name.#{character_info[:given_name]}")}」です,
                        あなたの年齢は 「#{Character.human_attribute_name("age.#{character_info[:age]}")}」です,
                        あなたの性別は 「#{Character.human_attribute_name("gender.#{character_info[:gender]}")}」です。
                        まず簡単に自己紹介をしてください。
                        日本語で60文字以内で答えてください。
                        あなたが可能であると判断した場合具体的な解決策を提案してください。
                        相談者が忘れられない名言を『』で囲んで残してください。"

    
    response = @client.chat(
      parameters: {
          model: "gpt-3.5-turbo",
          messages: [
            { role: "system", content: additional_prompt },
            { role: "user", content: input },
          ],
      })
    Rails.logger.info("OpenAI Response: #{response.inspect}")
    response.dig("choices", 0, "message", "content")
  end
end
