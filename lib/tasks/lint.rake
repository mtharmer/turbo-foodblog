# frozen_string_literal: true

require 'rubocop/rake_task'

namespace :lint do
  desc 'Run erblint with --lint-all'
  task erb: :environment do
    exec('bundle exec erblint --lint-all')
  end

  RuboCop::RakeTask.new
end
