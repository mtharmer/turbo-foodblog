# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'home/index', type: :view do
  it 'renders the homepage' do
    render
    assert_select 'h1', text: Regexp.new('Welcome!'.to_s)
  end
end
