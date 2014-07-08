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

system 'cls'
puts "Welcome to blackjack\n\n".center(80)
puts "What is your name?"
name = gets.chomp
puts "Hi #{name}, let's play some blackjack!\n\n".center(80)
gets
suit = ["Hearts", "Clubs", "Diamonds", "Spades"] * 6
cards = ['2','3','4','5', '6', '7', '8', '9', '10', 'Jack', 'Queen', 'King', 'Ace']

keep_playing = true

while keep_playing == true 
  system 'cls'
  deck = suit.product(cards)
  deck.shuffle!
  mycards = []
  dealercards = []

  mycards  << deck.pop
  dealercards << deck.pop
  mycards  << deck.pop
  dealercards << deck.pop

  dealertotal = calculate_total(dealercards)
  mytotal = calculate_total(mycards)
  puts "Dealer has: #{dealercards[0]} and #{dealercards[1]}, for a total of #{dealertotal}\n"
  gets
  puts "#{name} has: #{mycards[0]} and #{mycards[1]}, for a total of #{mytotal}\n"
  gets

  blackjack = false
  playerbust = false
  dealerbust = false
  gameover = false

  if mytotal == 21 || dealertotal == 21
    system 'cls'
    puts "BLACKJACK!".center(80) * 50
    blackjack = true
    gets
  end

  while mytotal < 21 && blackjack == false && playerbust == false
    puts "What would you like to do #{name}? 1) hit or 2) stay?\n"
    hit_or_stay = gets.chomp
    if !['1','2'].include?(hit_or_stay)
      puts "Error: please enter either 1) hit or 2) stay\n"
      next
    end

    if hit_or_stay == "2"
      puts "You decided to stay with a score of #{mytotal}\n"
      gets
      break
    end

    mycards  << deck.pop
    mytotal = calculate_total(mycards)
    puts "#{name} drew: #{mycards.last}, for a total of #{mytotal}\n"
    gets
    if mytotal > 21
      puts "#{name} BUST!".center(80)
      playerbust = true
      gets
    elsif mytotal == 21
      puts "BLACKJACK".center(80) * 50
      blackjack = true
      gets
    end
  end

  if dealertotal == 21
    puts "Sorry, dealer hit blackjack. You lose.".center(80)
    blackjack = true
    gets
  end

  while dealertotal < 17 && blackjack == false && playerbust == false && dealerbust == false 
    dealercards << deck.pop
    dealertotal = calculate_total(dealercards)
    puts "Dealer drew : #{dealercards.last} for a total of #{dealertotal}"
    gets
    if dealertotal > 21
      puts "Dealer BUSTED!".center(80)
      dealerbust = true
      gets
    end
  end
  system 'cls'
#compare hands
  puts "#{name}'s cards are: "
  mycards.each do |card|
    puts "#{card}"
  end
  gets
  puts "Dealer's cards are: "
  dealercards.each do |card|
    puts "#{card}"
  end
  gets
  puts "Scores are: #{name} : #{mytotal} ---- Dealer's : #{dealertotal}"
  gets

  if mytotal > dealertotal && playerbust == false || dealerbust == true
    puts "Congratulations, you won!".center(80)
  elsif mytotal < dealertotal && dealerbust == false || playerbust == true
    puts "Sorry, you lost!".center(80)
  else
    puts "It's a tie!".center(80)
  end

  while gameover == false
    puts "Play again?(y/n)"
    answer = gets.chomp
    if !['y','n'].include?(answer.downcase)
      puts "Error: Please enter (y/n)"
      next
    end 
    if answer.downcase != 'y'
      keep_playing = false
      puts "Thanks for playing blackjack!"
      gameover = true
      gets
    else
      gameover = true
    end
  end
end
