def show_authentication_menu
  puts 'Вітаємо в PawStay!'
  puts 'Оберіть дію:'
  puts '1: Зареєструватися'
  puts '2: Увійти'
  puts '3: Вийти'
end

def incorrect_choice
  puts 'Ви ввели невірне значення'
end

def show_user_menu(user)
  puts "Вітаємо, #{user[:login]}!"
  puts 'Оберіть дію:'
  puts '1: Мій профіль'
  puts '2: Мої тварини'
  puts '3: Забронювати номер'
  puts '4: Мої бронювання'
  puts '5: Вийти з акаунта'
end

def show_menu_for_admin(user)
  puts "Вітаємо, #{user[:login]}!"
  puts '1: Мій профіль'
  puts '2: Мої тварини'
  puts '3: Забронювати номер'
  puts '4: Мої бронювання'
  puts '5: Увійти в адмін меню'
  puts '6: Вийти з акаунта'
end

def show_admin_panel(user)
  puts 'Адмін панель:'
  puts '1: Бронювання'
  puts '2: Користувачі'
  puts '3: Назад в меню'
end