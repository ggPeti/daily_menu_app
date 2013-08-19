# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'daily_menu_app/version'

Gem::Specification.new do |spec|
  spec.name          = 'daily_menu_app'
  spec.version       = DailyMenuApp::VERSION
  spec.authors       = ['Karaszi István']
  spec.email         = ['github@spam.raszi.hu']
  spec.description   = %q{This is the application for fetching daily menus}
  spec.summary       = %q{}

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ['lib']

  spec.required_ruby_version = '>= 2.0.0'

  spec.add_dependency 'daily_menu', '~> 0.0.3'
  spec.add_dependency 'sinatra'
  spec.add_dependency 'memcachier'
  spec.add_dependency 'dalli'
  spec.add_dependency 'rack-cache'
  spec.add_dependency 'thin'

  spec.add_development_dependency 'bundler'
  spec.add_development_dependency 'rake'
  spec.add_development_dependency 'rspec'
  spec.add_development_dependency 'rubocop'
  spec.add_development_dependency 'rack-test'
  spec.add_development_dependency 'simplecov'
end
