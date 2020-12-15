
class Wine
  attr_accessor :pasas

  def single_bottles
    bottles = {Corozo: p1, Mango: 2000, Lulo: 2000, Guayaba: 2000}
  end
  
  def combo_packs
    combos  = {wine_portrait: 4000, wine_cups:3000, wine_dinner: 2323, wine_teddy: 1231}
  end
  
  def boxes
    p @p1
    mayoritario = {Corozo: @p1*(1-0.1)*12, Mango: 2131, Lulo: 145, Guayaba: 234}
  end

  def show_combo()
    @options = self.combo_packs
    pre_code = @options.keys.to_s.gsub(":wine_", "").gsub("[","").gsub("]","").gsub(" ","").split(",")
    code = pre_code.map { |x| "#{x}"  }
    n = 0
    y = []
    m = []
    while n < @options.keys.length do
    y << [@options.keys[n], "will cost:", @options.values[n], "type this code to select ->", " /#{code[n]}"]
    m << y[n].join(",").gsub(",", " ")
    n+=1
    end
    # x = Array.new
    # self.combo_packs.each {|y| x << y}
    # x
    m = m.to_s.gsub("," , "\n").gsub('"',"").gsub("[","").gsub("]","").gsub("_"," and ")
    return m.to_s
  #to_s.gsub("_", " & ").gsub(":","").gsub("=>", " will cost ").gsub("{","").gsub("}","")
  
  end
end
 
# p n.keys[1]
# p  n.values

#  person = Wine.new
#  person.values = 2000
#  p person.values # => "Dennis"

