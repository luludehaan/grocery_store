@groceries = [
    {key: 1, name: "Kiwi", price: 1.00},
    {key: 2, name: "Bread", price: 2.50},
    {key: 3, name: "Salsa", price: 2.50},
    {key: 4, name: "Steak", price: 8.50},
    {key: 5, name: "Tomato", price: 1.50},
]

@options = [
    {key: 1, name: "View Grocery Store"},
    {key: 2, name: "View Your Cart"},
    {key: 3, name: "Add Item to Cart"},
    {key: 4, name: "Remove Item from Cart"},
    {key: 5, name: "Add Item to Grocery Store"},
    {key: 6, name: "Checkout"},
    {key: 7, name: "Exit"},
]

@cart = []

def border
    puts
    puts "-" * 10
    puts
end

def menu
    @options.each_with_index do | option, index|
        puts " #{option[:key]}, #{option[:name]}"
    end
    border
end

def view_groceries
    border
    @groceries.each_with_index do | grocery, index|
        puts "#{index +1}, #{grocery[:name]}, $#{grocery[:price]}"
    end
end

def view_cart
    @cart.each_with_index do | grocery, index|
        puts "#{index +1}, #{grocery[:name]}, $#{grocery[:price]}"
    end
end

def add_groceries
    basket = {}
    puts "Please select what you would like to add."
    view_groceries
    selection = gets.chomp.to_i
    basket[:key] = @cart.length + 1
    basket[:name] = @groceries[selection -1] [:name]
    basket[:price] = @groceries[selection -1] [:price]
    @cart << basket
    puts "You've selected #{basket}"
    add_more_groceries
end

def add_more_groceries
  border
  puts "Would You Like To Add Another Item? (1.Yes 2.No)"
  border
  selection = gets.chomp.to_i
  case selection
  when 1
    add_groceries
  when 2 
    display_menu
  else 
    puts "Invalid"
    display_menu
  end
end

def remove_groceries
    puts "Please select what you would like to remove."
    delete_item = gets.chomp.to_i
    @cart.delete_at(delete_item -1)
    view_cart
    remove_more_groceries
end

def remove_more_groceries
  border
  puts "Would You Like To Remove Another Item? (1.Yes 2.No)"
  border
  selection = gets.chomp.to_i
  case selection
  when 1
    puts "Please select what you would like to remove."
    delete_item = gets.chomp.to_i
    @cart.delete_at(delete_item -1)
    view_cart
    remove_more_groceries
  when 2
    display_menu
  else
    puts "Invalid"
    display_menu
  end
end

def adds_to_groceries
    puts "What is the name of the item you'd like to add?"
    new_name = gets.chomp
    puts "What is the price?"
    new_price = gets.chomp.to_f
    new_grocery ={
        key: @groceries.length + 1,
        name: new_name,
        price: new_price,
    }
    @groceries << new_grocery
end

def checkout_wallet
    total = 0.00
    @cart.each do |grocery|
        total += grocery[:price].to_f
    end
    if total > 10.0
        puts "You don't have enough money, please remove items and remain under $10."
    else 
        checkout
    end
end

def checkout
    total = 0.00
    @cart.each do |grocery|
        total += grocery[:price].to_f
    end
    view_cart
    puts "Your total cart cost is $#{total}"
    puts "Would you like to apply a 10% off coupon? (1. Yes 2. No)"
    border
    selection = gets.chomp.to_i
    case selection
    when 1
        puts "Your cart cost is $#{total * 0.90}"
        puts "With tax, the total is $#{total * 0.90 + total * 0.06}"
        puts "Your change is $#{10.0 - (total * 0.90 + total * 0.06)}"
    when 2
        puts "With tax, your total cart cost is $#{total + total * 0.06}"
        puts "Your change is $#{10 - (total + total * 0.06)}"
end
exit
end

def display_menu
    border
    puts "MENU"
    puts
    puts "****  YOU HAVE $10. ****"
    puts
    menu
    choice = gets.chomp.to_i

    case choice
    when 1
        view_groceries
        display_menu
    when 2
        view_cart
        display_menu
    when 3
        add_groceries
        display_menu
    when 4
        view_cart
        remove_groceries
        display_menu
    when 5
        adds_to_groceries
        display_menu
    when 6
        checkout_wallet
        display_menu
    when 7
        puts "Adios!"
        exit
    else
        puts "Invalid, please make another selection."
        display_menu
    end
end

display_menu