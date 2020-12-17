class Oystercard
  LIMIT = 70
  MINIMUM = 1
  CHARGE = 5

  attr_reader :balance, :entry_station, :exit_station

  def initialize
    @balance = 0
    @entry_station = nil
    @exit_station = nil

  end

  def top_up(number)
    fail "Maximum limit of #{LIMIT} exceeded" if number + @balance > LIMIT
    @balance += number
  end

  def touch_in(station)
    # in_journey?
    fail 'Please top up!' if @balance < MINIMUM
    @entry_station = station
  end

  def touch_out(exit_station = nil)
    deduct(CHARGE)
    @entry_station = nil
  end


  def in_journey?
    # return true if @entry_station != nil
    # false
    !!entry_station
  end

  private
  def deduct(number)
    @balance -= number
  end

end