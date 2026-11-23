# frozen_string_literal: true

require 'terminal-table'
require 'colorize'

def show_authentication_menu
  puts 'Вітаємо в PawStay!'.cyan
  puts 'Оберіть дію:'
  puts '1: Зареєструватися'
  puts '2: Увійти'
  puts '3: Вийти'
end

def incorrect_choice
  puts 'Ви ввели невірне значення'.red
end

def show_user_menu(user)
  puts "Вітаємо, #{user[:login]}!"
  puts 'Оберіть дію:'
  puts '1: Мій профіль'
  puts '2: Мої тварини'
  puts '3: Забронювати номер'
  puts '4: Мої бронювання'
end

def show_menu_for_admin(user)
  puts "Вітаємо, #{user[:login]}!"
  puts 'Оберіть дію:'
  puts '1: Мій профіль'
  puts '2: Мої тварини'
  puts '3: Забронювати номер'
  puts '4: Мої бронювання'
  puts '5: Увійти в адмін меню'
end

def show_admin_panel(_user)
  puts 'Адмін панель:'
  puts '1: Користувачі'
  puts '2: Усі бронювання'
  puts '3: Номери'
  puts '4: Змінити бронювання'
  puts '5: Назад в меню'
end

def show_profile(user)
  puts 'Профіль'
  puts "Логін: #{user[:login]}"
  puts "Роль: #{user[:role]}"
  puts "Id: #{user[:id]}"

  puts '1: Змінити логін'
  puts '2: Змінити пароль'
  puts '3: Назад до меню'
  puts '4: Вийти з акаунту'
  puts '5: Видалити акаунт'
end

def show_pets_menu
  puts 'Мої тварини'
  puts '1: Переглянути список'
  puts '2: Додати тварину'
  puts '3: Змінити тварину'
  puts '4: Видалити тварину'
  puts '5: Назад до меню'
end

def show_pets(pets)
  rows = pets.each_with_index.map do |pet, index|
    [index + 1, pet[:name], pet[:species], pet[:age], pet[:notes]]
  end

  puts Terminal::Table.new(headings: ['№', 'Кличка', 'Вид', 'Вік', 'Нотатки'], rows: rows)
end

def show_rooms_menu
  puts 'Номери'
  puts '1: Переглянути список'
  puts '2: Додати номер'
  puts '3: Змінити номер'
  puts '4: Видалити номер'
  puts '5: Назад'
end

def show_rooms(rooms)
  rows = rooms.each_with_index.map do |room, index|
    [index + 1, room[:name], room[:species], "#{room[:price]} грн/доба"]
  end

  puts Terminal::Table.new(headings: ['№', 'Номер', 'Для кого', 'Ціна'], rows: rows)
end

def confirmed?
  gets.chomp.strip.downcase == 'так'
end
