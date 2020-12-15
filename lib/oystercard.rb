class Oystercard
  LIMIT = 70
  MINIMUM = 1
  CHARGE = 5

  attr_reader :balance
  attr_accessor :in_journey

  def initialize
    @balance = 0
    @in_journey = false
  end

  def top_up(number)
    fail "Maximum limit of #{LIMIT} exceeded" if number + @balance > LIMIT
    @balance += number
  end

  def touch_in
    fail 'Please top up!' if @balance < MINIMUM
    @in_journey = true
  end

  def touch_out
    deduct(CHARGE)
    @in_journey = false
    
  end

  private
  def deduct(number)
    @balance -= number
  end

end