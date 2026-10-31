require "yaml"

def user_input
  gets.chomp
end

def login
  puts "Введіть ваш логін: "
  input_login = user_input
  puts "Введіть ваш пароль: "
  input_password = user_input

  users = File.exist?("users.yml") ? YAML.load_file("users.yml") : {}

  if users[input_login] == input_password
    puts "Успішний вхід"
  else
    puts "Невірний логін або пароль"
  end
end

def authenticate
  loop do
    puts "1 - Вхід"
    puts "2 - Реєстрація"
    print "Оберіть дію: "
    
    choice = gets.chomp

    if choice == "1"
      login
      break
    elsif choice == "2"
      register
      break
    else
      puts "Невірний ввід, спробуйте знову.\n\n"
    end
  end
end