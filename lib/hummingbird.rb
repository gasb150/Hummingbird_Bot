require 'telegram/bot'
require_relative 'catalogue'

class BirdBot
  def initialize
    @token = '1406170037:AAEDdK8mS6tYIe3m8jkSUaJenV5rXMeSA2I'
    @option = Wine.new
    Telegram::Bot::Client.run(@token) do |bird|
      bird.listen do |info|
        case info.text
        when '/start'
          bird.api.send_message(chat_id: info.chat.id, text: "Hello, #{info.from.first_name} #{info.from.last_name} this bot will help you to know about our products")
        when '/combo'
          bird.api.send_message(chat_id: info.chat.id, text: "You chose combo catalogue, there exist this options, you can select one option using code in the right \n #{@option.show_combo}, if you want to go back to previws menu press '/back' ")
          bird.listen do |type|
            name = type.text.gsub("/","")
             case type.text
            
             when '/portrait'
              bird.api.send_message(chat_id: type.chat.id, text: "you choose a wine bottle and a beatifull #{name}")
            when '/cups'
              bird.api.send_message(chat_id: type.chat.id, text: "you choose a wine bottle and 2 brilliants#{name}")
            when '/dinner'
              bird.api.send_message(chat_id: type.chat.id, text: "you choose a wine bottle and a amaizing #{name}")
            when '/teddy'
              bird.api.send_message(chat_id: type.chat.id, text: "you choose a wine bottle and a cute #{name}")
            when '/back'
              bird.api.send_message(chat_id: type.chat.id, text: "now you can move to previues directories")             
              break
             end

            end
      
        when '/stop'
          bird.api.send_message(chat_id: info.chat.id, text: "Good bye, #{info.from.first_name} #{info.from.last_name}")
        end
      end
    end
  end
end

         #     ---- botones -----
      
      #  when Telegram::Bot::Types::CallbackQuery
      #   # Here you can handle your callbacks from inline buttons
      #   if info.data == 'touch'
      #     bird.api.send_message(chat_id: info.from.id, text: "Don't touch me!")
      #   end
      #  when Telegram::Bot::Types::Message
      #   kb = [
      #     Telegram::Bot::Types::InlineKeyboardButton.new(text: 'Go to Google', url: 'https://google.com'),
      #     Telegram::Bot::Types::InlineKeyboardButton.new(text: 'Touch me', callback_data: 'touch'),
      #     Telegram::Bot::Types::InlineKeyboardButton.new(text: 'Switch to inline', switch_inline_query: 'some as')
      #   ]
      #   markup = Telegram::Bot::Types::InlineKeyboardMarkup.new(inline_keyboard: kb)
      #   bird.api.send_message(chat_id: info.chat.id, text: 'Make a choice', reply_markup: markup)
      # end
         
  