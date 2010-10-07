class FTD
  DEALER_DRINKS = 5
  MAX_GETS = 3
  MAX_GUESSES = 2
  attr_accessor :table, :deck, :players
  attr_reader :complete, :gets, :guess_count

  def initialize
    @deck = Deck.new
    @deck.add_deck
    @deck.shuffle

    @table = Deck.new
    @players = Player_Bench.new

    @current_card = @deck.draw
    @guess_count = 0
    @prev_guesses = Array.new
    @gets = 0
    @complete = false
  end

  def player
    @players[@players.actors[:player]]
  end

  def dealer
    @players[@players.actors[:dealer]]
  end

  def guess(guess)
    guess = case guess
      when /j/i then 11
      when /q/i then 12
      when /k/i then 13
      when /a/i then 14
      else guess
    end

    guess = Card.new(guess.to_i-2, 1)
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
    turn_results[:next_dealer] = false
    if @current_card.rank.to_n == last_guess.rank.to_n
      turn_results[:dealers_drinks] = (MAX_GUESSES - @guess_count+1) * DEALER_DRINKS
      @gets = 0
    else
      turn_results[:players_drinks] = (last_guess.rank.to_n - @current_card.rank.to_n).abs
      @gets += 1
    end

    if(@gets >= MAX_GETS)
      turn_results[:next_dealer] = true
      @gets = 0
    end

    @guess_count = 0

    turn_results[:card_string] = @current_card.to_s
    @table.place @current_card 
    if(@deck.size > 0)
      @current_card = @deck.draw
    else
      @complete = true
    end

    turn_results
  end

  def status
    table_counts = Hash.new(0)
    @table.each do |card|
      table_counts[card.rank.to_c] += 1
    end
    #puts table_counts

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
