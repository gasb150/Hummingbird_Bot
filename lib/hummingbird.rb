require 'telegram/bot'
class BirdBot
  def initialize
    @token = '1406170037:AAEDdK8mS6tYIe3m8jkSUaJenV5rXMeSA2I'
    Telegram::Bot::Client.run(@token) do |bird|
      bird.listen do |text|
        if text == '/start'
          bot.api.send_message(chat_id: message.chat.id, text: "Hello, #{message.from.first_name} , welcome to motivation chat bot created by peter robert, the chat bot is to keep you motivated and entertained. Use  /start to start the bot,  /stop to end the bot, /motivate to get a diffrent motivational quo")
          end
        end
      end
    end
  end