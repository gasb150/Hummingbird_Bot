# rubocop:disable Metrics/AbcSize, Metrics/CyclomaticComplexity, Metrics/MethodLength,  Metrics/BlockLength, Metrics/PerceivedComplexity
require 'telegram/bot'
require_relative 'catalogue'

class BirdBot
  def text_start
    tx1 = 'If you want to buy a single wine bottle, you can type /single;'
    tx2 = 'if you want a box with 12 bottles /box;'
    tx3 = 'if you wanted some combos type /combo,'
    tx4 = 'if you want a complete bill description type /car'
    @n = "#{tx1} #{tx2} #{tx3} and #{tx4} if you want to finish this chat, you can type /stop"
  end

  def initialize
    bill_var = []
    @token = '1406170037:AAEDdK8mS6tYIe3m8jkSUaJenV5rXMeSA2I'
    @option = Wine.new
    Telegram::Bot::Client.run(@token) do |bird|
      bird.listen do |info|
        @f_n = info.from.first_name
        @l_n = info.from.last_name
        tx_cho = 'you choose a wine'
        case info.text
        when '/start'
          tx_init = ' this bot will help you to know about our products, '
          bird.api.send_message(chat_id: info.chat.id, text: "Hello, #{@g_n} #{@l_n}#{tx_init}#{text_start} ")
        when '/box'
          @type = 1
          tex_p1 = 'You chose boxes catalog, here exist these options, '
          tex_p2 = 'you can select one option using code in the right \n '
          tex_p3 = "#{@option.show_box}, if you want to go back to the previous menu type '/back'"
          tex_box = tex_p1 + tex_p2 + tex_p3
          bird.api.send_message(chat_id: info.chat.id, text: tex_box)
          bird.listen do |type|
            name = type.text.gsub('/', '')
            case type.text
            when '/corozo'
              bird.api.send_message(chat_id: type.chat.id, text: "#{tx_cho} box with 12 bottles of strongs #{name}s")
              bill_var << Wine.car?(@type, name)
            when '/mango'
              bird.api.send_message(chat_id: type.chat.id, text: "#{tx_cho} box with 12 bottles of sweets #{name}s")
              bill_var << Wine.car?(@type, name)
            when '/lulo'
              bird.api.send_message(chat_id: type.chat.id, text: "#{tx_cho} box with 12 bottles of not acids #{name}s")
              bill_var << Wine.car?(@type, name)
            when '/guayaba'
              bird.api.send_message(chat_id: type.chat.id, text: "#{tx_cho} box with 12 bottles of exotics #{name}s")
              bill_var << Wine.car?(@type, name)
            when '/back'
              bird.api.send_message(chat_id: type.chat.id, text: 'now you can move to previues directories ')
              bird.api.send_message(chat_id: type.chat.id, text: text_start)
              break
            end
          end

        when '/combo'
          @type = 2
          tex_p1 = 'You chose combo catalogue, there exist this options, '
          tex_p2 = 'you can select one option using code in the right \n'
          tex_p3 = "#{@option.show_combo}, if you want to go back to previws menu press '/back' "
          tex_combo = tex_p1 + tex_p2 + tex_p3
          bird.api.send_message(chat_id: info.chat.id, text: tex_combo)
          bird.listen do |type|
            name = type.text.gsub('/', '')
            case type.text
            when '/portrait'
              bird.api.send_message(chat_id: type.chat.id, text: "#{tx_cho} bottle and a beatifull #{name}")
              bill_var << Wine.car?(@type, name)
            when '/cups'
              bird.api.send_message(chat_id: type.chat.id, text: "#{tx_cho} bottle and 2 brilliants#{name}")
              bill_var << Wine.car?(@type, name)
            when '/dinner'
              bird.api.send_message(chat_id: type.chat.id, text: "#{tx_cho} bottle and a amaizing #{name}")
              bill_var << Wine.car?(@type, name)
            when '/teddy'
              bird.api.send_message(chat_id: type.chat.id, text: "#{tx_cho} bottle and a cute #{name} bear")
              bill_var << Wine.car?(@type, name)
            when '/back'
              bird.api.send_message(chat_id: type.chat.id, text: 'now you can move to previues directories ')
              bird.api.send_message(chat_id: type.chat.id, text: text_start)
              break
            end
          end

        when '/single'

          @type = 3
          tex_p1 = 'You chose single catalogue, there exist this options, '
          tex_p2 = 'you can select one option using code in the right \n'
          tex_p3 = "#{@option.show_single}, if you want to go back to previws menu press /back "
          tex_single = tex_p1 + tex_p2 + tex_p3
          bird.api.send_message(chat_id: info.chat.id, text: tex_single)
          bird.listen do |type|
            name = type.text.gsub('/', '')
            case type.text
            when '/corozo'
              bird.api.send_message(chat_id: type.chat.id, text: "#{tx_cho} bottle of the strongs #{name}s")
              bill_var << Wine.car?(@type, name)
            when '/mango'
              bird.api.send_message(chat_id: type.chat.id, text: "#{tx_cho} bottle with sweets #{name}s")
              bill_var << Wine.car?(@type, name)
            when '/lulo'
              bird.api.send_message(chat_id: type.chat.id, text: "#{tx_cho} bottle with of not much acids #{name}s")
              bill_var << Wine.car?(@type, name)
            when '/guayaba'
              bird.api.send_message(chat_id: type.chat.id, text: "#{tx_cho} bottle with the exotics #{name}s")
              bill_var << Wine.car?(@type, name)
            when '/back'
              bird.api.send_message(chat_id: type.chat.id, text: 'now you can move to previues directories ')
              bird.api.send_message(chat_id: type.chat.id, text: text_start)
              break
            end
          end
        when '/car'
          p @items = Wine.car(bill_var)
          @total = Wine.show_bill(@items)
          if @items.empty?
            bird.api.send_message(chat_id: info.chat.id, text: "We sorry but you don't bogught nothing")
          else
            sp = '                                                                                     '
            p @items = @items.to_s.gsub('[', '').gsub(']', '').gsub('"', '').gsub(':', '').gsub(',', ' ').gsub('//', sp)
            bird.api.send_message(chat_id: info.chat.id, text: "those are the items you bought #{sp} #{@items}")
            bird.api.send_message(chat_id: info.chat.id, text: "this is the total of your purchase $#{@total} ")
          end
        when '/stop'
          bird.api.send_message(chat_id: info.chat.id, text: "Tanks to talk with me #{@f_n} #{@l_n} ")
        end
      end
    end
  end
end
# rubocop:enable Metrics/AbcSize, Metrics/CyclomaticComplexity, Metrics/MethodLength,  Metrics/BlockLength, Metrics/PerceivedComplexity
