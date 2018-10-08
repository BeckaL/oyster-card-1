class Oystercard
  BALANCE_MAX = 90
  BALANCE_MIN = 1

  attr_reader :balance

  def initialize
    @balance = 0
    @in_journey = false
  end

  def top_up(amount)
    raise "Max (£#{BALANCE_MAX}) exceeded" if balance + amount > BALANCE_MAX
    @balance += amount
  end

  def deduct_fare(fare)
    @balance -= fare
  end

  def in_journey?
    @in_journey
  end

  def touch_in
    raise "Below card minimum (£#{BALANCE_MIN})" if balance < BALANCE_MIN
    @in_journey = true
  end

  def touch_out
    @in_journey = false
  end

end
