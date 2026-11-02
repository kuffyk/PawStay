require_relative 'database'

def sign_up
  puts 'Введіть логін'
  login = gets.chomp.strip

  users = load_from_database('users.yml')

  if users.any? { |u| u[:login] == login }
    puts 'Логін вже зайнято'
    return
  end

  puts 'Введіть пароль'
  password = gets.chomp.strip

  last_user = users.max_by { |u| u[:id] }
  new_id = last_user ? last_user[:id] + 1 : 1

  add_to_database('users.yml', { id: new_id, login: login, password: secure_password(password) })

  puts 'Реєстрація пройшла успішно!'
end

def sign_in
  puts 'Введіть логін'
  login = gets.chomp.strip

  puts 'Введіть пароль'
  password = gets.chomp.strip

  users = load_from_database('users.yml')
  user = users.find { |u| u[:login] == login && u[:password] == password }

  if user.nil?
    puts 'Невірний логін або пароль'
    return
  end

  puts "Ви успішно увійшли"
  user
end