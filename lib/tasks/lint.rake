# frozen_string_literal: true

require 'rubocop/rake_task'
require 'slim_lint/rake_task'

namespace :lint do
  SlimLint::RakeTask.new
  RuboCop::RakeTask.new
end
