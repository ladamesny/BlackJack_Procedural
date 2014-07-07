require 'pry'

#We are playing with four decks of cards to prevent card counting
all_cards = { :hearts => [2,3,4,5,6,7,8,9,10, 'Jack','Queen','King','Ace'], 
			        :diamonds => [2,3,4,5,6,7,8,9,10, 'Jack','Queen','King','Ace'], 
			        :spades => [2,3,4,5,6,7,8,9,10, 'Jack','Queen','King','Ace'], 
			        :clubs => [2,3,4,5,6,7,8,9,10, 'Jack','Queen','King','Ace'],
              :heartsA => [2,3,4,5,6,7,8,9,10, 'Jack','Queen','King','Ace'], 
              :diamondsA => [2,3,4,5,6,7,8,9,10, 'Jack','Queen','King','Ace'], 
              :spadesA => [2,3,4,5,6,7,8,9,10, 'Jack','Queen','King','Ace'], 
              :clubsA => [2,3,4,5,6,7,8,9,10, 'Jack','Queen','King','Ace'],
              :heartsB => [2,3,4,5,6,7,8,9,10, 'Jack','Queen','King','Ace'], 
              :diamondsB => [2,3,4,5,6,7,8,9,10, 'Jack','Queen','King','Ace'], 
              :spadesB => [2,3,4,5,6,7,8,9,10, 'Jack','Queen','King','Ace'], 
              :clubsB => [2,3,4,5,6,7,8,9,10, 'Jack','Queen','King','Ace'],
              :heartsC => [2,3,4,5,6,7,8,9,10, 'Jack','Queen','King','Ace'], 
              :diamondsC => [2,3,4,5,6,7,8,9,10, 'Jack','Queen','King','Ace'], 
              :spadesC => [2,3,4,5,6,7,8,9,10, 'Jack','Queen','King','Ace'], 
              :clubsC => [2,3,4,5,6,7,8,9,10, 'Jack','Queen','King','Ace']}

#This hash will store all the cards drawn from the deck
cards_drawn =  {  :hearts => [], 
                  :diamonds => [], 
                  :spades => [], 
                  :clubs => [],
                  :heartsA => [], 
                  :diamondsA => [], 
                  :spadesA => [], 
                  :clubsA => [],
                  :heartsB => [], 
                  :diamondsB => [], 
                  :spadesB => [], 
                  :clubsB => [],
                  :heartsC => [], 
                  :diamondsC => [], 
                  :spadesC => [], 
                  :clubsC => []}


suits = [:hearts, :diamonds,:spades, :clubs, :heartsA, :diamondsA,:spadesA, :clubsA ,:heartsB, :diamondsB,:spadesB, :clubsB ,:heartsC, :diamondsC,:spadesC, :clubsC  ]
numbers = [2,3,4,5,6,7,8,9,10, 'Jack','Queen','King','Ace']

def draw_card suits, suit, numbers, number, cards_drawn, score
  acceptable_card = false
  while acceptable_card == false do
    #binding.pry
    if cards_drawn[suit].include?(number) == false 
      cards_drawn[suit] << number
      acceptable_card = true
      return cards_drawn
    else
      suit = suits[rand(0..15)]
      number = numbers[rand(0..12)]
    end
  end  
end

#This method helps identify the suit among the 4 decks. i.e. "hearts" instead of "heartsA" of "heartsC"
def card_suit suit
  if suit =~ /hearts/
    return "hearts"
  elsif suit =~ /diamonds/
    return "diamonds"
  elsif suit =~ /spades/
    return "spades"
  else
    return "clubs"
  end

end


def update_score score, number

  if number == 'Jack' ||number == 'Queen'||number == 'King'
    score += 10
  elsif number == 'Ace'
    if score < 11
      score += 11
    else
      score+= 1
    end
  else
    score += number
  end

end
    
puts ("\n\n               Hello, Welcome to...").center(50)
puts ("-"*50).center(50)
puts ("\n          LUCKY LARRY'S BLACKJACK TABLE!").center(50)
puts ("-"*50).center(50)
gets
puts "\nWhat is your name?"
name = gets.chomp
puts "\nHi " + name +"! Let's play some BlackJack!"
puts "Press [ENTER] to continue...\n"
gets



keep_playing = true

while keep_playing == true
  
  #set conditions to default settings for each new game
  hit = true
  bust = false
  blackjack = false
  dealer_bust = false
  player_score = 0
  dealer_score = 0

  puts ("-"*50).center(50)
  puts (name + "'s Turn").center(50)
  puts ("-"*50).center(50)
  puts "\nPress [ENTER] to continue...\n"
  gets
  #Draw Player's first card
  suit = suits[rand(0..15)]
  number = numbers[rand(0..12)]
  cards_drawn = draw_card suits, suit, numbers, number, cards_drawn, player_score
  player_score = update_score player_score, number
  temp1 = card_suit suit
  temp2 = number
  #Draw Player's second card
  suit = suits[rand(0..15)]
  number = numbers[rand(0..12)]
  cards_drawn = draw_card suits, suit, numbers, number, cards_drawn, player_score
  player_score = update_score player_score, number
  suit = card_suit suit
  puts name + " was delt a #{temp2} of #{temp1} and a #{number} of #{suit} for a total score of #{player_score}!"
  puts "\nPress [ENTER] to continue...\n"
  gets

  if player_score == 21
      puts "BLACKJACK".center(50)
      puts "Press [ENTER] to continue..."
      gets
      blackjack = true
  end

