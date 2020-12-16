require 'telegram/bot'
require_relative 'catalogue'

class BirdBot
  @@bill=0
  def initialize
    @token = '1406170037:AAEDdK8mS6tYIe3m8jkSUaJenV5rXMeSA2I'
    @option = Wine.new
    Telegram::Bot::Client.run(@token) do |bird|
      bird.listen do |info|
        case info.text
        when '/start'
          @@n = "if you want to buy single bottles of wine you can type /single, if you want a box with 12 bottles use /box if you want some combos use /combo and if you want a complete bill description use /bill"
          bird.api.send_message(chat_id: info.chat.id, text: "Hello, #{info.from.first_name} #{info.from.last_name} this bot will help you to know about our products, #{@@n} ")
        when '/box'
          @type = 1
          bird.api.send_message(chat_id: info.chat.id, text: "You chose boxes catalogue, there exist this options, you can select one option using code in the right \n #{@option.show_box}, if you want to go back to previws menu press '/back', if you want to go to the car then press '/car'")
          bird.listen do |type|
            name = type.text.gsub("/","")
            case type.text
            when '/corozo'
              bird.api.send_message(chat_id: type.chat.id, text: "you choose a wine box with 12 bottles of strongs #{name}s")
              @@bill += Wine.bill?(@type, name)
            when '/mango'
              bird.api.send_message(chat_id: type.chat.id, text: "you choose a wine box with 12 bottles of sweets #{name}s")
              @@bill += Wine.bill?(@type, name)
            when '/lulo'
              bird.api.send_message(chat_id: type.chat.id, text: "you choose a wine box with 12 bottles of and not much acids #{name}s")
              @@bill += Wine.bill?(@type, name)
            when '/guayaba'
              bird.api.send_message(chat_id: type.chat.id, text: "you choose a wine box with 12 bottles of exotics #{name}s")
              @@bill += Wine.bill?(@type, name)
            when '/back'
              bird.api.send_message(chat_id: type.chat.id, text: "now you can move to previues directories ")
              bird.api.send_message(chat_id: type.chat.id, text: "#{@@n}")          
              
              break
              
            end
          
          end

        when '/combo'
          @type = 2
          bird.api.send_message(chat_id: info.chat.id, text: "You chose combo catalogue, there exist this options, you can select one option using code in the right \n #{@option.show_combo}, if you want to go back to previws menu press '/back' ")
          bird.listen do |type|
            name = type.text.gsub("/","")
            case type.text
            when '/portrait'
              bird.api.send_message(chat_id: type.chat.id, text: "you choose a wine bottle and a beatifull #{name}")
              @@bill += Wine.bill?(@type, name)
            when '/cups'
              bird.api.send_message(chat_id: type.chat.id, text: "you choose a wine bottle and 2 brilliants#{name}")
              @@bill += Wine.bill?(@type, name)
            when '/dinner'
              bird.api.send_message(chat_id: type.chat.id, text: "you choose a wine bottle and a amaizing #{name}")
              @@bill += Wine.bill?(@type, name)
            when '/teddy'
              bird.api.send_message(chat_id: type.chat.id, text: "you choose a wine bottle and a cute #{name}")
              @@bill += Wine.bill?(@type, name)
            when '/back'
              bird.api.send_message(chat_id: type.chat.id, text: "now you can move to previues directories ")
              bird.api.send_message(chat_id: type.chat.id, text: "#{@@n}")              
              break
            end
          end




        when '/single'
          @type = 3
          bird.api.send_message(chat_id: info.chat.id, text: "You chose single catalogue, there exist this options, you can select one option using code in the right \n #{@option.show_single}, if you want to go back to previws menu press '/back' ")
          bird.listen do |type|
            name = type.text.gsub("/","")
            case type.text
            when '/corozo'
              bird.api.send_message(chat_id: type.chat.id, text: "you choose a wine bottle of a strong #{name}")
              @@bill += Wine.bill?(@type, name)
            when '/mango'
              bird.api.send_message(chat_id: type.chat.id, text: "you choose a wine bottle with a sweet #{name}")
              @@bill += Wine.bill?(@type, name)
            when '/lulo'
              bird.api.send_message(chat_id: type.chat.id, text: "you choose a wine bottle with and not much acid #{name}")
              @@bill += Wine.bill?(@type, name)
            when '/guayaba'
              bird.api.send_message(chat_id: type.chat.id, text: "you choose a wine bottle with the exotic #{name}")
              @@bill += Wine.bill?(@type, name)
            when '/back'
              bird.api.send_message(chat_id: type.chat.id, text: "now you can move to previues directories ")
              bird.api.send_message(chat_id: type.chat.id, text: "#{@@n}")            
              break
            end
          end
        when '/stop'
          x = Wine.show_bill(@@bill)
          bird.api.send_message(chat_id: info.chat.id, text: "Good bye, #{info.from.first_name} #{info.from.last_name}, your bill show you will pay $#{x}")
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
         
  