# frozen_string_literal: true

require 'bcrypt'
require 'yaml'

def create_database_files
  database_path = File.expand_path('../database', __dir__)

  Dir.mkdir(database_path) unless Dir.exist?(database_path)

  %w[users.yml pets.yml rooms.yml booking.yml].each do |file_name|
    file_path = File.join(database_path, file_name)

    File.write(file_path, YAML.dump([])) unless File.exist?(file_path)
  end
end

def add_to_database(file_name, new_entity)
  file_path = file_path_for(file_name)

  File.write(file_path, YAML.dump([])) unless File.exist?(file_path)

  records = load_from_database(file_name)

  records.push(new_entity)

  File.write(file_path, records.to_yaml)
end

def load_from_database(file_name)
  path = file_path_for(file_name)
  return [] unless File.exist?(path)

  YAML.safe_load_file(path, permitted_classes: [String, Symbol, Integer, BCrypt::Password, Date]) || []
end

def save_to_database(file_name, records)
  File.write(file_path_for(file_name), records.to_yaml)
end

def update_in_database(file_name, id, changes)
  records = load_from_database(file_name)
  record = records.find { |r| r[:id] == id }

  return if record.nil?

  record.merge!(changes)
  save_to_database(file_name, records)
end

def delete_from_database(file_name, id)
  records = load_from_database(file_name)

  records.reject! { |r| r[:id] == id }
  save_to_database(file_name, records)
end

def secure_password(password) = BCrypt::Password.create(password)

def file_path_for(file_name) = File.join(__dir__, '..', 'database', file_name)
