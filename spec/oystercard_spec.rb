require 'oystercard'

describe Oystercard do

  let(:station) { double :station, name: :aldgate, zone: 1 }
  let(:station_2) { double :station, name: :euston, zone: 1 }
  let(:current_journey) { { entry: station.name, entry_zone: station.zone, exit: station_2.name, exit_zone: station_2.zone } }

  it { expect(subject.balance).to eq 0 }

  describe "#top_up" do
    it 'should top up balance by a specified amount' do
      expect { subject.top_up 10 }.to change { subject.balance }.by 10
    end

    it 'should not be able to top up beyond the maximum card limit' do
      limit = described_class::BALANCE_MAX
      message = "Max (£#{limit}) exceeded"
      expect { subject.top_up limit + 1 }.to raise_error message
    end
  end

  context "has sufficient card balance" do
    before do
      subject.top_up(10)
    end

    it 'touch in means card is in journey' do
      subject.touch_in(station)
      expect(subject).to be_in_journey
    end

    it 'deducts fare on touching out' do
      subject.current_journey = { entry: station.name, entry_zone: station.zone, exit: station_2.name, exit_zone: station_2.zone }
      allow(subject.current_journey).to receive(:end)
      charge = described_class::CHARGE_MIN
      expect { subject.touch_out(station) }.to change { subject.balance }.by -charge
    end

    it 'saves its entry station after touch in' do
      subject.touch_in(station)
      expect(subject.entry_station).to eq station.name
    end

  end

  context "completes one journey" do
    before do
      subject.top_up(10)
      subject.touch_in(station)
      subject.touch_out(station_2)
    end

    it 'should store a journey in its list of journeys' do
      expect(subject.journeys).to include current_journey
    end

    it 'should not have an entry station after touching out' do
      expect(subject.entry_station).to be_nil
    end

    it 'touching out means card is not in journey' do
      expect(subject).not_to be_in_journey
    end

  end

  it 'should not be in journey when created' do
    expect(subject).not_to be_in_journey
  end

  it 'cannot touch in with less than minimum balance' do
    minimum = described_class::BALANCE_MIN
    message = "Below card minimum (£#{minimum})"
    expect { subject.touch_in(station) }.to raise_error message
  end

  it 'should be created with an accessible list of previous journeys' do
    expect(subject.journeys).to be_empty
  end

end
