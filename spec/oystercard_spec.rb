require 'oystercard'

describe Oystercard do
  describe 'initialisation - balance' do
    it 'shows a default balance of 0' do
      oystercard = Oystercard.new
      expect(oystercard.balance).to eq 0
    end
  end

  describe '#topup' do

    it { is_expected.to respond_to(:top_up).with(1).argument }

    it 'adds money onto the card' do
      oystercard = Oystercard.new
      # oystercard.add(5)
      # expect(oystercard.balance).to eq 5
      expect{ oystercard.top_up 5 }.to change{ oystercard.balance }.by 5
    end

    it 'raises an error if balance is more than £90' do
      # oystercard = Oystercard.new
      # expect{ oystercard.top_up(95) }.to raise_error('Maximum limit is £90')
      oystercard = Oystercard.new
      limit = Oystercard::LIMIT
      oystercard.top_up(limit)
      expect { oystercard.top_up 1}.to raise_error("Maximum limit of #{limit} exceeded")
    end
  end

end