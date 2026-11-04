require_relative 'messages'

def open_menu(user)
  case user[:role]
  when 'admin' then admin_main_menu(user)
  else user_menu(user)
  end
end

def user_menu(user)
  loop do
    show_user_menu(user)

    case gets.chomp.strip
    when '1' then puts 'Профіль'
    when '2' then puts 'Мої тварини'
    when '3' then puts 'Бронювання'
    when '4' then puts 'Мої бронювання'
    when '5' then return
    else incorrect_choice
    end
  end
end

def admin_main_menu(user)
  loop do
    show_menu_for_admin(user)

    case gets.chomp.strip
    when '1' then puts 'Профіль'
    when '2' then puts 'Мої тварини'
    when '3' then puts 'Бронювання'
    when '4' then puts 'Мої бронювання'
    when '5' then admin_menu(user)
    when '6' then return
    else incorrect_choice
    end
  end
end

def admin_menu(user)
  loop do
    show_admin_panel(user)

    case gets.chomp.strip
    when '1' then puts 'Користувачі'
    when '2' then puts 'Усі бронювання'
    when '3' then puts 'Номери'
    when '4' then return
    else incorrect_choice
    end
  end
end