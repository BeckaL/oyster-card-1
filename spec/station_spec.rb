require 'station'

describe Station do


  let(:station_1) { Station.new(:aldgate, 1) }

  it 'should have a name when created' do
    expect(station_1.name).to eq :aldgate
  end

  it 'should have a zone when created' do
    expect(station_1.zone).to eq 1
  end

end
