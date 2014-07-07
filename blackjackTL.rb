require 'pry'

def calculate_total(cards) #[[suit, card],[ 'H', '3']]
  values = cards.map{|e| e[1]}
  score = 0
  values.each do |card|
    if card == 'Ace'
      score+=11
    elsif card.to_i == 0 # Jack, Queen or King
      score += 10
    else
      score += card.to_i
    end
  end
  #correct for aces
  values.select{|e| e == 'Ace'}.count.times do
    score -=10 if score > 21
  end
  score
end

puts "Welcome to blackjack"
puts "What is your name?"
name = gets.chomp
puts "Hi " + name + ", let's play some blackjack!"
gets
suit = ["Hearts", "Clubs", "Diamonds", "Spades"]
cards = ['2','3','4','5', '6', '7', '8', '9', '10', 'Jack', 'Queen', 'King', 'Ace']

keep_playing = true

while keep_playing == true 
  deck = suit.product(cards)
  deck.shuffle!
  mycards = []
  dealercards = []

  mycards  << deck.pop
  dealercards << deck.pop
  mycards  << deck.pop
  dealercards << deck.pop
  blackjack = false
  dealerblackjack = false

  dealertotal = calculate_total(dealercards)
  mytotal = calculate_total(mycards)
  puts "Dealer has: #{dealercards[0]} and #{dealercards[1]}, for a total of #{dealertotal}"
  puts name + " has: #{mycards[0]} and #{mycards[1]}, for a total of #{mytotal}\n"

  bust = false
  if mytotal == 21 || dealertotal == 21
    puts "BLACKJACK!"
    blackjack = true
  end

  if blackjack == false
  puts "What would you like to do " + name+ "? 1) hit or 2) stay"
  hit_or_stay = gets.chomp
  end

  while hit_or_stay == '1' && bust == false && blackjack == false
    mycards  << deck.pop
    mytotal = calculate_total(mycards)
    puts name +" drew: #{mycards.last}, for a total of #{mytotal}"
    if mytotal > 21
      puts name + " BUST!"
      bust = true
      break
    else
      puts "What would you like to do " + name+ "? 1) hit or 2) stay"
      hit_or_stay = gets.chomp
    end
  end
  dealerbust = false
  while dealertotal < 17 && bust == false && dealerbust == false && blackjack == false
    dealercards << deck.pop
    dealertotal = calculate_total(dealercards)
    puts "Dealer drew : #{dealercards.last} for a total of #{dealertotal}"
    if dealertotal > 21
      dealerbust = true
      puts "Dealer BUSTED! You win!"
    end
  end

  if mytotal > dealertotal && bust == false || dealerbust == true
    puts "You won!"
    puts "Play again?(y/n)"
    answer = gets.chomp
      if answer.downcase != 'y'
        keep_playing = false
      end
  else puts name +" lost! Sorry..."
    puts "Play again?(y/n)"
    answer = gets.chomp
      if answer != 'y'
        keep_playing = false
        puts "Thanks for playing!"
      end
  end
end
