# frozen_string_literal: true

require 'spec_helper'

describe 'overlaps?' do
  context 'when bookings use adjacent dates' do
    it 'returns false' do
      booking = { check_in: Date.new(2030, 5, 1), check_out: Date.new(2030, 5, 5) }

      expect(overlaps?(booking, Date.new(2030, 5, 5), Date.new(2030, 5, 8))).to eq(false)
    end
  end

  context 'when bookings share a date' do
    it 'returns true' do
      booking = { check_in: Date.new(2030, 5, 1), check_out: Date.new(2030, 5, 5) }

      expect(overlaps?(booking, Date.new(2030, 5, 4), Date.new(2030, 5, 8))).to eq(true)
    end
  end
end
