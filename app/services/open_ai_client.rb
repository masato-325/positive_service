require 'openai'

class OpenAiClient

  def initialize
    @client = OpenAI::Client.new(access_token: ENV["OPENAI_API_KEY"])
  end

  def chat(input, character_info)
    additional_prompt = "Role-play based on these settings and turn negative thoughts into positive ones:
                        Name: #{character_info[:name]},
                        Personality: #{Character.human_attribute_name("personality.#{character_info[:personality]}")},
                        Speech style: #{Character.human_attribute_name("speak_style.#{character_info[:speak_style]}")},
                        Job: #{Character.human_attribute_name("business.#{character_info[:business]}")},
                        Pronoun: #{Character.human_attribute_name("given_name.#{character_info[:given_name]}")},
                        Age: #{Character.human_attribute_name("age.#{character_info[:age]}")},
                        Gender: #{Character.human_attribute_name("gender.#{character_info[:gender]}")}.
                        Please answer in 50 characters or less in Japanese.
                        Leave an unforgettable quote."

    
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
