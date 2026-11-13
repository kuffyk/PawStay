require 'date'
require_relative 'messages'
require_relative 'database'
require_relative 'pets'

def user_bookings(user)
  load_from_database('booking.yml').select { |b| b[:user_id] == user[:id] }
end

def ask_date
  puts 'День:'
  day = gets.chomp.strip.to_i

  puts 'Місяць (числом):'
  month = gets.chomp.strip.to_i

  puts 'Рік:'
  year = gets.chomp.strip.to_i

  return nil unless Date.valid_date?(year, month, day)

  Date.new(year, month, day)
end

def overlaps?(booking, check_in, check_out)
  check_in < booking[:check_out] && check_out > booking[:check_in]
end
