# frozen_string_literal: true

require 'rails_helper'

RSpec.describe AdminUser, type: :model do
  it 'allows a user to be created' do
    expect { create(:admin_user) }.to change(described_class, :count).by(1)
  end

  context 'validations' do
    subject { build(:admin_user) }

    it { is_expected.to validate_presence_of(:email) }
    it { is_expected.to validate_presence_of(:password) }
    it { is_expected.to validate_uniqueness_of(:email).case_insensitive }
  end
end
