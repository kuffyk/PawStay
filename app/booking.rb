require "date"
require_relative "messages"
require_relative "database"
require_relative "pets"

def user_bookings(user)
  load_from_database("booking.yml").select { |b| b[:user_id] == user[:id] }
end

def ask_date
  puts "День:"
  day = gets.chomp.strip.to_i

  puts "Місяць (числом):"
  month = gets.chomp.strip.to_i

  puts "Рік:"
  year = gets.chomp.strip.to_i

  return nil unless Date.valid_date?(year, month, day)

  Date.new(year, month, day)
end

def overlaps?(booking, check_in, check_out)
  check_in < booking[:check_out] && check_out > booking[:check_in]
end

def free_rooms(pet, check_in, check_out, ignore_id = nil)
  bookings = load_from_database('booking.yml').reject { |b| b[:id] == ignore_id }

  load_from_database('rooms.yml').select do |room|
    suits = room[:species] == 'будь-які' || room[:species] == pet[:species].downcase
    free = bookings.none? { |b| b[:room_id] == room[:id] && overlaps?(b, check_in, check_out) }

    suits && free
  end
end

def choose_free_room(rooms)
  puts "Вільні номери:"
  show_rooms(rooms)
  puts "Введіть номер зі списку"

  index = gets.chomp.strip.to_i
  room = rooms[index - 1] if index.positive?

  incorrect_choice if room.nil?
  room
end

def book_room(user)
  pets = load_from_database("pets.yml").select { |p| p[:user_id] == user[:id] }
  show_pets(pets)

  puts "Введіть номер тварини для бронювання"
  index = gets.chomp.strip.to_i
  pet = pets[index - 1]

  return if pet.nil?

  puts "Введіть дату заїзду"
  check_in = ask_date
  puts "Введіть дату виїзду"
  check_out = ask_date

  if check_in.nil? || check_out.nil?
    incorrect_choice
    return
  end

  if check_in < Date.today
    puts "Дата заїзду не може бути у минулому"
  end

  if check_out < Date.today
    puts "Дата виїзду не може бути у минулому"
    return
  end

  if check_out <= check_in
    puts "Дата виїзду має бути пізніше, ніж дата заїзду"
    return
  end

  bookings = load_from_database("booking.yml")

  if bookings.any? { |b| b[:pet_id] == pet[:id] && overlaps?(b, check_in, check_out) }
    puts "У цієї тварини вже заброньован номер на ці дати"
    return
  end

  rooms = free_rooms(pet, check_in, check_out)

  if rooms.empty?
    puts "Вільних номерів на ці дати немає"
    return
  end

  room = choose_free_room(rooms)
  return if room.nil?

  night = (check_out - check_in).to_i
  total = night * room[:price]

  puts "#{pet[:name]} #{room[:name]}, #{night} діб, вартість #{total} грн. Підтвердити бронювання? (так/ні)"

  unless confirmed?
    puts "Бронювання скасовано"
    return
  end

  last = bookings.max_by { |b| b[:id] }
  new_id = last ? last[:id] + 1 : 1

  add_to_database("booking.yml", {
    id: new_id,
    user_id: user[:id],
    pet_id: pet[:id],
    room_id: room[:id],
    check_in: check_in,
    check_out: check_out,
    total: total
  })

  puts "Номер заброньовано!"
end

def remove_expired_bookings
  bookings = load_from_database('booking.yml')
  active = bookings.reject { |b| b[:check_out] < Date.today }

  save_to_database('booking.yml', active) if active.size != bookings.size
end
