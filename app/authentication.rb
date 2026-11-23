# frozen_string_literal: true

require_relative 'database'
require_relative 'messages'
require_relative 'menus'
require 'i18n'

ADMIN_CODE = 'pawstay-admin'

def sign_up
  puts 'Введіть логін'
  login = gets.chomp.strip

  users = load_from_database('users.yml')

  if users.any? { |u| u[:login] == login }
    puts 'Логін вже зайнято'.red
    return
  end

  puts 'Введіть пароль'
  password = gets.chomp.strip

  puts 'Оберіть роль: 1 - користувач, 2 - адміністратор'
  role_choice = gets.chomp.strip

  case role_choice
  when '1'
    role = 'user'
  when '2'
    puts 'Введіть код адміністратора'
    admin_code = gets.chomp.strip

    if admin_code != ADMIN_CODE
      puts 'Невірний код адміністратора'.red
      return
    end

    role = 'admin'
  else
    incorrect_choice
    return
  end

  last_user = users.max_by { |u| u[:id] }
  new_id = last_user ? last_user[:id] + 1 : 1

  add_to_database('users.yml', { id: new_id, login: login, password: secure_password(password), role: role })

  puts 'Реєстрація пройшла успішно!'.green
end

def sign_in
  puts 'Введіть логін'
  login = gets.chomp.strip

  puts 'Введіть пароль'
  password = gets.chomp.strip

  users = load_from_database('users.yml')
  user = users.find do |u|
    u[:login] == login && BCrypt::Password.new(u[:password]) == password
  end

  if user.nil?
    puts 'Невірний логін або пароль'.red
    return
  end

  puts 'Ви успішно увійшли'.green

  open_menu(user)

  user
end
