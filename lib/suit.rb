class Suit
  STRINGS = [ "Heart", "Diamond", "Club", "Spade" ]
  class SuitOutOfBoundsError < StandardError; end

  def initialize(suit)
    @suit = case suit
            when 0, /h/i
              0
            when 1, /d/i
              1
            when 2, /c/i
              2
            when 3, /s/i
              3
            else
              raise SuitOutOfBoundsError
            end
  end

  def to_s
    STRINGS[@suit]
  end

  def to_c
    STRINGS[@suit].chr.downcase
  end
end
