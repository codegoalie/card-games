class Rank
  STRINGS   = ["Two", "Three", "Four", "Five", "Six", "Seven",
              "Eight", "Nine", "Ten", "Jack", "Queen", "King", "Ace" ]
  CHARS     = (2..10).to_a + [ "J", "Q", "K", "A" ]
  NUMERALS  = (2..14).to_a
  VALUES    = (2..10).to_a + [ 10, 10, 10, 10 ]
  class RankOutOfBoundsError < StandardError; end

  def initialize(rank)
    raise RankOutOfBoundsError unless (2..14).include? rank.to_i
    @rank = rank.to_i - 2
  end

  def to_s
    STRINGS[@rank]
  end

  def to_n
    NUMERALS[@rank]
  end

  def to_c
    CHARS[@rank]
  end

  def value
    VALUES[@rank]
  end
end
