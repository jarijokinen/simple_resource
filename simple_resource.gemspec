# -*- encoding: utf-8 -*-
lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "simple_resource/version"

Gem::Specification.new do |gem|
  gem.name          = "simple_resource"
  gem.version       = SimpleResource::VERSION
  gem.authors       = ["Jari Jokinen"]
  gem.email         = ["info@jarijokinen.com"]
  gem.summary       = "Simplified resource handling for Rails."
  gem.description   = "SimpleResource speeds up development of standard Rails applications by integrating Inherited Resources, inherited views and form builders together."
  gem.homepage      = "https://github.com/jarijokinen/simple_resource"
  
  gem.files         = `git ls-files`.split($/)
  gem.test_files    = gem.files.grep(%r{^spec/})
  gem.require_paths = ["lib"]

#  gem.add_dependency "rails", "~> 4.0.0.beta1"
  gem.add_dependency "inherited_resources"

  gem.add_development_dependency "capybara", "1.1.4"
  gem.add_development_dependency "database_cleaner"
  gem.add_development_dependency "factory_girl_rails"
  gem.add_development_dependency "forgery"
  gem.add_development_dependency "guard-rspec"
  gem.add_development_dependency "guard-spork"
  gem.add_development_dependency "launchy"
  gem.add_development_dependency "rb-inotify"
  gem.add_development_dependency "rspec-rails"
  gem.add_development_dependency "spork-rails"
  gem.add_development_dependency "sqlite3"
end
