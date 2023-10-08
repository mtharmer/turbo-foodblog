# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Comment, type: :model do
  it 'allows a comment to be created' do
    expect { create(:comment) }.to change(described_class, :count).by 1
  end

  it 'requires a message to be given' do
    expect { create(:comment, message: nil) }.to raise_error(
      ActiveRecord::RecordInvalid,
      "Validation failed: Message can't be blank"
    )
  end

  it 'requires a user' do
    expect { create(:comment, user: nil) }.to raise_error(
      ActiveRecord::RecordInvalid,
      'Validation failed: User must exist'
    )
  end

  it 'requires a recipe' do
    expect { create(:comment, recipe: nil) }.to raise_error(
      ActiveRecord::RecordInvalid,
      'Validation failed: Recipe must exist'
    )
  end
end
