class Wine
  attr_accessor :pasas

    @@prices = [2000, 2000, 3000, 2000]

  def self.single_bottles
    bottles = {Corozo: @@prices[0], Mango: @@prices[1], Lulo: @@prices[2], Guayaba: @@prices[3]}
  end
  
  def self.combo_packs
    combos  = {wine_portrait: 4000, wine_cups: 3000, wine_dinner: 2323, wine_teddy: 1231}
  end
  
  def self.boxes
    mayoritario = {Corozo: @@prices[0]*(1-0.1)*12, Mango: @@prices[1]*(1-0.1)*12, Lulo: @@prices[2]*(1-0.1)*12, Guayaba: @@prices[3]*(1-0.1)*12}
  end

  def show_single()
    @options =Wine.single_bottles
    show_options(@options)
  end

  def show_box()
    @options = Wine.boxes
    show_options(@options)
  end 

  def show_combo()
    @options = Wine.combo_packs
    code = @options.keys.to_s.gsub(":", "/").gsub("wine_", "").gsub("[","").gsub("]","").gsub(" ","").split(",")
    show_options(@options,code)
  end
  
  def show_options(options,code=nil)
    @code
    if code.nil?
      @code = @options.keys.to_s.downcase.gsub(":", "/").gsub("[","").gsub("]","").gsub(" ","").split(",")
    else
      @code=code
    end
    @options=options
    n = 0
    y = []
    m = []
    while n < @options.keys.length do
    y << [@options.keys[n], "will cost:", @options.values[n], "type this code to select ->", " #{@code[n]}"]
    m << y[n].join(",").gsub(",", " ")
    n+=1
    end
    m = m.to_s.gsub("," , "\n").gsub('"',"").gsub("[","").gsub("]","").gsub("_"," and ")
    return m.to_s
  end
  
  def self.bill?(option, code)
    @code = code.capitalize.to_sym
    @option = option
    case @option
    when 1
      value = boxes[@code]
    when 2
      @code = (combo_packs.keys.select{|k| p k.to_s.include? (@code.to_s.downcase) }).join().to_sym
      value = combo_packs[@code]
    when 3
      value = single_bottles[@code]
    end
  end

  def self.show_bill(bill)
    @bill
  end

  def self.car(option, code)
    @code = code.capitalize.to_sym
    @option = option
    case @option
    when 1
      value = boxes[@code]
    when 2
      @code = (combo_packs.keys.select{|k| p k.to_s.include? (@code.to_s.downcase) }).join().to_sym
      value = combo_packs[@code]
    when 3
      value = single_bottles[@code]
    end
    n = [@code, value]
  end
end
