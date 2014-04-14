require 'spec_helper'

describe Suit do
  describe 'initialization' do
    it 'creates the correct Suit objects' do
      s = Suit.new(0)
      s.class.should == Suit
      s.to_s.should == 'Heart'
      s = Suit.new('d')
      s.to_s.should == 'Diamond'
      s.to_c.should == 'd'
    end
  end
end
