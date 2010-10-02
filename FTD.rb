class FTD
  DEALER_DRINKS = 5
  attr_accessor :table, :deck

  def initialize
    @deck = Deck.new
    @deck.add_deck
    @deck.shuffle

    @table = Deck.new
    @players = Player_Bench.new('FTD_Player')

    @current_card = @deck.draw
    @guess_count = 0
    @prev_guesses = Array.new
    @gets_count = 0
  end

  def player
    @players[@player]
  end

  def dealer
    @players[@dealer]
  end

  def guess(guess)
    guess = case guess
      when /j/i then 11
      when /q/i then 12
      when /k/i then 13
      when /a/i then 1
      else guess
    end

    guess = Card.new(guess, 1)
    @prev_guesses.push(guess)
    @guess_count += 1

    if @current_card < guess
      return -1
    elsif @current_card > guess
      return 1
    else
      return 0
    end
  end

  def end_turn
    last_guess = @prev_guesses.pop
    turn_results = Hash.new(0)
    if @current_card == last_guess
      turn_results[:dealers_drinks] = @guess_count * DEALER_DRINKS
      @gets_count = 0
    else
      turn_results[:players_drinks] = (last_guess - @current_card).abs
      @gets_count += 1
    end

    @guess_count = 0

    turn_results[:card_string] = @current_card.to_s
    @table.place @current_card 
    @current_card = @deck.draw

    turn_results
  end

  def to_s
    table_counts = Hash.new(0)
    @table.each do |card|
      table_counts[card.rank.to_c] += 1
    end
    puts table_counts

    output = "\nPlayed Cards:\n"
    (0..13).each { output += "-" }
    output += "\n"
    (1..4).each do |row|
      Rank::CHARS.each do |rank|
        if(table_counts[rank] >= row)
          if(table_counts[rank] == 4)
            output += "X"
          else
            output += rank.to_s
          end
        else
          rank.to_s.length.times do
            output += " " 
          end
        end
      end
      output += "\n"
    end

    (0..13).each { output += "-" }
    output += "\n"

    output
  end
end
