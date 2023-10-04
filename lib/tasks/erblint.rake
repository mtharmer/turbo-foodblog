# frozen_string_literal: true

namespace :linters do
  task erblint: :environment do
    exec('bundle exec erblint --lint-all')
  end
end
