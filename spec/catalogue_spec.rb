# rubocop:disable Layout/LineLength
require_relative '../lib/catalogue'
n = Wine.new
describe Wine do
  let(:code1) { %w[portrait cups dinner teddy] }
  let(:code2) { nil }
  let(:bill) { [[1, [], 9_000], [1, [], 21_600], [1, [], 2_000], [1, [], 21_600]] }
  imput = [
    [' combo with ', :wine_cups, ' by $', 3_000, ' each one and, you have a sub-total of $ '],
    [' box of ', :Mango, ' by $', 21_600.0, ' each one and, you have a sub-total of $ '],
    [' combo with ', :wine_cups, ' by $', 3_000, ' each one and, you have a sub-total of $ '],
    [' single bottle of ', :Mango, ' by $', 2_000, ' each one and, you have a sub-total of $ '],
    [' box of ', :Corozo, ' by $', 2_600.0, ' each one and, you have a sub-total of $ '],
    [' combo with ', :wine_cups, ' by $', 3_000, ' each one and, you have a sub-total of $ ']
  ]
  let(:car_imput) { imput }
  context 'show_options' do
    it 'show the box options' do
      to_expect = "Corozo will cost: 21600.0 type this code to select ->  /corozo\n Mango will cost: 21600.0 type this code to select ->  /mango\n Lulo will cost: 32400.0 type this code to select ->  /lulo\n Guayaba will cost: 21600.0 type this code to select ->  /guayaba"
      expect(n.show_options(Wine.boxes)).to eql(to_expect)
    end
    it 'show the combo options with the right number of arguments' do
      to_expect = "wine and portrait will cost: 4000 type this code to select ->  portrait\n wine and cups will cost: 3000 type this code to select ->  cups\n wine and dinner will cost: 2323 type this code to select ->  dinner\n wine and teddy will cost: 1231 type this code to select ->  teddy"
      expect(n.show_options(Wine.combo_packs, code1)).to eql(to_expect)
    end
    it 'show the combo options avoiding the second argument' do
      to_expect = "wine and portrait will cost: 4000 type this code to select ->  /wine and portrait\n wine and cups will cost: 3000 type this code to select ->  /wine and cups\n wine and dinner will cost: 2323 type this code to select ->  /wine and dinner\n wine and teddy will cost: 1231 type this code to select ->  /wine and teddy"
      expect(n.show_options(Wine.combo_packs)).to eql(to_expect)
    end
    it 'show the single options' do
      to_expect = "Corozo will cost: 2000 type this code to select ->  /corozo\n Mango will cost: 2000 type this code to select ->  /mango\n Lulo will cost: 3000 type this code to select ->  /lulo\n Guayaba will cost: 2000 type this code to select ->  /guayaba"
      expect(n.show_options(Wine.single_bottles)).to eql(to_expect)
    end
  end
  context 'bill?' do
    it 'show the value of one box' do
      expect(Wine.bill?(1, 'corozo')).to eql(21_600)
      expect(Wine.bill?(1, 'mango')).to eql(21_600)
      expect(Wine.bill?(1, 'lulo')).to eql(32_400)
      expect(Wine.bill?(1, 'guayaba')).to eql(21_600)
    end
    it 'show the value of one combo' do
      expect(Wine.bill?(2, 'portrait')).to eql(4_000)
      expect(Wine.bill?(2, 'cups')).to eql(3_000)
      expect(Wine.bill?(2, 'teddy')).to eql(1_231)
      expect(Wine.bill?(2, 'dinner')).to eql(2_323)
    end
    it 'show the value of one single bottle' do
      expect(Wine.bill?(3, 'corozo')).to eql(2_000)
      expect(Wine.bill?(3, 'mango')).to eql(2_000)
      expect(Wine.bill?(3, 'lulo')).to eql(3_000)
      expect(Wine.bill?(3, 'guayaba')).to eql(2_000)
    end
    it "show value 0 if one option dosen't math with code" do
      expect(Wine.bill?(3, 'corozo')).to eql(2_000)
      expect(Wine.bill?(1, 'portrait')).to eql(0)
      expect(Wine.bill?(2, 'guayaba')).to eql(0)
    end
  end
  context 'show_bill' do
    it 'return the value of a bill' do
      expect(Wine.show_bill(bill).to_i).to eql(54_200)
    end
  end
  context 'car' do
    it 'return subtotals of purchase' do
      to_expect = [[3, [' combo with ', :wine_cups, ' by $', 3_000, ' each one and, you have a sub-total of $ '], 9_000], [1, [' box of ', :Mango, ' by $', 21_600.0, ' each one and, you have a sub-total of $ '], 21_600.0], [1, [' single bottle of ', :Mango, ' by $', 2_000, ' each one and, you have a sub-total of $ '], 2_000], [1, [' box of ', :Corozo, ' by $', 21_600.0, ' each one and, you have a sub-total of $ '], 21_600.0]]
      expect(Wine.car(car_imput)).to eql(to_expect)
    end
  end
end
# rubocop:enable Layout/LineLength
