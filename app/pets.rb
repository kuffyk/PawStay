require_relative 'messages'
require_relative 'database'

def user_pets(user)
  load_from_database('pets.yml').select  { |pet| pet[:user_id] == user[:id]}
end

def list_pets(user)
  pets = user_pets(user)

  if pets.empty?
    puts 'У вас ще немає тварин'
    return
  end

  show_pets(pets)
end
