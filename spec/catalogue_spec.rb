require_relative '../lib/catalogue'

describe Wine do
  let (:code1) { %w[ /combo /single /box /mango /corozo /lulo /guyaba /portrait /cups /dinner /teddy /back /car /stop ]}
  let (:code2) {nil}
  context 'show_options' do 
    
    show_options(options,code[0])
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
end