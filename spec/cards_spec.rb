require './cards'

describe Suit do
  describe "constructor" do
    it "should create the correct Suit objects" do
      s = Suit.new(0)
      s.class.should == Suit
      s.to_s.should == "Heart"
      s = Suit.new('d')
      s.to_s.should == "Diamond"
      s.to_c.should == 'd'
    end
  end
end

describe Rank do
  before do
    @r2 = Rank.new(0)
    @r7 = Rank.new(5)
    @rk = Rank.new(11)
  end

  it "should convert to a string" do
    @r2.to_s.should == 'Two'
    @r7.to_s.should == 'Seven'
    @rk.to_s.should == 'King'
  end

  it 'should convert to a comparable number' do
    @r2.to_n.should == 0
    @r7.to_n.should == 5
    @rk.to_n.should == 11
  end

  it 'should convert to a character' do
    @r2.to_c.should == 2
    @r7.to_c.should == 7
    @rk.to_c.should == 'K'
  end

  it 'should have a value' do
    @r2.value.should == 2
    @r7.value.should == 7
    @rk.value.should == 10
  end
end

describe Card do
  subject { Card.new(5, 'h') }
  specify { subject.to_s.should == 'Seven of Hearts' }

  it 'should convert to a two character specifier' do
    subject.to_db.should == '5h'
  end

  it 'should have a value' do
    subject.value.should == 7
  end

  it 'should be greater than smaller cards' do
    cs = Card.new(3, 'd')
    subject.should be > cs
  end

  it 'should be smaller than greater cards' do
    cg = Card.new(7, 'd')
    subject.should be < cg
  end
end
