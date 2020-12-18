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
      to_expect = [[3, [' combo with ', :wine_cups, ' by $', 3_000, ' each one and, you have a sub-total of $ '], 9_000, '//'], [1, [' box of ', :Mango, ' by $', 21_600.0, ' each one and, you have a sub-total of $ '], 21_600.0, '//'], [1, [' single bottle of ', :Mango, ' by $', 2_000, ' each one and, you have a sub-total of $ '], 2_000, '//'], [1, [' box of ', :Corozo, ' by $', 2_600.0, ' each one and, you have a sub-total of $ '], 2_600.0, '//']]

      expect(Wine.car(car_imput)).to eql(to_expect)
    end
  end
  context 'show_single' do
    it 'returns an string with the options of single option' do
      to_expect = 'Corozo will cost: 2000 type this code to select ->  /corozo                                                                                                          Mango will cost: 2000 type this code to select ->  /mango                                                                                                          Lulo will cost: 3000 type this code to select ->  /lulo                                                                                                          Guayaba will cost: 2000 type this code to select ->  /guayaba'
      expect(n.show_single).to eql(to_expect)
    end
  end
  context 'show_box' do
    it 'returns an string with the options of single option' do
      to_expect = 'Corozo will cost: 21600.0 type this code to select ->  /corozo                                                                                                          Mango will cost: 21600.0 type this code to select ->  /mango                                                                                                          Lulo will cost: 32400.0 type this code to select ->  /lulo                                                                                                          Guayaba will cost: 21600.0 type this code to select ->  /guayaba'
      expect(n.show_box).to eql(to_expect)
    end
  end
  context 'show_combo' do
    it 'returns an string with the options avoiding the second argument' do
      to_expect = 'wine and portrait will cost: 4000 type this code to select ->  /portrait                                                                                                          wine and cups will cost: 3000 type this code to select ->  /cups                                                                                                          wine and dinner will cost: 2323 type this code to select ->  /dinner                                                                                                          wine and teddy will cost: 1231 type this code to select ->  /teddy'
      expect(n.show_combo).to eql(to_expect)
    end
  end
  context 'car?' do
    it 'returns an array of cost with the actual key and value boxes' do
      to_expect = [' box of ', :Corozo, ' by $', 21_600.0, ' each one and, you have a sub-total of $']
      expect(Wine.car?(1, 'corozo')).to eql(to_expect)
    end
    it "returns an array with empty key and value if doesn't match option (integer) with code (string)" do
      to_expect = [' combo with ', :"", ' by $', nil, ' each one and, you have a sub-total of $']
      expect(Wine.car?(2, 'corozo')).to eql(to_expect)
    end
    it 'returns an array of cost with the actual key and value of single bottles' do
      to_expect = [' combo with ', :wine_cups, ' by $', 3_000, ' each one and, you have a sub-total of $']
      expect(Wine.car?(2, 'cups')).to eql(to_expect)
    end
    it 'returns an array of cost with the actual key and value of single bottles' do
      to_expect = [' single bottle of ', :Corozo, ' by $', 2_000, ' each one and, you have a sub-total of $']
      expect(Wine.car?(3, 'corozo')).to eql(to_expect)
    end
  end
end
# rubocop:enable Layout/LineLength
