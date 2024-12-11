# frozen_string_literal: true

source "https://rubygems.org"

# Bundle edge Rails instead: gem "rails", github: "rails/rails", branch: "main"
gem "active_model_serializers", "~> 0.10.13"
gem "bootsnap", require: false
gem "image_processing", "~> 1.2"
gem "pagy"
gem "pg", "~> 1.5"
gem "puma", ">= 5.0"
gem "rack-cors"
gem "rails", "~> 7.2.2"
gem "tzinfo-data", platforms: %i[windows jruby]

group :development, :test do
  gem "brakeman", require: false
  gem "debug", platforms: %i[mri mingw x64_mingw]
  gem "factory_bot_rails"
  gem "faker"
  gem "pry"
  gem "rspec-rails", "~> 7.1.0"
  gem "rubocop-rails-omakase", require: false
end

group :test do
  gem "shoulda-matchers"
  gem "simplecov", require: false
  gem "timecop"
end

group :development do
  gem "annotate"
  gem "rubocop", require: false
  gem "rubocop-rails", require: false
  gem "rubocop-thread_safety", require: false
end
