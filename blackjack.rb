require 'pry'
all_cards = {   :hearts => [2,3,4,5,6,7,8,9,10, 'J','Q','K','A'], 
			:diamonds => [2,3,4,5,6,7,8,9,10, 'J','Q','K','A'], 
			:spades => [2,3,4,5,6,7,8,9,10, 'J','Q','K','A'], 
			:clubs => [2,3,4,5,6,7,8,9,10, 'J','Q','K','A']}

cards_drawn =  { :hearts => [], 
      :diamonds => [], 
      :spades => [], 
      :clubs => []}


suits = [:hearts, :diamonds,:spades, :clubs ]
numbers = [2,3,4,5,6,7,8,9,10, 'J','Q','K','A']

suit = suits[rand(0..3)] #this will hold the suit of the drawn card
number = numbers[rand(0..12)] #this will hold the number of the card(face cards and Aces included)

def draw_card suits, suit, numbers, number, cards_drawn, score
  acceptable_card = false
  while acceptable_card == false do
    #binding.pry
    if cards_drawn[suit].include?(number) == false 
      cards_drawn[suit] << number
      acceptable_card = true
      return cards_drawn
    else
      suit = suits[rand(0..3)]
      number = numbers[rand(0..12)]
    end
  end  
end

def update_score score, number

  if number == 'J' ||number == 'Q'||number == 'K'
    score += 10
  elsif number == 'A'
    if score < 11
      score += 11
    else
      score+= 1
    end
  else
    score += number
  end

end


    
player_score = 0
dealer_score = 0
puts
puts
puts "Hello, Welcome to Lucky Larry's BlackJack....feeling lucky?"
puts "Press [ENTER] to continue..."
gets
puts ("-"*50).center(50)
puts "Player's Turn".center(50)
puts ("-"*50).center(50)
puts "Press [ENTER] to continue..."
gets

#set conditions to beginning setting
hit = true
bust = false
blackjack = false
dealer_bust = false

#Draw Player's first card
suit = suits[rand(0..3)]
number = numbers[rand(0..12)]
cards_drawn = draw_card suits, suit, numbers, number, cards_drawn, player_score
player_score = update_score player_score, number
temp1 = suit
temp2 = number
#Draw Player's second card
suit = suits[rand(0..3)]
number = numbers[rand(0..12)]
cards_drawn = draw_card suits, suit, numbers, number, cards_drawn, player_score
player_score = update_score player_score, number
puts "You were delt a #{temp2} of #{temp1} and a #{number} of #{suit} for a total score of #{player_score}!"
puts "Press [ENTER] to continue..."
gets
puts

if player_score == 21
    puts 'BLACKJACK'
    puts "Press [ENTER] to continue..."
    gets
    blackjack = true
end


while (hit == true) && (bust == false) && (blackjack == false) do
  
  if player_score < 22 && blackjack == false
    puts
    puts "Would you like to hit?(y/n)"
    answer = gets.chomp
    if answer != 'y'
      hit = false
    else
      suit = suits[rand(0..3)]
      number = numbers[rand(0..12)]
      cards_drawn = draw_card suits, suit, numbers, number, cards_drawn, player_score
      player_score = update_score player_score, number
      puts "You drew a #{number} of #{suit} for a total score of #{player_score}!"
      puts "Press [ENTER] to continue..."
      gets
    end

    
  else
    puts "YOU BUSTED!"
    puts "Press [ENTER] to continue..."
    gets
    hit = false
    bust = true

  end

end

if blackjack == false && bust == false
  #dealer moves next
  dealer_blackjack = false
  puts ("-"*50).center(50)
  puts "Dealer's Turn".center(50)
  puts ("-"*50).center(50)
  puts "Press [ENTER] to continue..."
  gets

  suit = suits[rand(0..3)]
  number = numbers[rand(0..12)]
  cards_drawn = draw_card suits, suit, numbers, number, cards_drawn, dealer_score
  dealer_score = update_score dealer_score, number
  temp1 = suit
  temp2 = number
  suit = suits[rand(0..3)]
  number = numbers[rand(0..12)]
  cards_drawn = draw_card suits, suit, numbers, number, cards_drawn, dealer_score
  dealer_score = update_score dealer_score, number
  puts ("-"*50).center(50)
  puts "Dealer drew a #{temp2} of #{temp1} and a #{number} of #{suit} for a total score of #{dealer_score}!"
  puts "Press [ENTER] to continue..."
  gets
end

if dealer_score ==21
    dealer_blackjack = true
end

while ((dealer_score <17)  && (blackjack == false) && (dealer_bust == false) && (bust == false) && (dealer_blackjack == false)) do

  
  suit = suits[rand(0..3)]
  number = numbers[rand(0..12)]
  cards_drawn = draw_card suits, suit, numbers, number, cards_drawn, dealer_score
  dealer_score = update_score dealer_score, number
  puts ("-"*50).center(50)
  puts "Dealer drew a #{number} of #{suit} for a total score of #{dealer_score}!"
  if dealer_score > 21
    puts "Dealer busts!"
    dealer_bust = true
  end
  puts "Press [ENTER] to continue..."
  gets

  if dealer_score ==21
    dealer_blackjack = true
  end

    

end


if ((player_score > dealer_score) && (bust == false) )  || blackjack == true || dealer_bust == true
  puts "PLAYER WINS!!!!".center(50)
  if dealer_bust == true
    puts "Dealer busted!".center(50)
  end
  puts
  puts "Press [ENTER] to continue..."
  gets
  puts
  puts "FINAL SCORES".center(50)
  puts "Player Score: #{player_score}".ljust(50/2) + "Dealer Score: #{dealer_score}".rjust(50/2)
  puts
  puts "Thank you for playing!".center(50)
elsif bust == true || ((player_score < dealer_score) && (player_score < 22) && (dealer_score < 22))
  puts "Sorry, DEALER WINS...".center(50)
  if bust == true
    puts "You busted!".center(50)
  end
  puts "Better luck next time!".center(50)
  puts
  puts "Press [ENTER] to continue..."
  gets
  puts
  puts "FINAL SCORES".center(50)
  puts "Player Score: #{player_score}".ljust(50/2) + "Dealer Score: #{dealer_score}".rjust(50/2)
  puts
  puts "Thank you for playing!".center(50)
elsif player_score == dealer_score
  puts "TIE!!!!!!! --- DEALER WINS...".center(50)
  puts "Better luck next time!".center(50)
  puts
  puts "Press [ENTER] to continue..."
  gets
  puts
  puts "SCORES".center(50)
  puts "Player Score: #{player_score}".ljust(50/2) + "Dealer Score: #{dealer_score}".rjust(50/2)
  puts
  puts "Thank you for playing!".center(50)
end
