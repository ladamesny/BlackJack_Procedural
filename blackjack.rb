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
puts "Hello, Welcome to Lucky Larry's BlackJack....feeling lucky?"
puts "Player goes first"
puts "Press [ENTER]"
puts ("-"*50).center(50)
gets

hit = true
bust = false
blackjack = false
dealer_bust = false

while (hit == true) && (bust == false) && (blackjack == false) do
  
  suit = suits[rand(0..3)]
  number = numbers[rand(0..12)]
  puts ("-"*50).center(50)
  puts "You drew a #{number} of #{suit}!"
  cards_drawn = draw_card suits, suit, numbers, number, cards_drawn, player_score
  player_score = update_score player_score, number
  puts ("-"*50).center(50)
  puts "Your score is #{player_score}! [ENTER]"
  gets
  if player_score ==21
    puts 'BLACKJACK'
    blackjack = true
    break
  end
  if player_score < 22 && blackjack == false

    puts "Would you like to hit again?(y/n)"
    answer = gets.chomp
    if answer != 'y'
      hit = false
    end
    if player_score == 21
      break
  
    end

  else
    puts "YOU BUSTED!"
    hit = false
    bust = true

  end

end

  #dealer moves next
while dealer_score <16  && blackjack == false && dealer_bust == false && bust == false do
    suit = suits[rand(0..3)]
    number = numbers[rand(0..12)]
    puts ("-"*50).center(50)
    puts "Dealer drew a #{number} of #{suit}!"
    cards_drawn = draw_card suits, suit, numbers, number, cards_drawn, dealer_score
    dealer_score = update_score dealer_score, number
    if dealer_score ==21
      blackjack = true
    end
    puts "Dealer score is now: #{dealer_score} [ENTER]"
    gets
    if dealer_score > 21
      puts "Dealer busts!"
      dealer_bust = true
    end
end


if blackjack == true || dealer_bust == true || bust == true
puts
else
  puts ("-"*50).center(50)
  puts "SCORES Before last hit!".center(50)
  puts "Player Score: #{player_score}".ljust(50/2) + "Dealer Score: #{dealer_score} [ENTER]".rjust(50/2)
  puts
  gets

  if player_score < 22
    puts "Would you like to hit again?(y/n)"
    answer = gets.chomp
    if answer == 'y'
      suit = suits[rand(0..3)]
      number = numbers[rand(0..12)]
      puts ("-"*50).center(50)
      puts "You drew a #{number} of #{suit}! [ENTER]"
      gets
      cards_drawn = draw_card suits, suit, numbers, number, cards_drawn, player_score
      player_score = update_score player_score, number
      puts ("-"*50).center(50)
      if player_score > 21
        puts "BUSTED"
        bust = true
      elsif player_score == 21
        puts "BLACKJACK!!!"
      end
    end
  end
end

if ((player_score > dealer_score) && (player_score < 22) && (dealer_score < 22))  || ((dealer_score > dealer_score) && (dealer_score < 22) && (player_score < 22)) || dealer_bust == true
  puts "PLAYER WINS!!!! [ENTER]"
  gets
  puts
  puts "SCORES".center(50)
  puts "Player Score: #{player_score}".ljust(50/2) + "Dealer Score: #{dealer_score}".rjust(50/2)
elsif bust == true || ((player_score < dealer_score) && (player_score < 22) && (dealer_score < 22))
  puts "Sorry, DEALER WINS..."
  puts "Better luck next time! [ENTER]"
  gets
  puts
  puts "SCORES".center(50)
  puts "Player Score: #{player_score}".ljust(50/2) + "Dealer Score: #{dealer_score}".rjust(50/2)
elsif player_score == dealer_score
  puts "TIE!!!!!!! --- DEALER WINS..."
  puts "Better luck next time! press [ENTER]"
  gets
  puts
  puts "SCORES".center(50)
  puts "Player Score: #{player_score}".ljust(50/2) + "Dealer Score: #{dealer_score}".rjust(50/2)
end
