# frozen_string_literal: true

module AuthHelpers
  def sign_in_user(admin)
    Rails.application.env_config['devise.mapping'] = Devise.mappings[:admin]
    sign_in admin
  end

  def sign_in_admin(user)
    Rails.application.env_config['devise.mapping'] = Devise.mappings[:user]
    sign_in user
  end
end
