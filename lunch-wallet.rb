class Wallet
  # attr_accessor :amount 

  def get_amount
    amount_array = [13.00, 13.50, 14.00, 14.50, 
                   15.00, 15.50, 16.00, 16.50]
    amount = amount_array.sample
    return amount
  end
end
