require 'oystercard'

describe Oystercard do

  it { expect(subject.balance).to eq 0 }

  it 'should top up balance by a specified amount' do
    expect { subject.top_up 10 }.to change { subject.balance }.by 10
  end

  it 'should not be able to top up beyond the maximum card limit' do
    limit = described_class::LIMIT
    message = "Card limit (£#{limit}) exceeded!"
    expect { subject.top_up limit + 1 }.to raise_error message
  end
end
