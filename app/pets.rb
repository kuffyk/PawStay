require_relative 'messages'
require_relative 'database'

def user_pets(user)
  load_from_database('pets.yml').select  { |pet| pet[:user_id] == user[:id]}
end

def list_pets(user)
  pets = user_pets(user)

  if pets.empty?
    puts 'У вас ще немає тварин'
    return
  end

  show_pets(pets)
end

def add_pet(user)
  puts 'Введіть кличку'
  name = gets.chomp.strip

  if name.empty?
    incorrect_choice
    return
  end
end

puts 'Введіть вид (кіт, собака..)'
  species = gets.chomp.strip

  if species.empty?
    puts incorrect_choice
    return
  end
  puts 'Введіть вік (повних років)'
  age = gets.chomp.strip.to_i

  if age.nil? || age.negative?
    puts incorrect_choice
    return
  end

  puts 'Особливі нотатки (необов`язково)'
  notes = gets.chomp.strip

  pets = load_from_database('pets.yml')
  last_pet = pets.max_by { |pet| pet[:id] }
  new_id = last_pet ? last_pet[:id] + 1 : 1

  add_to_database('pets.yml', { id: new_id, user_id: user[:id], name: name, species: species, age: age, notes: notes })

  puts 'Тварину додано!'
end

def delete_pet(user)
  pets = user_pets(user)

  if pets.empty?
    puts 'У вас ще немає тварин'
    return
  end

  show_pets(pets)
  puts 'Введіть номер тварини для видалення'

  index = gets.chomp.strip.to_i
  pet = pets[index - 1] if index&.positive?

  if pet.nil?
    incorrect_choice
    return
  end

  puts "Видалити #{pet[:name]}? (так/ні)"

  if gets.chomp.strip.downcase == 'ні'
    puts 'Видалення скасовано'
    return
  end

  delete_from_database('pets.yml', pet[:id])
  puts 'Тварину видалено'
end
