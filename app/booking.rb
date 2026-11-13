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

def free_rooms(pet, check_in, check_out)
  bookings = load_from_database('booking.yml')

  load_from_database('rooms.yml').select do |room|
    suits = room[:species] == 'будь-які' || room[:species] == pet[:species].downcase
    free = bookings.none? { |b| b[:room_id] == room[:id] && overlaps?(b, check_in, check_out) }

    suits
    free
  end
end

rooms = free_rooms(pet, check_in, check_out)

def choose_free_room(rooms)
  puts 'Вільні номери:'
  show_rooms(rooms)
  puts 'Введіть номер зі списку'

  index = gets.chomp.strip.to_i
  room = rooms[index - 1] if index.positive?

  incorrect_choice if room.nil?
  room
end
