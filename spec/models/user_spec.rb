# frozen_string_literal: true

require 'rails_helper'

RSpec.describe User, type: :model do
  it 'allows a user to be created' do
    expect { create(:user) }.not_to raise_error
  end

  it 'persists a saved user' do
    create(:user)
    expect(described_class.first).not_to be_nil
  end

  context 'with validation' do
    it 'requires an email address' do
      expect { create(:user, email: nil) }.to raise_error(
        ActiveRecord::RecordInvalid,
        "Validation failed: Email can't be blank"
      )
    end

    it 'requires a password' do
      expect { create(:user, password: nil) }.to raise_error(
        ActiveRecord::RecordInvalid,
        "Validation failed: Password can't be blank"
      )
    end

    it 'requires unique email addresses' do
      user = create(:user)
      expect { create(:user, email: user.email) }.to raise_error(
        ActiveRecord::RecordInvalid,
        'Validation failed: Email has already been taken'
      )
    end
  end
end
