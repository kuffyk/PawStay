require_relative 'messages'
require_relative 'database'

def list_rooms
  rooms = load_from_database('rooms.yml')

  if rooms.empty?
    puts 'Номерів ще немає'
    return
  end

  show_rooms(rooms)
end

def choose_species
  puts 'Для кого номер? 1 - кіт, 2 - собака, 3 - будь-які'

  case gets.chomp.strip
  when '1' then 'кіт'
  when '2' then 'собака'
  when '3' then 'будь-які'
  end
end

def choose_room(action_text)
  rooms = load_from_database('rooms.yml')

  if rooms.empty?
    puts 'Номерів ще немає'
    return nil
  end

  show_rooms(rooms)
  puts action_text

  index = gets.chomp.strip.to_i
  room = rooms[index - 1] if index > 0

  incorrect_choice if room.nil?
  room
end

def add_room
  puts 'Введіть назву номера'
  name = gets.chomp.strip

  if name.empty?
    puts 'Назва не може бути порожньою'
    return
  end

  rooms = load_from_database('rooms.yml')

  if rooms.any? { |r| r[:name] == name }
    puts 'Номер з такою назвою вже існує'
    return
  end

  species = choose_species

  if species.nil?
    incorrect_choice
    return
  end

  puts 'Введіть ціну за добу (грн)'
  price = gets.chomp.strip.to_i

  if price <= 0
    puts 'Ціна має бути числом більше 0'
    return
  end

  last_room = rooms.max_by { |r| r[:id] }
  new_id = last_room ? last_room[:id] + 1 : 1

  add_to_database('rooms.yml', { id: new_id, name: name, species: species, price: price })

  puts 'Номер додано!'
end

def edit_room
  room = choose_room('Введіть номер зі списку для зміни')
  return if room.nil?

  changes = {}

  puts "Назва (зараз: #{room[:name]}). Enter - залишити"
  name = gets.chomp.strip
  changes[:name] = name unless name.empty?

  puts "Ціна (зараз: #{room[:price]}). Enter - залишити"
  price_input = gets.chomp.strip

  unless price_input.empty?
    price = price_input.to_i

    if price <= 0
      puts 'Ціна має бути числом більше 0'
      return
    end

    changes[:price] = price
  end

  if changes.empty?
    puts 'Нічого не змінено'
    return
  end

  update_in_database('rooms.yml', room[:id], changes)
  puts 'Номер оновлено!'
end

def delete_room
  room = choose_room('Введіть номер зі списку для видалення')
  return if room.nil?

  puts "Видалити #{room[:name]}? (так/ні)"

if gets.chomp.strip.downcase == 'ні'
    puts 'Видалення скасовано'
    return
  end

  delete_from_database('rooms.yml', room[:id])
  puts 'Номер видалено'
end
