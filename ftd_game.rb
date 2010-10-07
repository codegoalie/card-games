require './cards.rb'
require './FTD.rb'
require './Players.rb'
require 'active_support/inflector'


puts "Welcome to textual Fuck The Dealer"
puts "Let's get schwasted!"

game = FTD.new
#deck = Deck.new
#deck.add_deck
#deck.shuffle

#table = Table.new

#puts "How many players will there be?"
#player_count = gets.chomp.to_i
#player_count.times do |i|
#  puts "What is Player #{i+1}'s Name?"
#  game.players.add(FTD_Player.new(gets.chomp))
#end

game.players.add(FTD_Player.new("Chris"))
game.players.add(FTD_Player.new("Hayley"))
game.players.add(FTD_Player.new("Bobby"))
game.players.add(FTD_Player.new("Katie"))

puts "Here we go!"
#print out the table and current dealer & player
puts game.status

while ! game.complete do
  puts "It's #{game.player.name}'s turn"
  while game.guess_count < FTD::MAX_GUESSES do
    guess_string = game.guess_count == 0 ? "1st" : "2nd"
    puts "#{game.player.name}, what is your #{guess_string} guess?"
    # game.guess returns -1 if guess is too high, 1 if guess is too low and 0 if guess is correct
    #guess = game.guess(gets.chomp)
    guess = game.guess(2+rand(12))
    if(game.guess_count < FTD::MAX_GUESSES)
      case guess
      when -1
        puts "Lower"
      when 1
        puts "Higher"
      else
        puts "Correct!"
        break
      end
    end
  end

  #end of turn (end_turn handles stats and drink calculations but DOES NOT ADVANCE THE PLAYERS)
  gets = game.gets
  turn_results = game.end_turn
  puts "The Card was #{turn_results[:card_string]}"
  puts "#{game.player.name} drinks #{turn_results[:players_drinks]}"
  puts "#{game.dealer.name} drinks #{turn_results[:dealers_drinks]}"

  if turn_results[:next_dealer]
    old_dealer_name = game.dealer.name
    game.players.actors[:player] = game.players.actors[:dealer]
    game.players.advance :dealer
    puts "That's #{gets+1}! #{old_dealer_name} pass the deck to #{game.dealer.name}!"
  else
    puts "#{game.dealer.name} has #{game.gets} gets"
    game.players.advance :player
  end
  
  puts game.status
end
puts "Thanks for playing!!"
