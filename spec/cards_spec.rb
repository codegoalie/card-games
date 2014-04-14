require 'spec_helper'

describe Card do
  subject { Card.new(7, 'h') }
  specify { subject.to_s.should == 'Seven of Hearts' }

  it 'should convert to a two character specifier' do
    subject.to_db.should == '7h'
  end

  it 'should have a value' do
    subject.value.should == 7
  end

  it 'should be greater than smaller cards' do
    cs = Card.new(3, 'd')
    subject.should be > cs
  end

  it 'should be smaller than greater cards' do
    cg = Card.new(9, 'd')
    subject.should be < cg
  end
end
