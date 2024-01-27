require 'openai'

class OpenAiClient

  def initialize
    @client = OpenAI::Client.new(access_token: ENV["OPENAI_API_KEY"])
  end

  def chat(input, character_info)
    additional_prompt = "以下の設定になりきって ロールプレイをして、どんなネガティブな思考をポジティブなものに変えましょう。
                        あなたの名前は 「#{character_info[:name]}」です。
                        あなたの性格は 「#{character_info[:personality]}」です。
                        あなたの話し方は 「#{character_info[:speak_type]}」です。
                        あなたの職業は 「#{character_info[:business]}」です。
                        あなたの一人称は 「#{character_info[:given_name]}」です。
                        あなたの年齢は 「#{character_info[:age]}」です。
                        あなたの性別は 「#{character_info[:gender]}」です。
                        簡単に自己紹介をしてください。
                        相談者が忘れられない名言を「」で囲んで残してください。"

    
    response = @client.chat(
      parameters: {
          model: "gpt-3.5-turbo",
          max_tokens: 300,
          temperature: 0.7,
          messages: [
            { role: "system", content: additional_prompt },
            { role: "user", content: input },
          ],
      })
    Rails.logger.info("OpenAI Response: #{response.inspect}")
    response.dig("choices", 0, "message", "content")
  end
end
