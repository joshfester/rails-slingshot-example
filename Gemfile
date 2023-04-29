source "https://rubygems.org"
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby "3.2.2"

# Bundle edge Rails instead: gem "rails", github: "rails/rails", branch: "main"
gem "rails", "~> 7.0.4"

# The original asset pipeline for Rails [https://github.com/rails/sprockets-rails]
gem "sprockets-rails"

# Use postgresql as the database for Active Record
gem "pg", "~> 1.1"

# Use the Puma web server [https://github.com/puma/puma]
gem "puma", "~> 5.0"

# Bundle and transpile JavaScript [https://github.com/rails/jsbundling-rails]
gem "jsbundling-rails"

# Hotwire's SPA-like page accelerator [https://turbo.hotwired.dev]
gem "turbo-rails"

# Hotwire's modest JavaScript framework [https://stimulus.hotwired.dev]
gem "stimulus-rails"

# Bundle and process CSS [https://github.com/rails/cssbundling-rails]
gem "cssbundling-rails"

# Use Kredis to get higher-level data types in Redis [https://github.com/rails/kredis]
# gem "kredis"

# Use Active Model has_secure_password [https://guides.rubyonrails.org/active_model_basics.html#securepassword]
# gem "bcrypt", "~> 3.1.7"

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem "tzinfo-data", platforms: %i[mingw mswin x64_mingw jruby]

# Reduces boot times through caching; required in config/boot.rb
gem "bootsnap", require: false

# Use Sass to process CSS
gem "sassc-rails"

# Use Active Storage variants [https://guides.rubyonrails.org/active_storage_overview.html#transforming-images]
# gem "image_processing", "~> 1.2"

gem "action_policy", "~> 0.6.5"
gem "avo", "~> 2.31.0"
gem "brakeman", "~> 5.4.1"
gem "devise", "~> 4.9.0"
gem "good_job", "~> 3.14.1"
gem "hiredis", "~> 0.6.3"
gem "oj", "~> 3.14.2"
gem "pagy", "~> 6.0"
gem "rack-attack", "~> 6.6.1"
gem "rails-pg-extras", "~> 5.2.1"
gem "ransack", "~> 4.0.0"
gem "redis", "~> 4.8.1"
gem "sitemap_generator", "~> 6.3.0"

# Avo does not work with view_component 3.0 yet
gem "view_component", "~> 3.0.0"

group :development, :test do
  gem "bullet"
  gem "dotenv-rails"
  gem "rubocop-rails", require: false
  gem "standard", "~> 1.24.3"
end

group :development do
  gem "foreman"
  gem "debug", "~> 1.7.1"

  # Use console on exceptions pages [https://github.com/rails/web-console]
  gem "web-console"

  # Add speed badges [https://github.com/MiniProfiler/rack-mini-profiler]
  # gem "rack-mini-profiler"

  # Speed up commands on slow machines / big apps [https://github.com/rails/spring]
  # gem "spring"

  gem "letter_opener"
end

group :test do
  # Use system testing [https://guides.rubyonrails.org/testing.html#system-testing]
  gem "capybara"
  gem "selenium-webdriver"
  gem "webdrivers"

  gem "factory_bot_rails", "~> 6.2.0"
end
