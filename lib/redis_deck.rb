class RedisDeck < Deck
  attr_accessor :redis_key

  def initialize redis_key
    @redis_key = redis_key
    @cards ||= []
    $r.lrange(redis_key, 0, -1).each do |c|
      @cards << Card.new(c[0,c.size-1], c[-1,1])
    end
  end

  def place card
    super
    $r.rpush @redis_key, card.to_db
  end

  def draw
    $r.lpop @redis_key
    super
  end
end
