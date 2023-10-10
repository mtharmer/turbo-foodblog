# frozen_string_literal: true

require 'rails_helper'

RSpec.describe User, type: :model do
  it 'allows a user to be created' do
    expect { create(:user) }.to change(described_class, :count).by 1
  end

  context 'with associations' do
    it { is_expected.to have_many(:recipes).class_name('Recipe') }
  end

  context 'with validation' do
    subject { build(:user) }

    it { is_expected.to validate_presence_of(:email) }
    it { is_expected.to validate_presence_of(:password) }
    it { is_expected.to validate_uniqueness_of(:email).case_insensitive }
  end
end
