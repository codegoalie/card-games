class Player
  attr_accessor :name

  def initialize(name)
    @name = name
  end
end

class Player_Bench
  attr_accessor :players
  attr_reader :actors

  def initialize 
    @actors = Hash.new
    @actors[:dealer] = 0
    @actors[:player] = 1

    @players = Array.new
  end

  def [](i)
    @players[i]
  end

  def each(&block)
    @players.each(&block)
  end

  def add(player)
    if(player.respond_to?('name'))
      @players << player
    end
  end

  def advance(actor)
    move(actor, @actors[actor]+1)
  end

  def move(actor, destination)
    @actors[actor] = -1
    if(@actors.has_value?(destination))
      #puts "actor at #{destination}, adv 1"
      move(actor, destination+1)
    elsif(destination >= @players.length)
      #puts "#{destination} is beyond player length, move to 0"
      move(actor, 0)
    else
      #puts "#{destination} is good, moving there"
      @actors[actor] = destination
    end
  end
end



class FTD_Player < Player
  attr_accessor :turns, :correct, :bullseyes, :drinks

  def initialize(name)
    @drinks = 0
    @correct = 0
    @bullseyes = 0
    @turns = 0
    super(name)
  end

  def add_drinks(drinks)
    @drinks += drinks
  end

  def was_correct
    @correct += 1
    @turns += 1
  end

  def got_bullseye
    @bullseyes += 1
    @turns += 1
  end

  def just_turn 
    @turns += 1
  end

  def bullseye_percentage
    (@bullseyes.to_f/@turns*100.00).round(2)
  end

  def correct_percentage
    (@correct.to_f/@turns*100.00).round(2)
  end
end
