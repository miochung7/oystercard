class Oystercard
  LIMIT = 70
  attr_reader :balance

  def initialize
    @balance = 0
  end

  def top_up(number)
    fail "Maximum limit of #{LIMIT} exceeded" if number + @balance > LIMIT
    @balance += number
  end
end