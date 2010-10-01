class FTD
  DEALER_DRINKS = 5

  def initialize
    @deck = Deck.new
    @deck.add_deck
    @deck.shuffle

    @table = Deck.new
    @players = Array.new

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
    case guess
    when /j/i
      guess = 11
    when /q/i
      guess = 12
    when /k/i
      guess = 13
    when /a/i 
      guess = 1
    end

    guess = Card.new(guess, 1)
    @prev_guesses.push(guess)
    @guess_count += 1

    if @current_card < guess
      return -1
    else if @current_card > guess
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
    output = "\nPlayed Cards:\n"
    (0..12).each do 
      output += "-"
    end
    output += "\n"

    output
  end
end
end
