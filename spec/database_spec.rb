# frozen_string_literal: true

require 'spec_helper'

describe 'secure_password' do
  context 'when a password is created' do
    it 'returns a password hash that accepts the original password' do
      password = secure_password('password123')

      expect(password).to be_a(BCrypt::Password)
      expect(password).to eq('password123')
    end

    it 'does not store the original password as plain text' do
      password = secure_password('password123')

      expect(password.to_s).not_to eq('password123')
    end
  end

  context 'when a database file does not exist' do
    it 'returns an empty list' do
      expect(load_from_database('missing_spec_file.yml')).to eq([])
    end
  end
end
