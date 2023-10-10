# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Comment, type: :model do
  it 'allows a comment to be created' do
    expect { create(:comment) }.to change(described_class, :count).by 1
  end

  context 'associations' do
    subject { build(:comment) }

    it { is_expected.to belong_to(:user) }
    it { is_expected.to belong_to(:recipe) }
  end

  context 'validations' do
    subject { build(:comment) }

    it { is_expected.to validate_presence_of(:message) }
  end
end
