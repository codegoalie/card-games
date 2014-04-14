require './new_cards.rb'

COLUMN_HEIGHT = 10

def aceless_deck
  deck = Deck.new
  deck.add_deck
  deck.cards.delete_at 12
  deck.cards.delete_at 24
  deck.cards.delete_at 36
  deck.cards.delete_at 48
  deck
end

def print_grid
  COLUMN_HEIGHT.times do |i|
    print_heart = @ace_heights['Heart']     == i
    print_diamond = @ace_heights['Diamond'] == i
    print_club = @ace_heights['Club']       == i
    print_spade = @ace_heights['Spade']     == i

    # tops of cards
    print "+-+ "
    print print_heart   ? "+-+" : "   "
    print print_diamond ? "+-+" : "   "
    print print_club    ? "+-+" : "   "
    print print_spade   ? "+-+" : "   "
    print "\n"


    # card body
    # column
    if i > @current_col
      print "|#{@column[i].suit.to_c}| "
    else
      print "|*| "
    end
    print print_heart   ? "|h|" : "   "
    print print_diamond ? "|d|" : "   "
    print print_club    ? "|c|" : "   "
    print print_spade   ? "|s|" : "   "
    print "\n"

    # card bottoms
    print "+-+ "
    print print_heart   ? "+-+" : "   "
    print print_diamond ? "+-+" : "   "
    print print_club    ? "+-+" : "   "
    print print_spade   ? "+-+" : "   "
    print "\n"
  end
end

deck = aceless_deck

deck.shuffle
@column = Deck.new

COLUMN_HEIGHT.times do
  @column << deck.draw
end

@ace_heights = { 'Heart' => COLUMN_HEIGHT-1,
                 'Diamond' => COLUMN_HEIGHT-1,
                 'Club' => COLUMN_HEIGHT-1,
                 'Spade' => COLUMN_HEIGHT-1 }
@ace_peaks   = { 'Heart' => COLUMN_HEIGHT-1,
                 'Diamond' => COLUMN_HEIGHT-1,
                 'Club' => COLUMN_HEIGHT-1,
                 'Spade' => COLUMN_HEIGHT-1 }
@current_col = COLUMN_HEIGHT - 1

puts "Game Start"
print_grid
puts "Press enter to draw first card..."
input = gets

while @ace_heights['Heart']   < COLUMN_HEIGHT &&
      @ace_heights['Diamond'] < COLUMN_HEIGHT &&
      @ace_heights['Club']    < COLUMN_HEIGHT &&
      @ace_heights['Spade']   < COLUMN_HEIGHT

  deck = aceless_deck if deck.size == 0
  current_card = deck.draw
  @ace_heights[current_card.suit.to_s] -= 1
  @ace_peaks[current_card.suit.to_s] -= 1

  if @ace_peaks['Heart']     < @current_col &&
     @ace_peaks['Diamond']   < @current_col &&
     @ace_peaks['Club']      < @current_col &&
     @ace_peaks['Spade']     < @current_col &&
     @ace_heights['Heart']   < @current_col &&
     @ace_heights['Diamond'] < @current_col &&
     @ace_heights['Club']    < @current_col &&
     @ace_heights['Spade']   < @current_col

    puts "Decrementing #{@column[@current_col].suit.to_s}"
    @ace_heights[@column[@current_col].suit.to_s] += 1
    @current_col -= 1
  end

  puts "\n\n\n\n"
  puts "Card Drawn: #{current_card}"

  print_grid

  puts "Press enter to draw next card..."
  input = gets
end
