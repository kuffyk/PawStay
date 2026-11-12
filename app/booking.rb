require 'date'
require_relative 'messages'
require_relative 'database'
require_relative 'pets'

def user_bookings(user)
  load_from_database('booking.yml').select { |b| b[:user_id] == user[:id] }
end
