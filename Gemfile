source "https://rubygems.org"

basedir = File.dirname(__FILE__)

gem 'ZenTest', '4.3.0'
gem 'riot', :require => false

gem 'faraday'
gem 'faraday_middleware', :group => 'test'
gem 'activesupport'
gem 'jruby-openssl', :platform => 'jruby'
gem 'json'
gem 'rake'
gem 'elasticsearch-node'

gem 'eson', :path => File.join(basedir, "eson"), :require => false
gem 'eson-core', :path => File.join(basedir, "eson-core"), :require => false
gem 'eson-more', :path => File.join(basedir, "eson-more"), :require => false
gem 'eson-http', :path => File.join(basedir, "eson-http"), :require => false
gem 'eson-dsl', :path => File.join(basedir, "eson-dsl"), :require => false

group :test do
  gem 'rspec', '~> 3.1'
  gem 'rspec-its'
  gem 'simplecov'
  gem 'simplecov-console'
end
