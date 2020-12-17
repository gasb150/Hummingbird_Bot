# rubocop: disable Layout/LineLength, Style/ClassVars
class Wine
  attr_accessor :pasas

  @@prices = [2_000, 2_000, 3_000, 2_000]

  def self.single_bottles
    { Corozo: @@prices[0], Mango: @@prices[1], Lulo: @@prices[2], Guayaba: @@prices[3] }
  end

  def self.combo_packs
    { wine_portrait: 4_000, wine_cups: 3_000, wine_dinner: 2_323, wine_teddy: 1_231 }
  end

  def self.boxes
    { Corozo: (@@prices[0] * (1 - 0.1) * 12), Mango: (@@prices[1] * (1 - 0.1) * 12), Lulo: (@@prices[2] * (1 - 0.1) * 12), Guayaba: (@@prices[3] * (1 - 0.1) * 12) }
  end

  def show_single
    @options = Wine.single_bottles
    show_options(@options)
  end

  def show_box
    @options = Wine.boxes
    show_options(@options)
  end

  def show_combo
    @options = Wine.combo_packs
    code = @options.keys.to_s.gsub('wine_', '').gsub(':', '/').gsub('[', '').gsub(']', '').gsub(' ', '').split(',')
    show_options(@options, code)
  end

  def show_options(options, code = nil)
    @code = code
    @options = options
    if @code.nil?
      @code = @options.keys.to_s.downcase.gsub(':', '/').gsub('[', '').gsub(']', '').gsub(' ', '').split(',')
    else
      @code
    end
    @options = options
    n = 0
    y = []
    m = []
    while n < @options.keys.length
      y << [@options.keys[n], 'will cost:', @options.values[n], 'type this code to select ->', " #{@code[n]}"]
      m << y[n].join(',').gsub(',', ' ')
      n += 1
    end
    m = m.to_s.gsub(',', '                                  ').gsub('"', '').gsub('[', '').gsub(']', '').gsub('_', ' and ')
    m.to_s
  end

  def self.bill?(option, code)
    @code = code.capitalize.to_sym
    @option = option
    case @option
    when 1
      boxes[@code].to_i
    when 2
      @code = (combo_packs.keys.select { |k| k.to_s.include?(@code.to_s.downcase) }).join.to_sym
      combo_packs[@code].to_i
    when 3
      single_bottles[@code].to_i
    end
  end

  def self.show_bill(bill)
    @total = 0
    @bill = bill
    n = 0
    while n < bill.length
      @total += bill[n][2]
      n += 1
    end
    @total
  end

  def self.car?(option, code)
    @code = code.capitalize.to_sym
    @option = option
    @op = ''
    case @option
    when 1
      value = boxes[@code]
      @op = ' box of '
    when 2
      @code = (combo_packs.keys.select { |k| k.to_s.include?(@code.to_s.downcase) }).join.to_sym
      value = combo_packs[@code]
      @op = ' combo with '
    when 3
      value = single_bottles[@code]
      @op = ' single bottle of '
    end
    [@op, @code, ' by $', value, ' each one and, you have a sub-total of $']
  end

  def self.car(shopping)
    @shopping = shopping
    tye_ = @shopping.uniq
    n = 0
    arr = []
    while n < tye_.length
      number = @shopping.count(tye_[n])
      total = tye_[n][3] * number
      arr << [number, tye_[n], total, '//']
      n += 1
    end
    arr
  end
end
# rubocop: enable Layout/LineLength, Style/ClassVars
imput = [
  [' combo with ', :wine_cups, ' by $', 3_000, ' each one and, you have a sub-total of $ '],
  [' box of ', :Mango, ' by $', 21_600.0, ' each one and, you have a sub-total of $ '],
  [' combo with ', :wine_cups, ' by $', 3_000, ' each one and, you have a sub-total of $ '],
  [' single bottle of ', :Mango, ' by $', 2_000, ' each one and, you have a sub-total of $ '],
  [' box of ', :Corozo, ' by $', 2_600.0, ' each one and, you have a sub-total of $ '],
  [' combo with ', :wine_cups, ' by $', 3_000, ' each one and, you have a sub-total of $ ']
]
n = Wine.new