require 'oystercard'

describe Oystercard do

  it { expect(subject.balance).to eq 0 }

  it 'should top up by a specified amount' do
    subject.top_up(10)
    expect(subject.balance).to eq 10
  end

end
