 require_relative '../lib/catalogue'
 n = Wine.new
 describe Wine do
  #let(:code) { %w[ /combo /single /box /mango /corozo /lulo /guyaba /portrait /cups /dinner /teddy /back /car /stop ]}
  let(:code1) {%w[portrait cups dinner teddy]}
  let(:code2) {nil}
  let(:bill1) {[[1, [], 9000],[1, [], 21600],[1, [], 2000],[1, [], 21600]]}
  let(:bill2) {[[1, [], nil],[1, [], 21600],[1, [], 2000],[1, [], 21600]]}
  context 'show_options' do
    it 'show the box options' do
    to_expect = "Corozo will cost: 21600.0 type this code to select ->  /corozo\n Mango will cost: 21600.0 type this code to select ->  /mango\n Lulo will cost: 32400.0 type this code to select ->  /lulo\n Guayaba will cost: 21600.0 type this code to select ->  /guayaba"
    expect(n.show_options(Wine.boxes)).to eql(to_expect)
    end
    it 'show the combo options with the right number of arguments' do
      to_expect = "wine and portrait will cost: 4000 type this code to select ->  portrait\n wine and cups will cost: 3000 type this code to select ->  cups\n wine and dinner will cost: 2323 type this code to select ->  dinner\n wine and teddy will cost: 1231 type this code to select ->  teddy"
      expect(n.show_options(Wine.combo_packs, code1)).to eql(to_expect)
    end
    it 'show the combo options avoiding the second argument'do
      to_expect = "wine and portrait will cost: 4000 type this code to select ->  /wine and portrait\n wine and cups will cost: 3000 type this code to select ->  /wine and cups\n wine and dinner will cost: 2323 type this code to select ->  /wine and dinner\n wine and teddy will cost: 1231 type this code to select ->  /wine and teddy"
      expect(n.show_options(Wine.combo_packs)).to eql(to_expect)
    end
    it 'show the single options' do
      to_expect = "Corozo will cost: 2000 type this code to select ->  /corozo\n Mango will cost: 2000 type this code to select ->  /mango\n Lulo will cost: 3000 type this code to select ->  /lulo\n Guayaba will cost: 2000 type this code to select ->  /guayaba"
      expect(n.show_options(Wine.single_bottles)).to eql(to_expect)
    end
  end
  context 'bill?'do
    it 'show the value of one box' do
    expect(Wine.bill?(1,"corozo")).to eql(21600)
    expect(Wine.bill?(1,"mango")).to eql(21600)
    expect(Wine.bill?(1,"lulo")).to eql(32400)
    expect(Wine.bill?(1,"guayaba")).to eql(21600)
    end
    it 'show the value of one combo' do
      expect(Wine.bill?(2,"portrait")).to eql(4000)
      expect(Wine.bill?(2,"cups")).to eql(3000)
      expect(Wine.bill?(2,"teddy")).to eql(1231)
      expect(Wine.bill?(2,"dinner")).to eql(2323)
    end
    it 'show the value of one single bottle' do 
       expect(Wine.bill?(3,"corozo")).to eql(2000)
       expect(Wine.bill?(3,"mango")).to eql(2000)
       expect(Wine.bill?(3,"lulo")).to eql(3000)
       expect(Wine.bill?(3,"guayaba")).to eql(2000)
    end
    it "show value 0 if one option dosen't math with code" do
      expect(Wine.bill?(3,"corozo")).to eql(2000)
      expect(Wine.bill?(1,"portrait")).to eql(0)
      expect(Wine.bill?(2,"guayaba")).to eql(0)
    end
  end
  context 'show_bill' do
    it 'return the value of a bill' do 
       expect(Wine.show_bill(bill1).to_i).to eql(54200)
    end
    it 'return the value of a bill' do 
      expect(Wine.show_bill(bill2).to_i).to eql(54200)
   end
  end
end
 