def user_input
  gets.chomp
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