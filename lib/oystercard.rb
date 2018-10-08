class Oystercard
  BALANCE_MAX = 90
  BALANCE_MIN = 1
  CHARGE_MIN = 1

  attr_reader :balance, :entry_station

  def initialize
    @balance = 0
    @in_journey = false
    @entry_station
  end

  def top_up(amount)
    raise "Max (£#{BALANCE_MAX}) exceeded" if balance + amount > BALANCE_MAX
    @balance += amount
  end

  def in_journey?
    !!@entry_station
  end

  def touch_in(station)
    raise "Below card minimum (£#{BALANCE_MIN})" if balance < BALANCE_MIN
    @entry_station = station.name
  end

  def touch_out
    deduct_fare(CHARGE_MIN)
    @entry_station = nil
  end

  private

  def deduct_fare(fare)
    @balance -= fare
  end

end
