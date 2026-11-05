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


