# frozen_string_literal: true

require 'rails_helper'

RSpec.describe AdminUser, type: :model do
  it 'allows a user to be created' do
    expect { create(:admin_user) }.to change(AdminUser, :count).by(1)
  end

  it 'requires an email address' do
    expect { create(:admin_user, email: nil) }.to raise_error(
      ActiveRecord::RecordInvalid,
      "Validation failed: Email can't be blank"
    )
  end

  it 'requires a password' do
    expect { create(:admin_user, password: nil) }.to raise_error(
      ActiveRecord::RecordInvalid,
      "Validation failed: Password can't be blank"
    )
  end

  it 'requires unique email addresses' do
    user = create(:admin_user)
    expect { create(:admin_user, email: user.email) }.to raise_error(
      ActiveRecord::RecordInvalid,
      'Validation failed: Email has already been taken'
    )
  end
end
