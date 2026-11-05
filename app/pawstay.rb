require_relative 'messages'
require_relative 'authentication'

def run
  loop do
    puts I18n.t('guest_menu.welcome')
    puts I18n.t('guest_menu.choose_action')
    show_authentication_menu

    user_input = gets.chomp.strip

    case user_input
    when '1' then sign_up
    when '2' then sign_in
    when '3' then
      I18n.locale = :ua
      I18n.t(:guest_menu)
    when '4' then break
    else incorrect_choice
    end
  end
end

run
