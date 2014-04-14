require 'spec_helper'

describe Rank do
  before do
    @r2 = Rank.new(2)
    @r7 = Rank.new(7)
    @rk = Rank.new(13)
  end

  it "should convert to a string" do
    @r2.to_s.should == 'Two'
    @r7.to_s.should == 'Seven'
    @rk.to_s.should == 'King'
  end

  it 'should convert to a comparable number' do
    @r2.to_n.should == 2
    @r7.to_n.should == 7
    @rk.to_n.should == 13
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
