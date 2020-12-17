require 'telegram/bot'
require_relative 'catalogue'

class BirdBot
  @@n = "If you want to buy a single wine bottle, you can type /single; if you want a box with 12 bottles /box; if you wanted some combos type /combo, and if you want a complete bill description type /car if you want to finish this chat, you can type /stop"
  @@bill = Array.new
  def initialize
    @token = '1406170037:AAEDdK8mS6tYIe3m8jkSUaJenV5rXMeSA2I'
    @option = Wine.new
    Telegram::Bot::Client.run(@token) do |bird|
      bird.listen do |info|
        case info.text
        when '/start'
          bird.api.send_message(chat_id: info.chat.id, text: "Hello, #{info.from.first_name} #{info.from.last_name} this bot will help you to know about our products, #{@@n} ")
        when '/box'
          @type = 1
          bird.api.send_message(chat_id: info.chat.id, text: "You chose boxes catalog, here exist these options, you can select one option using code in the right \n #{@option.show_box}, if you want to go back to the previous menu type '/back'; if you wanted to go to the car then press '/car'")
          bird.listen do |type|
            name = type.text.gsub("/","")
            case type.text
            when '/corozo'
              bird.api.send_message(chat_id: type.chat.id, text: "you choose a wine box with 12 bottles of strongs #{name}s")
              @@bill << Wine.car?(@type, name)
              bird.api.send_message(chat_id: type.chat.id, text: " #{@@bill}s")
            when '/mango'
              bird.api.send_message(chat_id: type.chat.id, text: "you choose a wine box with 12 bottles of sweets #{name}s")
              @@bill << Wine.car?(@type, name)
            when '/lulo'
              bird.api.send_message(chat_id: type.chat.id, text: "you choose a wine box with 12 bottles of not much acids #{name}s")
              @@bill << Wine.car?(@type, name)
            when '/guayaba'
              bird.api.send_message(chat_id: type.chat.id, text: "you choose a wine box with 12 bottles of exotics #{name}s")
              @@bill << Wine.car?(@type, name)
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
              @@bill << Wine.car?(@type, name)
            when '/cups'
              bird.api.send_message(chat_id: type.chat.id, text: "you choose a wine bottle and 2 brilliants#{name}")
              @@bill << Wine.car?(@type, name)
            when '/dinner'
              bird.api.send_message(chat_id: type.chat.id, text: "you choose a wine bottle and a amaizing #{name}")
              @@bill << Wine.car?(@type, name)
            when '/teddy'
              bird.api.send_message(chat_id: type.chat.id, text: "you choose a wine bottle and a cute #{name} bear")
              @@bill << Wine.car?(@type, name)
            when '/back'
              bird.api.send_message(chat_id: type.chat.id, text: "now you can move to previues directories ")
              bird.api.send_message(chat_id: type.chat.id, text: @@n.to_s)
                
              break
            end
          end




        when '/single'
          
          @type = 3
          bird.api.send_message(chat_id: info.chat.id, text: "You chose single catalogue, there exist this options, you can select one option using code in the right \n #{@option.show_single}, if you want to go back to previws menu press /back ") 
          bird.listen do |type|
            name = type.text.gsub("/","")
            case type.text
            when '/corozo'
              bird.api.send_message(chat_id: type.chat.id, text: "you choose a wine bottle of the strongs #{name}s")
              @@bill << Wine.car?(@type, name)
            when '/mango'
              bird.api.send_message(chat_id: type.chat.id, text: "you choose a wine bottle with sweets #{name}s")
              @@bill << Wine.car?(@type, name)
            when '/lulo'
              bird.api.send_message(chat_id: type.chat.id, text: "you choose a wine bottle with of not much acids #{name}s")
              @@bill << Wine.car?(@type, name)
            when '/guayaba'
              bird.api.send_message(chat_id: type.chat.id, text: "you choose a wine bottle with the exotics #{name}s")
              @@bill << Wine.car?(@type, name)
            when '/back'
              bird.api.send_message(chat_id: type.chat.id, text: "now you can move to previues directories ")
              bird.api.send_message(chat_id: type.chat.id, text: "#{@@n}")            
              break
            end
          end
        when '/car'
          @items = Wine.car(@@bill)
          @items.nil?
          @total = Wine.show_bill(@items)
          if @itmes == []
            bird.api.send_message(chat_id: info.chat.id, text: "We sorry but you don't bogught nothing")
          else
            @items = @items.join().to_s.gsub("[","").gsub("]", "").gsub('"',"").gsub(":","")
           
            bird.api.send_message(chat_id: info.chat.id, text: "those are the items you bought #{@items}")
            bird.api.send_message(chat_id: info.chat.id, text: "this is the total of your purchase $#{@total} ")
          end
        when '/stop'
          bird.api.send_message(chat_id: info.chat.id, text: "Tanks to talk with me #{info.from.firstname} #{info.from.lastname}")
        end
      end
    end
  end
end
