# rubocop: disable Metrics/CyclomaticComplexity Metrics/MethodLength
require 'telegram/bot'
require_relative 'catalogue'
require 'dotenv'
Dotenv.load('./lib/key.env')

class BirdBot
  def text_start
    tx1 = 'If you want to buy a single wine bottle, you can type /single;'
    tx2 = 'if you want a box with 12 bottles /box;'
    tx3 = 'if you wanted some combos type /combo,'
    tx4 = 'if you want a complete bill description type /car'
    @n = "#{tx1} #{tx2} #{tx3} and #{tx4} if you want to finish this chat, you can type /stop"
  end

  def api_send(bird, type, type2, msg, bill_var)
    name = type.text.gsub('/', '')
    tx_cho = 'you choose a wine'
    bird.api.send_message(chat_id: type.chat.id, text: "#{tx_cho} #{msg} #{name}")
    bill_var << Wine.car?(type2, name)
  end

  def previous_back(bird, type)
    bird.api.send_message(chat_id: type.chat.id, text: 'now you can move to previues directories ')
    bird.api.send_message(chat_id: type.chat.id, text: text_start)
  end

  def send_option_message(bird, type, option, info)
    case type
    when 1
      tex_p1 = 'You chose boxes catalog, here exist these options, '
      tex_p2 = 'you can select one option using code in the right \n '
    when 2
      tex_p1 = 'You chose combo catalogue, there exist this options, '
      tex_p2 = 'you can select one option using code in the right \n'
    when 3
      tex_p1 = 'You chose single catalogue, there exist this options, '
      tex_p2 = 'you can select one option using code in the right \n'
    end
    tex_p3 = "#{option.show_box}, if you want to go back to the previous menu type '/back'"
    tex_box = tex_p1 + tex_p2 + tex_p3
    bird.api.send_message(chat_id: info.chat.id, text: tex_box)
  end

  def box_menu(bird, option, info)
    @type = 1
    @option = option
    send_option_message(bird, @type, @option, info)
    bird.listen do |type|
      case type.text
      when '/corozo'
        msg = 'bottle of the strongs'
        api_send(bird, type, @type, msg, bill_var)
      when '/mango'
        msg = 'bottles of sweets'
        api_send(bird, type, @type, msg, bill_var)
      when '/lulo'
        msg = 'bottles of not acids'
        api_send(bird, type, @type, msg, bill_var)
      when '/guayaba'
        msg = 'bottles of exotics'
        api_send(bird, type, @type, msg, bill_var)
      when '/back'
        previous_back(bird, type)
        break
      end
    end
  end

  def combo_menu(bird, option, info)
    @type = 2
    send_option_message(bird, @type, option, info)
    bird.listen do |type|
      case type.text
      when '/portrait'
        msg = 'bottle and a beatifull'
        api_send(bird, type, @type, msg, bill_var)
      when '/cups'
        msg = 'bottle and 2 brilliants'
        api_send(bird, type, @type, msg, bill_var)
      when '/dinner'
        msg = 'bottle and a amaizing'
        api_send(bird, type, @type, msg, bill_var)
      when '/teddy'
        msg = 'bottle and a cute'
        api_send(bird, type, @type, msg, bill_var)
      when '/back'
        previous_back(bird, type)
        break
      end
    end
  end

  def single_menu(bird, option, info)
    @type = 3
    send_option_message(bird, @type, option, info)
    bird.listen do |type|
      case type.text
      when '/corozo'
        msg = 'bottle of the strongs'
        api_send(bird, type, @type, msg, bill_var)
      when '/mango'
        msg = 'bottle with sweets'
        api_send(bird, type, @type, msg, bill_var)
      when '/lulo'
        msg = 'bottle with of not much acids'
        api_send(bird, type, @type, msg, bill_var)
      when '/guayaba'
        msg = 'bottle with the exotics'
        api_send(bird, type, @type, msg, bill_var)
      when '/back'
        previous_back(bird, type)
        break
      end
    end
  end

  def car_menu(bird, info, bill_var)
    @items = Wine.car(bill_var)
    @total = Wine.show_bill(@items)
    if @items.empty?
      bird.api.send_message(chat_id: info.chat.id, text: "We sorry but you don't bogught nothing")
    else
      sp = Array.new(100, ' ').join('')
      @items = @items.to_s.gsub('[', '').gsub(']', '').gsub('"', '').gsub(':', '').gsub(',', ' ').gsub('//', sp)
      bird.api.send_message(chat_id: info.chat.id, text: "those are the items you bought #{sp} #{@items}")
      bird.api.send_message(chat_id: info.chat.id, text: "this is the total of your purchase $#{@total} ")
    end
  end

  def initialize
    bill_var = []
    @token = ENV['KEY_TOKEN']
    @option = Wine.new
    Telegram::Bot::Client.run(@token) do |bird|
      bird.listen do |info|
        @f_n = info.from.first_name
        @l_n = info.from.last_name
        case info.text
        when '/start'
          tx_init = ' this bot will help you to know about our products, '
          bird.api.send_message(chat_id: info.chat.id, text: "Hello, #{@g_n} #{@l_n}#{tx_init}#{text_start} ")
        when '/box'
          box_menu(bird, @option, info)
        when '/combo'
          combo_menu(bird, @option, info)
        when '/single'
          single_menu(bird, @option, info)
        when '/car'
          car_menu(bird, info, bill_var)
        when '/stop'
          bird.api.send_message(chat_id: info.chat.id, text: "Tanks to talk with me #{@f_n} #{@l_n} ")
        end
      end
    end
  end
end
# rubocop: enable Metrics/CyclomaticComplexity Metrics/MethodLength
