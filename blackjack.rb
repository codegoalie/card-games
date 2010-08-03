require 'cards.rb'

class Hand < Deck
  def value
    value = 0
    @cards.each do |card|
      if card.rank.to_c == "A"
        if value + 11 > 21
          value += 1
        else
          value += 11
        end
      else
        value += card.value
      end
    end
    value
  end
end


puts "Welcome to Blackjack"
shoe = Deck.new
puts "How many decks would you like to play with?"
deck_count = gets.chomp
deck_count.to_i.times do
  shoe.add_deck
  shoe.shuffle
end

puts "How much would you like to bet?"
player_bet = gets.chomp.to_i

player_hand = Hand.new
dealer_hand = Hand.new
2.times do
  draw = shoe.draw
  puts "You were dealt a #{draw}"
  player_hand.place(draw)
  dealer_hand.place(shoe.draw)
end

hit_or_stand = ""
while hit_or_stand.to_s != "s"
  puts "You have #{player_hand.value}"
  puts "The dealer shows #{dealer_hand[0]}"
  puts "(h)it or (s)tay?"
  hit_or_stand = gets.chomp
  if hit_or_stand.eql? "h"
    draw = shoe.draw
    puts "You drew #{draw}"
    player_hand.place(draw)
  end
  if(player_hand.value > 21)
    puts "You busted..."
    hit_or_stand = "s"
  end
end

puts "You stood with #{player_hand.value}" unless player_hand.value > 21
puts "The Dealer has #{dealer_hand.value}"
while dealer_hand.value < 17
  draw = shoe.draw
  dealer_hand.place(draw)
  puts "The Dealer drew a #{draw} and now has #{dealer_hand.value}"
  puts "The Dealer busted!!" if dealer_hand.value > 21
end

if player_hand.value <= 21 && (player_hand.value > dealer_hand.value || dealer_hand.value > 21)
  puts "You win #{player_bet*2}!!"
elsif (player_hand.value <= 21 && player_hand.value == dealer_hand.value) || dealer_hand.value > 21
  puts "Push. You get your #{player_bet} back."
else
  puts "You lose #{player_bet}..."
end

