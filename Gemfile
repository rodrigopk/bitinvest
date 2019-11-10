ruby '2.5.1'

source 'https://rubygems.org'

gem 'rails'
gem 'faker'
gem 'bcrypt'
gem 'will_paginate'
gem 'bootstrap-will_paginate'
gem 'rack'
gem 'mini_magick'
gem 'fog'
gem 'bootstrap-sass'
gem 'sass-rails'
gem 'uglifier'
gem 'coffee-rails'
gem 'jquery-rails'
gem 'turbolinks'
gem 'jbuilder'
gem 'sdoc' , :group => :doc
gem 'whenever' #cronjobs
gem 'sidekiq'
gem 'sidekiq-client-cli' #to run sidekiq with whenever
gem 'slim'
gem 'sinatra', :require => nil #interface
gem 'sidekiq-middleware' #handle locks
gem 'http_accept_language'
gem 'faraday'
gem 'rest-client'
gem 'highstock-rails'


group :development, :test do
  gem 'sqlite3'
  gem 'byebug'
  gem 'web-console'
  gem 'spring'
end

group :test do
  gem 'minitest-reporters'
  gem 'mini_backtrace'
  gem 'guard-minitest'
end

group :production do
  gem 'pg'
  gem 'rails_12factor'
  gem 'puma'
end
