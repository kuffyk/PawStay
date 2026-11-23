# frozen_string_literal: true

require 'spec_helper'

describe 'password check' do
  context 'when the password is correct' do
    it 'matches the saved password hash' do
      password_hash = BCrypt::Password.new(secure_password('password123'))

      expect(password_hash == 'password123').to eq(true)
    end
  end

  context 'when the password is incorrect' do
    it 'does not match the saved password hash' do
      password_hash = BCrypt::Password.new(secure_password('password123'))

      expect(password_hash == 'password').to eq(false)
    end
  end
end
