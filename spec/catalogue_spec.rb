 require_relative '../lib/catalogue'

 describe Wine do
   let (:code1) { %w[ /combo /single /box /mango /corozo /lulo /guyaba /portrait /cups /dinner /teddy /back /car /stop ]}
   let (:code2) {nil}
  context 'show_options' do
    it 'show the combo options'   
     show_options(options,code[0])
  