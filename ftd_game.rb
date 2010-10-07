require './cards.rb'
require './FTD.rb'
require './Players.rb'
require 'active_support/inflector'

MAX_GUESSES = 2

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
game.players.add(FTD_Player.new("Chris"))

puts "Here we go!"
#print out the table and current dealer & player
puts game.status

while ! game.complete do
  while game.guess_count <= MAX_GUESSES do
    puts "It's #{game.player.name}'s turn"
    guess_string = game.guess_count == 0 ? "1st" : "2nd"
    puts "#{game.player.name}, what is your #{guess_string} guess?"
    # game.guess returns -1 if guess is too high, 1 if guess is too low and 0 if guess is correct
    case game.guess(gets.chomp)
    when -1
      puts "Lower"
    when 1
      puts "Higher"
    else
      puts "Correct!"
      break
    end
  end

  #end of turn (end_turn handles stats and drink calculations but DOES NOT ADVANCE THE PLAYERS)
  turn_results = game.end_turn
  puts "The Card was #{turn_results[:card_string]}"
  puts "#{game.player.name} drinks #{turn_results[:players_drinks]}"
  puts "#{game.dealer.name} drinks #{turn_results[:dealers_drinks]}"

  if game.gets == 3
    puts "That's 3! #{game.dealer.name} gets to pass the deck!"
    game.advance_dealer
  else
    puts "#{game.dealer.name} has #{game.gets_count} gets"
    game.advance_player
  end
  
  puts game.status
end
