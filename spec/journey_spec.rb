require 'journey'
require 'pry'

describe Journey do
  let(:card) { double(:oystercard, balance: 10, journeys: []) }
  let(:station_1) { double(:station, name: :aldgate, zone: 1) }
  let(:station_2) { double(:station, name: :brixton, zone: 2) }

  it 'stores journey information once completed' do
    allow(card).to receive(:touch_in).with(:station_1)
  end

  it 'stores entry station data' do
    subject.start(station_1)
    expect(subject.data.values).to include(station_1.name, station_1.zone)
  end

  it 'stores end station data' do
    allow(card).to receive(:complete_journey)
    subject.end(station_2, card)
    expect(subject.data.values).to include(station_2.name, station_2.zone)
  end


end
