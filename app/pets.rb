require_relative 'messages'
require_relative 'database'

def user_pets(user)
  load_from_database('pets.yml').select  { |pet| pet[:user_id] == user[:id]}
end
