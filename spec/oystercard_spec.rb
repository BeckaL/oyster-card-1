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

  it 'deducts fare from balance' do
    subject.top_up(10)
    expect { subject.deduct_fare(3) }.to change { subject.balance }.by -3
  end

  it 'should not be in journey when created' do
    expect(subject).not_to be_in_journey
  end

  it 'touch in means card is in journey' do
    subject.touch_in
    expect(subject).to be_in_journey
  end

  it 'touching out means card is not in journey' do
    subject.touch_in
    subject.touch_out
    expect(subject).not_to be_in_journey
  end

end
