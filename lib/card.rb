require 'active_support/inflector'

class Card
  attr_accessor :rank, :suit

  def initialize(rank, suit)
    @rank = Rank.new(rank)
    @suit = Suit.new(suit)
  end

  def to_s
    "#{@rank} of #{@suit.to_s.pluralize}"
  end

  def to_db
    "#{rank.to_n}#{suit.to_c}"
  end

  def value
    @rank.value
  end

  def <(card)
    @rank.to_n < card.rank.to_n
  end

  def >(card)
    @rank.to_n > card.rank.to_n
  end
end
