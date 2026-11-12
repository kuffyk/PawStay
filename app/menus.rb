require_relative 'messages'
require_relative 'profile'
require_relative 'pets'
require_relative 'rooms'

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
    when '1'
    result = profile_menu(user)
    if result == :logout || result == :deleted
      return
    end
    when '2' then puts pets_menu(user)
    when '3' then puts 'Бронювання'
    when '4' then puts 'Мої бронювання'
    else incorrect_choice
    end
  end
end

def admin_main_menu(user)
  loop do
    show_menu_for_admin(user)

    case gets.chomp.strip
    when '1'
    result = profile_menu(user)
    if result == :logout || result == :deleted
      return
    end
    when '2' then pets_menu(user)
    when '3' then puts 'Бронювання'
    when '4' then puts 'Мої бронювання'
    when '5' then admin_menu(user)
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
    when '3' then rooms_menu
    when '4' then return
    else incorrect_choice
    end
  end
end

def profile_menu(user)
  loop do
    show_profile(user)

    case gets.chomp.strip
    when '1' then change_login(user)
    when '2' then change_password(user)
    when '3' then return
    when '4' then return :logout
    when '5' 
      if delete_account(user)
    return :deleted
      end
    else incorrect_choice
    end
  end
end

def pets_menu(user)
  loop do
    show_pets_menu

    case gets.chomp.strip
    when '1' then list_pets(user)
    when '2' then add_pet(user)
    when '3' then edit_pet(user)
    when '4' then delete_pet(user)
    when '5' then return
    else incorrect_choice
    end
  end
end

def rooms_menu
  loop do
    show_rooms_menu

    case gets.chomp.strip
    when '1' then list_rooms
    when '2' then add_room
    when '3' then edit_room
    when '4' then delete_room
    when '5' then return
    else incorrect_choice
    end
  end
end
