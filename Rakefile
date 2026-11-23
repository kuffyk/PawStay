# frozen_string_literal: true

require 'rake'
require_relative 'app/database'

namespace :seeds do
  desc 'Create test user'
  task :create_user do
    add_to_database('users.yml',
                    { 'id' => 60, 'login' => 'test', 'password' => secure_password('123'), 'role' => 'admin' })
  end
end
