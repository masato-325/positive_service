require 'openai'

class OpenAiClient

  def initialize
    @client = OpenAI::Client.new(access_token: ENV["OPENAI_API_KEY"])
  end

  def chat(input, character_info)
    additional_prompt = "以下の設定になりきって ロールプレイをして、どんなネガティブな思考もポジティブなものに変えましょう。
                        あなたの名前は 「#{character_info[:name]}」です。
                        あなたの性格は 「#{character_info[:personality]}」です。
                        あなたの話し方は 「#{character_info[:speak_type]}」です。
                        あなたは私の 「#{character_info[:business]}」です。
                        あなたの一人称は 「#{character_info[:given_name]}」です。
                        あなたの年齢は 「#{character_info[:age]}」です。
                        あなたの性別は 「#{character_info[:gender]}」です。
                        日本語で60文字以内で、答えてください。
                        簡単に自己紹介をしてください。
                        相談者が忘れられない名言を必ず「」で囲んで残してください。"

    
    response = @client.chat(
      parameters: {
          model: "gpt-3.5-turbo",
          #max_tokens: 300,
          temperature: 0.9,
          messages: [
            { role: "system", content: additional_prompt },
            { role: "user", content: input },
          ],
      })
    Rails.logger.info("OpenAI Response: #{response.inspect}")
    response.dig("choices", 0, "message", "content")
  end
end
