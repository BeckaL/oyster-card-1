class Journey

  attr_reader :data

  def initialize
    @data = { entry: nil, entry_zone: nil, exit: nil, exit_zone: nil }
  end

  def start(station)
    @data[:entry] = station.name
    @data[:entry_zone] = station.zone
  end

  def end(station, card)
    @data[:exit] = station.name
    @data[:exit_zone] = station.zone
  end

end