if blackjack == false && bust == false
  #dealer moves next
    dealer_blackjack = false
    puts ("-"*50).center(50)
    puts "Dealer's Turn".center(50)
    puts ("-"*50).center(50)
    puts "\nPress [ENTER] to continue..."
    gets

    suit = suits[rand(0..15)]
    number = numbers[rand(0..12)]
    cards_drawn = draw_card suits, suit, numbers, number, cards_drawn, dealer_score
    dealer_score = update_score dealer_score, number
    suit = suits[rand(0..15)]
    number = numbers[rand(0..12)]
    cards_drawn = draw_card suits, suit, numbers, number, cards_drawn, dealer_score
    dealer_score = update_score dealer_score, number
    suit = card_suit suit
    if dealer_score ==21
      dealer_blackjack = true
      puts "BLACKJACK by the dealer"
    else
      puts "\nDealer drew two cards. The dealer is showing a #{number} of #{suit}."
    end
    puts "\nPress [ENTER] to continue..."
    gets
  end

  if blackjack == false && dealer_blackjack == false
    puts ("-"*50).center(50)
    puts (name +"'s turn again").center(50)
    puts ("-"*50).center(50)
  end
  
  
  while (hit == true) && (bust == false) && (blackjack == false) && (dealer_blackjack == false) do
    
    if player_score < 21 && blackjack == false
      puts
      puts "\n \n Would you like to hit?(y/n)"
      answer = gets.chomp
      if answer != 'y'
        hit = false
      else
        suit = suits[rand(0..15)]
        number = numbers[rand(0..12)]
        cards_drawn = draw_card suits, suit, numbers, number, cards_drawn, player_score
        player_score = update_score player_score, number
        suit = card_suit suit
        puts "You drew a #{number} of #{suit} for a total score of #{player_score}!"
        puts "Press [ENTER] to continue..."
        gets
      end

    
    elsif player_score > 21 && blackjack == false
      puts (name.upcase + " BUSTED!").center(50)
      puts "\nPress [ENTER] to continue..."
      gets
      hit = false
      bust = true
    end

  end
  if (bust == false && blackjack == false && dealer_blackjack == false && dealer_bust == false)
    puts ("-"*50).center(50)
    puts "Dealer's Turn again".center(50)
    puts ("-"*50).center(50)
    puts "\nPress [ENTER] to continue..."
    gets

    puts "\nThe dealer turns his card. The dealer's score is : #{dealer_score}"
    puts "Press [ENTER] to continue..."
    gets
  
    while dealer_score <17 do
      suit = suits[rand(0..15)]
      number = numbers[rand(0..12)]
      cards_drawn = draw_card suits, suit, numbers, number, cards_drawn, dealer_score
      dealer_score = update_score dealer_score, number
      suit = card_suit suit
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
  end



  if ((player_score > dealer_score) && (bust == false) )  || blackjack == true || dealer_bust == true
    puts (name.upcase+" WINS!!!!").center(50)
    if dealer_bust == true
      puts "Dealer busted!".center(50)
    end
    puts "\nPress [ENTER] to continue..."
    gets
    puts "\nFINAL SCORES".center(50)
    puts name+"'s Score: #{player_score}".ljust(50/2) + "Dealer Score: #{dealer_score}".rjust(50/2)
    puts "\nThank you for playing! Would you like to play again? (y/n)".center(50)
    answer = gets.chomp
    if answer != 'y'
      keep_playing = false
    end
  elsif bust == true || ((player_score < dealer_score) && (player_score < 22) && (dealer_score < 22))
    puts "\nSorry, DEALER WINS...".center(50)
    puts "Better luck next time!".center(50)
    puts "\nPress [ENTER] to continue..."
    gets
    puts "\nFINAL SCORES".center(50)
    puts name+ "'s Score: #{player_score}".ljust(50/2) + "Dealer Score: #{dealer_score}".rjust(50/2)
    puts "\nThank you for playing! Would you like to play again? (y/n)".center(50)
    answer = gets.chomp
    if answer != 'y'
      keep_playing = false
    end
  elsif player_score == dealer_score
    puts "\nTIE!!!!!!! --- DEALER WINS...".center(50)
    puts "Better luck next time!".center(50)
    puts "\nPress [ENTER] to continue..."
    gets
    puts "\nSCORES".center(50)
    puts name+"'s Score: #{player_score}".ljust(50/2) + "Dealer Score: #{dealer_score}".rjust(50/2)
    puts "\nThank you for playing! Would you like to play again? (y/n)".center(50)
    answer = gets.chomp
    if answer != 'y'
      keep_playing = false
    end
  end
end
