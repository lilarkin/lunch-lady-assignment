require 'pry'
require 'colorize'
require_relative 'lunch-wallet.rb'

@main_dishes = [{ dish: 'Chicken Pot Pie', price: 12.00, info: 
                { taste: 'tastes like chicken', calories: 'approx 2 million', 
                carbs: 'not enough' } }, 
              { dish: 'Meatloaf', price: 10.00, info:
                { taste: 'food coma', calories: 'so many, so worth it',
                carbs: 'time to go for a run' } }, 
              { dish: 'Fried Chicken', price: 12.00, info:
                { taste: 'oh, hell yes!', calories: 'does it matter?', 
                carbs: 'tons, literally tons'} }]

@side_dishes = [{ dish: 'mac \'n cheese', price: 2.00, info:
                { taste: 'get in my belly', calories: 'cheese has calories?', 
                carbs: 'enough to put you to sleep' } },
              { dish: 'collard greens', price: 2.00, info:
                { taste: 'southern dream', calories: 'that\'s what the bacon\'s for', 
                carbs: 'pretty much no' } },
              { dish: 'mashed potatoes', price: 1.50, info:
                { taste: 'hello, lover', calories: 'you\'re already screwed', 
                carbs: 'enough for a full day on the farm' } }]

@final_order = []

@final_payment = 0.00
@order_total = 0.00

@wallet = Wallet.new
@wallet_amount = @wallet.get_amount

def main  
  puts 'Welcome to the Cafeteria.'.colorize(:blue)
  puts 'Please look over the main dishes and choose one.'.colorize(:light_blue)
  num = 1
  @main_dishes.each do |main|
    puts "#{num}: #{main[:dish]} ($#{main[:price]})"
    num = num + 1
  end
  user_main
end

def user_main
  puts 'What is your choice?'.colorize(:light_blue)
  @user_main_dish = gets.chomp.to_f 
  if @user_main_dish == 0 || @user_main_dish > 3
    puts 'Invalid option.'
    main
  else 
    @final_order << @main_dishes[@user_main_dish -1]
  end 
  puts 'Excellent choice.'.colorize(:blue)
  side
end

def side
  puts 'Please look over the side dishes and choose a side.'.colorize(:light_blue)
  num = 1
  @side_dishes.each do |side|
    puts "#{num}: #{side[:dish]} ($#{side[:price]})"
  num = num + 1
  end
  if @first_side_dish == nil 
    user_side_one 
  else 
    user_side_two
  end
end

def user_side_one 
  puts 'What is your first choice?'.colorize(:light_blue)
  @first_side_dish = gets.chomp.to_f.to_f
  if @first_side_dish == 0 || @first_side_dish > 3
    puts 'Invalid option.'
    side
  else 
    @final_order << @side_dishes[@first_side_dish - 1]
  end 
  puts 'Excellent choice.'.colorize(:blue)
  user_side_two
end 

def user_side_two
  puts 'What is your choice?'.colorize(:light_blue)
  @second_side_dish = gets.chomp.to_i
  if @second_side_dish == 0 || @second_side_dish > 3
    puts 'Invalid option.'
    side
  else 
    @final_order << @side_dishes[@second_side_dish - 1]
  end 
  puts 'Exellent choice.'.colorize(:blue)
  puts 'You have ordered:'.colorize(:light_blue)
  order
  more_sides
end

def more_sides
  puts 'Would you like to add any more sides to your order: y/n?'.colorize(:light_blue)
  answer = gets.chomp.downcase
  if answer == 'y'
    user_side_two
  else
    puts 'Great.'.colorize(:light_blue)
  end
  final_order
end

def order
  total = 0
  total_dishes = ""
  @final_order.each_with_index do |item, index| 
    total_dishes += item[:dish] 
    total_dishes += ', ' unless index == @final_order.length - 1
    total += item[:price] 
  end
  puts total_dishes
  @order_total = total 
end

def final_order
  puts "Your final order is:".colorize(:light_blue)
  order 
  puts 'Your total comes to:'.colorize(:light_blue)
  puts "$#{@order_total}"
  payment(@order_total)
end

def payment(total) 
  if @wallet_amount >= total 
    order_complete
  else
    puts "You only have $#{@wallet_amount} and cannot afford this meal.".colorize(:blue)
    puts 'Please reorder'.colorize(:light_blue)
    @final_order = []
    @wallet_amount += @order_total 
    main
  end
  # order_complete
end

def order_complete
  puts 'Are you happy with your order: y/n?'.colorize(:light_blue)
  happy = gets.chomp.downcase
  if happy == 'y'
    puts 'Enjoy your meal.'.colorize(:light_blue)
    exit(0)
  else
    @final_order = []
    @first_side_dish = nil
    main
  end
end

main
