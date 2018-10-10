class Oystercard
  BALANCE_MAX = 90
  BALANCE_MIN = 1
  CHARGE_MIN = 1

  attr_reader :balance, :journeys
  attr_accessor :current_journey

  def initialize
    @balance = 0
    @current_journey
    @journeys = []
  end

  def top_up(amount)
    raise "Max (£#{BALANCE_MAX}) exceeded" if balance + amount > BALANCE_MAX
    @balance += amount
  end

  def in_journey?
    !!@current_journey
  end

  def touch_in(station)
    raise "Below card minimum (£#{BALANCE_MIN})" if balance < BALANCE_MIN
    @current_journey = Journey.new
    @current_journey.start(station)
  end

  def touch_out(station)
    @current_journey.end(station, self)
    complete_journey(@current_journey)
  end

  private

  def complete_journey(data)
    @journeys << data
    @current_journey = nil
    deduct_fare(CHARGE_MIN)
  end

  def deduct_fare(fare)
    @balance -= fare
  end

end
