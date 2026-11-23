# frozen_string_literal: true

require 'spec_helper'

describe 'secure_password' do
  context 'when a password is created' do
    it 'returns a password hash that accepts the original password' do
      password = secure_password('password123')

      expect(password).to be_a(BCrypt::Password)
      expect(password).to eq('password123')
    end
  end
end
