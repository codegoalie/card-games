def Player
  attr_accessor :name
end

def Player_Bench
  attr_accessor :players

  def initialize 
    @actors[:dealer] = 0
    @actors[:player] = 1
  end

  def add_player(player)
    if(player.respond_to?('name'))
      @players < player
    end
  end

  def advance_player(actor)
    move_player(actor, @actors[actor]+1)
  end

  def move_player(actor, destination)
    if(@actors.has_value(destination))
      move_player(actor, destination+1)
    elsif(destination >= actors.length)
      move_player(actor, 0)
    else
      @actors[actor] = destination
    end
  end
end



def FTD_Player < Player
  attr_accessor :turns, :correct, :first_shot, :drinks

  def initialize
    @drinks = 0
    @correct = 0
    @first_shot = 0
  end
end


