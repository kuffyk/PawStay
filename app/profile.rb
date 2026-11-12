require_relative 'messages'
require_relative 'database'

def change_login(user)
  puts 'Введіть новий логін'
  new_login = gets.chomp.strip

  if new_login.empty?
    puts 'Логін не може бути порожнім'
    return
  end

  users = load_from_database('users.yml')

  if users.any? {|u|  u[:login] == new_login && u[:id] != user[:id]}
    puts 'Логін вже зайнято'
    return
  end

  if users.any? {|u| u[:login] == new_login && u[:id] == user[:id]}
    puts 'Ви вже маєте такий логін'
    return
  end

  update_in_database('users.yml', user[:id], { login: new_login})
  user[:login] = new_login

  puts 'Ваш логін змінено!'
end

def change_password(user)
  puts 'Введіть ваш старий пароль:'
  old_password = gets.chomp.strip

  if BCrypt::Password.new(user[:password]) != old_password
    puts 'Невірний пароль'
    return
  end

  puts 'Введіть новий пароль'
  new_password = gets.chomp.strip

  if new_password.empty?
    puts 'Новий пароль не може бути порожнім'
    return
  end

  puts 'Повторіть новий пароль'
  repeated_new_password = gets.chomp.strip

  if new_password != repeated_new_password
    puts 'Паролі не збігаються'
    return
  end

  saved_password = secure_password(new_password)

  update_in_database('users.yml', user[:id], { password: saved_password })
  user[:password] = saved_password

  puts 'Ваш пароль змінено!'
end

def delete_account(user)
  puts 'Введіть ваш пароль'
  password = gets.chomp.strip

  if BCrypt::Password.new(user[:password]) != password
    puts 'Невірний пароль'
    return false
  end

  puts 'Ви впевнені? (так/ні)'

  unless confirmed?
  puts 'Видалення скасовано'
  return false
  end

  delete_from_database('users.yml', user[:id])
  puts 'Акаунт видалено'
  true
end
