class Wallet
  attr_accessor :amount 

  def initialize(amount)
    amount_array = [9.00, 9.50, 10.00, 10.50, 
                    11.00, 11.50, 12.00, 12.50]
    @amount = amount_array.sample
  end
end