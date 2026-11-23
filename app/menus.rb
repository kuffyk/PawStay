# frozen_string_literal: true

require_relative 'messages'
require_relative 'profile'
require_relative 'pets'
require_relative 'rooms'
require_relative 'booking'

def open_menu(user)
  remove_expired_bookings

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
      return if %i[logout deleted].include?(result)
    when '2' then puts pets_menu(user)
    when '3' then book_room(user)
    when '4'
      bookings = user_bookings(user)

      if bookings.empty?
        puts 'У вас ще немає бронювань'
      else
        show_bookings(bookings)
      end
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
      return if %i[logout deleted].include?(result)
    when '2' then pets_menu(user)
    when '3' then book_room(user)
    when '4'
      bookings = user_bookings(user)

      if bookings.empty?
        puts 'У вас ще немає бронювань'
      else
        show_bookings(bookings)
      end
    when '5' then admin_menu(user)
    else incorrect_choice
    end
  end
end

def admin_menu(user)
  loop do
    show_admin_panel(user)

    case gets.chomp.strip
    when '1'
      users = load_from_database('users.yml')

      if users.empty?
        puts 'Користувачів ще немає'
      else
        rows = users.each_with_index.map do |account, index|
          [index + 1, account[:login], account[:role]]
        end

        puts Terminal::Table.new(headings: ['№', 'Логін', 'Роль'], rows: rows)
      end
    when '2'
      bookings = load_from_database('booking.yml')

      if bookings.empty?
        puts 'Бронювань немає'
      else
        show_bookings(bookings, with_owner: true)
      end
    when '3' then rooms_menu
    when '4' then edit_booking
    when '5' then return
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
      return :deleted if delete_account(user)
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
