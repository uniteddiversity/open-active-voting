source 'http://rubygems.org'

ruby '2.1.5'
gem 'rails', '3.2.20'
gem 'globalize', '~> 3.0.0'
# Gems used in all environments including production
gem "airbrake" # Online error reporting system
gem 'haml' # generate html from templates
gem 'jquery-rails' # Jquery for Rails
gem 'mysql2' # The Mysql Driver
gem 'dalli' # Memcache driver
gem 'capistrano' # Used to manage deployments to staging servers
gem 'nokogiri','1.6.5' # XML/HTML Parsing library
gem 'psych', '1.2.2'
gem 'soap4r', :git => 'https://github.com/rbjarnason/soap4r.git'
gem 'ruby-saml',  :git => 'https://github.com/rbjarnason/ruby-saml.git', :ref=>"63ce604db2e562eeb25467e7e1655d16bab7d9cb"
gem 'memcachier'
gem "passenger"

# Gems used only for assets and not required
# in production environments by default.
group :assets do
  gem 'execjs'
  gem 'therubyracer'
  gem 'sass-rails'
  gem 'uglifier'
end

group :development, :test do
  # Pretty printed test output
  #gem 'waitr'
  gem 'awesome_print'
  gem 'watir-webdriver'
  gem 'headless'
  gem 'turn', '~> 0.8.3', :require => false
end
