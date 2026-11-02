require_relative 'database'

def sign_up
  puts 'Введіть ваш логін'
  login = gets.chomp.strip

  users = load_from_database('users.yml')

  if users.any? { |user| user[:login] == login }
    puts 'Логін вже зайнято'
    return
  end