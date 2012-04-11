require 'rubygems'
require 'active_support/inflector'

class Suit
  STRINGS = [ "Heart", "Diamond", "Club", "Spade" ]

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
      throw SuitOutOfBoundsError
    end
  end

  def to_s
    STRINGS[@suit]
  end

  def to_c
    STRINGS[@suit][0].downcase
  end
end

class Rank
  STRINGS = [ "Two", "Three", "Four", "Five", "Six", "Seven", 
              "Eight", "Nine", "Ten", "Jack", "Queen", "King", "Ace" ]
  CHARS = ( 2..10 ).to_a + [ "J", "Q", "K", "A" ]
  NUMERALS = (0..12).to_a
  VALUES = (2..10).to_a + [ 10, 10, 10, 10 ]

  def initialize(rank)
    throw RankOutOfBoundsError unless (0..12) === rank.to_i 
    @rank = rank.to_i
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

class Deck
  def initialize
    @cards ||= []
  end

  def add_deck
    @cards ||= []
    (0..3).each do |s|
      (0..12).each do |r|
        @cards << Card.new(r, s)
      end
    end
  end

  def draw
    @cards.shift
  end
   
  def draw_all
    to_discard = @cards
    @cards = []
    to_discard
  end

  def place(card)
    if(card.respond_to?('rank') && card.respond_to?('suit'))
      @cards ||= []
      @cards << card
    end
  end

  def shuffle
    @cards = @cards.sort_by { rand }
  end

  def each
    @cards.each { |card| yield card }
  end
        
  def [](index)
    @cards[index]
  end

  def []=(index, card)
    @cards[index] = card unless card.class != Card
  end

  def <<(cards)
    @cards << cards
  end

  def size
    @cards.size
  end

  def to_db
    cards = []
    @cards.each { |card| cards << card.to_db}
    cards.join(",")
  end
end

class Player
  attr_accessor :name, :cards

  def initialize(name)
    @name = name
    @cards = []
  end
end
