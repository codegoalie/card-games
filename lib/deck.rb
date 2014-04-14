class Deck
  include Enumerable

  def initialize
    @cards ||= []
  end

  def add_deck
    @cards ||= []
    (0..3).each do |s|
      (2..14).each do |r|
        @cards << Card.new(r, s)
      end
    end
    true
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

  def each(&block)
    @cards.each(&block)
  end
end
