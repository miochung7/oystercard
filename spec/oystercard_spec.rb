require 'oystercard'

describe Oystercard do
  let(:oystercard) { Oystercard.new}
  let(:station) { double :station }

  describe 'initialisation - balance' do
    it 'shows a default balance of 0' do
      expect(oystercard.balance).to eq 0
    end
  end

  describe '#topup' do
    it { is_expected.to respond_to(:top_up).with(1).argument }

    it 'adds money onto the card' do
      # oystercard.add(5)
      # expect(oystercard.balance).to eq 5
      expect{ oystercard.top_up 5 }.to change{ oystercard.balance }.by 5
    end

    it 'raises an error if balance is more than £90' do
      # oystercard = Oystercard.new
      # expect{ oystercard.top_up(95) }.to raise_error('Maximum limit is £90')
      limit = Oystercard::LIMIT
      oystercard.top_up(limit)
      expect { oystercard.top_up 1}.to raise_error("Maximum limit of #{limit} exceeded")
    end
  end

  # describe '#deduct' do
  #   it 'deducts money from the balance' do
  #     oystercard.top_up(20)
  #     oystercard.deduct(10)
  #     expect(oystercard.balance).to eq (10)
  #     # expect{ oystercard.deduct 10}.to change{ oystercard.balance }.by -10
  #   end
  # end

  describe '#in_journey?' do
    it 'equals to true when touched in' do
      oystercard.top_up(10)
      oystercard.touch_in(station)
      expect(oystercard.in_journey?).to eq true
      # expect(subject).not_to be_in_journey
    end
  end


  describe '#touch_in' do
    it { is_expected.to respond_to :touch_in }

    it 'changes the status of #in_journey to true' do
      oystercard.top_up(30)
      oystercard.touch_in(station)
      expect(oystercard.in_journey?).to eq true
    end

    it 'should raise an error if balance is less than £1' do
      expect{ oystercard.touch_in(station) }.to raise_error 'Please top up!'
    end

    it 'stores the entry_station' do
      oystercard.top_up(10)
      oystercard.touch_in(station)
      expect(oystercard.entry_station).to eq station
    end
  end

  describe '#touch_out' do
    it { is_expected.to respond_to :touch_out }

    it 'changes the status of #in_journey to false' do
      # oystercard.top_up(30)
      oystercard.touch_out
      expect(oystercard.in_journey?).to eq false
    end

    it 'deducts the correct amount from the balance' do
      oystercard.top_up(40)
      oystercard.touch_in(station)
      # p oystercard.touch_out(10)
      expect{ oystercard.touch_out }.to change{ oystercard.balance }.by (-Oystercard::CHARGE)
    end
  end



end