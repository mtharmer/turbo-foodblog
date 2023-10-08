source "https://rubygems.org"
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby "3.0.4"

# Easy to use administration gem
gem "activeadmin", "~> 3.0"

# Use Active Model has_secure_password [https://guides.rubyonrails.org/active_model_basics.html#securepassword]
# gem "bcrypt", "~> 3.1.7"

# Reduces boot times through caching; required in config/boot.rb
gem "bootsnap", require: false

# Authorization gem to manage user roles and permissions
gem "cancancan", "~> 3.5"

# Bundle and process CSS [https://github.com/rails/cssbundling-rails]
gem "cssbundling-rails"

# Authentication gem for users and admins
gem "devise", "~> 4.9"

# Use Active Storage variants [https://guides.rubyonrails.org/active_storage_overview.html#transforming-images]
# gem "image_processing", "~> 1.2"

# Build JSON APIs with ease [https://github.com/rails/jbuilder]
gem "jbuilder"

# Use Kredis to get higher-level data types in Redis [https://github.com/rails/kredis]
# gem "kredis"

# Use postgresql as the database for Active Record
gem "pg", "~> 1.1"

# Use the Puma web server [https://github.com/puma/puma]
gem "puma", "~> 5.0"

# Bundle edge Rails instead: gem "rails", github: "rails/rails", branch: "main"
gem "rails", "~> 7.0.8"

# Use Redis adapter to run Action Cable in production
gem "redis", "~> 4.0"

# Use Sass to process CSS
gem "sassc-rails"

# Background job manager gem
gem "sidekiq", "~> 7.1"

# HTML processor gem to replace ERB
gem "slim", "~> 5.1"

# The original asset pipeline for Rails [https://github.com/rails/sprockets-rails]
gem "sprockets-rails"

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem "tzinfo-data", platforms: %i[mingw mswin x64_mingw jruby]

group :development, :test do
  gem "benchmark-ips"
  # See https://guides.rubyonrails.org/debugging_rails_applications.html#debugging-with-the-debug-gem
  gem "debug", platforms: %i[mri mingw x64_mingw]
  gem "rubocop", "~> 1.56", require: false
  gem "rubocop-rails", "~> 2.21", require: false
  gem "rubocop-rspec", "~> 2.24", require: false
  gem "slim_lint", "~> 0.24.0"
end

group :test do
  gem "capybara", "~> 3.39"
  gem "factory_bot_rails", "~> 6.2"
  gem "faker", "~> 3.2"
  gem "rspec-rails", "~> 6.0"
  gem "rspec-retry", "~> 0.6.2"
  gem "rspec-sidekiq", "~> 4.0"
  gem "selenium-webdriver", "~> 4.13"
  gem "simplecov", "~> 0.22.0", require: false
end

group :development do
  gem "better_errors", "~> 2.10"
  gem "binding_of_caller", "~> 1.0"
  gem "html2slim", "~> 0.2.0"

  # Use console on exceptions pages [https://github.com/rails/web-console]
  gem "web-console"

  # Add speed badges [https://github.com/MiniProfiler/rack-mini-profiler]
  # gem "rack-mini-profiler"

  # Speed up commands on slow machines / big apps [https://github.com/rails/spring]
  # gem "spring"
end
